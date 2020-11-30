module Options

export read_configs
using TOML
using Configurations
using ..Comonicon.PATH
using ..Comonicon: @asset_str, Asset

const COMONICON_TOML = ["Comonicon.toml", "JuliaComonicon.toml"]

"""
    Install

Installation configurations.

## Keywords

- `path`: installation path.
- `completion`: set to `true` to install shell auto-completion scripts.
- `quiet`: print logs or not, default is `false`.
- `compile`: julia compiler option for CLIs if not built as standalone application, default is "min".
- `optimize`: julia compiler option for CLIs if not built as standalone application, default is `2`.
"""
@option struct Install
    path::String = "~/.julia"
    completion::Bool = true
    quiet::Bool = false
    compile::String = "yes"
    optimize::Int = 2
end

"""
    Precompile

Precompilation files for `PackageCompiler`.

## Keywords

- `execution_file`: precompile execution file.
- `statements_file`: precompile statements file.
"""
@option struct Precompile
    execution_file::Vector{String} = String[]
    statements_file::Vector{String} = String[]
end

# See https://github.com/JuliaCI/julia-buildbot/blob/489ad6dee5f1e8f2ad341397dc15bb4fce436b26/master/inventory.py
function default_app_cpu_target()
    if Sys.ARCH === :i686
        return "pentium4;sandybridge,-xsaveopt,clone_all"
    elseif Sys.ARCH === :x86_64
        return "generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)"
    elseif Sys.ARCH === :arm
        return "armv7-a;armv7-a,neon;armv7-a,neon,vfp4"
    elseif Sys.ARCH === :aarch64
        return "generic" # is this really the best here?
    elseif Sys.ARCH === :powerpc64le
        return "pwr8"
    else
        return "generic"
    end
end

"""
    SysImg

System image build configurations.

## Keywords

- `path`: system image path to generate into, default is "deps/lib".
- `incremental`: set to `true` to build incrementally, default is `true`.
- `filter_stdlibs`: set to `true` to filter out unused stdlibs, default is `false`.
- `cpu_target`: cpu target to build, default is `PackageCompiler.default_app_cpu_target()`.
- `precompile`: precompile configurations, see [`Precompile`](@ref), default is `Precompile()`.
"""
@option struct SysImg
    path::String = "deps"
    incremental::Bool = true
    filter_stdlibs::Bool = false
    cpu_target::String = default_app_cpu_target()
    precompile::Precompile = Precompile()
end

"""
    Download

Download information.

## Keywords

- `host`: where are the tarballs hosted, default is "github.com"
- `user`: required, user name on the host.
- `repo`: required, repo name on the host.

!!! note
    Currently this only supports github, and this is considered experimental.
"""
@option struct Download
    host::String = "github.com"
    user::String
    repo::String
end

"""
    Application

Application build configurations.

## Keywords

- `path`: application build path, default is "build".
- `incremental`: set to `true` to build incrementally, default is `true`.
- `filter_stdlibs`: set to `true` to filter out unused stdlibs, default is `false`.
- `cpu_target`: cpu target to build, default is `PackageCompiler.default_app_cpu_target()`.
- `precompile`: precompile configurations, see [`Precompile`](@ref), default is `Precompile()`.
- `c_driver_program`: driver program.
"""
@option struct Application
    path::String = "build"
    assets::Vector{Asset} = Asset[]
    incremental::Bool = false
    filter_stdlibs::Bool = true
    cpu_target::String = default_app_cpu_target()
    precompile::Precompile = Precompile()
    c_driver_program::Union{String,Nothing} = nothing
end

"""
    Comonicon <: AbstractConfiguration

Build configurations for Comonicon. One can set this option
via `Comonicon.toml` under the root path of a Julia
project directory and read in using [`read_configs`](@ref).

## Keywords

- `name`: required, the name of CLI file to install.
- `install`: installation options, see also [`Install`](@ref).
- `sysimg`: system image build options, see also [`SysImg`](@ref).
- `download`: download options, see also [`Download`](@ref).
- `application`: application build options, see also [`Application`](@ref).
"""
@option struct Comonicon
    name::String

    install::Install = Install()
    sysimg::Union{SysImg,Nothing} = nothing
    download::Union{Download,Nothing} = nothing
    application::Union{Application,Nothing} = nothing
end

function validate(options::Comonicon)
    if options.sysimg !== nothing
        isabspath(options.sysimg.path) && error("system image path must be project relative")
    end

    if options.application !== nothing
        isabspath(options.application.path) && error("application build path must project relative")
    end
    return
end

"""
    find_comonicon_toml(path::String)

Find `Comonicon.toml` or `JuliaComonicon.toml` in given path.
"""
function find_comonicon_toml(path::String)
    # user input file path
    basename(path) in COMONICON_TOML && return path

    # user input dir path
    for file in COMONICON_TOML
        path = joinpath(path, file)
        if ispath(path)
            return path
        end
    end
    return
end

"""
    read_toml(path::String)

Read `Comonicon.toml` or `JuliaComonicon.toml` in given path.
"""
function read_toml(path::String)
    file = find_comonicon_toml(path)
    file === nothing && return Dict{String,Any}()
    return TOML.parsefile(file)
end

"""
    read_toml(mod::Module)

Read `Comonicon.toml` or `JuliaComonicon.toml` in given module's project path.
"""
function read_toml(mod::Module)
    return read_toml(PATH.project(mod))
end

"""
    read_configs(comonicon; kwargs...)

Read in Comonicon build options. The argument `comonicon` can be:

- a module of a Comonicon CLI project.
- a path to a Comonicon CLI project that contains either `JuliaComonicon.toml` or `Comonicon.toml`.
- a path to a Comonicon CLI build configuration file named either `JuliaComonicon.toml` or `Comonicon.toml`.

In some cases, you might want to change the configuration written in the TOML file temporarily, e.g for writing
build tests etc. In this case, you can modify the configuration using corresponding keyword arguments.

keyword arguments of [`Application`](@ref) and [`SysImg`](@ref) are the same, thus keys like `filter_stdlibs`
are considered ambiguous in `read_configs`, but you can specifiy them by specifiy the specific [`Application`](@ref)
or [`SysImg`](@ref) object, e.g

```julia
read_configs(MyCLI; sysimg=SysImg(filter_stdlibs=false))
```

See also [`Comonicon`](@ref), [`Install`](@ref), [`SysImg`](@ref), [`Application`](@ref),
[`Download`](@ref), [`Precompile`](@ref).
"""
function read_configs(m::Union{Module,String}; kwargs...)
    d = read_toml(m)
    if !haskey(d, "name")
        d["name"] = default_cmd_name(m)
    end

    options = from_dict(Comonicon, d; kwargs...)
    validate(options)
    return options
end

default_cmd_name(m::Module) = lowercase(string(nameof(m)))
default_cmd_name(m) = error("command name is not specified")

end # Options
