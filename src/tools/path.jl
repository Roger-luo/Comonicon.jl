"""
path related functions.
"""
module PATH
using Libdl
using Pkg
using ..Comonicon

function project(m::Module, xs...)
    path = pathof(m)
    path === nothing && return dirname(Pkg.project().path)
    return joinpath(dirname(dirname(path)), xs...)
end

project(xs...) = project(Comonicon, xs...)

sysimg() = "libcomonicon.$(Libdl.dlext)"
sysimg(name) = "lib$name.$(Libdl.dlext)"

"""
    default_exename()

Default Julia executable name: `joinpath(Sys.BINDIR, Base.julia_exename())`
"""
default_exename() = joinpath(Sys.BINDIR, Base.julia_exename())

"""
    default_julia_bin()

Return the default path to `.julia/bin`.
"""
default_julia_bin() = joinpath(first(DEPOT_PATH), "bin")

"""
    default_julia_fpath()

Return the default path to `.julia/completions`
"""
default_julia_fpath() = joinpath(first(DEPOT_PATH), "completions")

"""
    default_name(x)

Return the lowercase of `nameof(x)` in `String`.
"""
default_name(x) = lowercase(string(nameof(x)))

"""
    default_name(x)

Return the lowercase of a given package name. It will
ignore the suffix if it ends with ".jl".
"""
function default_name(x::String)
    if endswith(x, ".jl")
        name = x[1:end-3]
    else
        name = x
    end
    return lowercase(name)
end

struct Asset
    package::Union{Nothing, String}
    path::String
end

function Asset(s::String)
    parts = strip.(split(s, ":"))

    if length(parts) == 1
        return Asset(nothing, parts[1])
    elseif length(parts) == 2
        return Asset(parts[1], parts[2])
    else
        error("invalid asset path syntax: $s")
    end
end

function Base.show(io::IO, x::Asset)
    print(io, "asset\"", )
    if x.package === nothing
        print(io, x.path)
    else
        print(io, x.package, ": ", x.path)
    end
    print(io, "\"")
end

macro asset_str(s::String)
    return Asset(s)
end

end
