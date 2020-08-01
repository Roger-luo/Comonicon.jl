using Comonicon
using Test
using Pkg
using SimpleMock
using PackageCompiler
using Comonicon.PATH
using Comonicon.BuildTools
using Comonicon.BuildTools: write_path, contain_comonicon_path, contain_comonicon_fpath,
    read_toml

Pkg.develop(PackageSpec(path=PATH.project("test", "Foo")))
using Foo

rcfile_content = """
some words
# generated by Comonicon
# Julia bin PATH
export PATH="$(homedir())/.julia/bin:\$PATH"\n
# generated by Comonicon
# Julia autocompletion PATH
export FPATH="$(homedir())/.julia/completions:\$FPATH"
"""

rcfile = tempname()
rm(rcfile, force=true)
write(rcfile, "some words")
write_path(rcfile, true, Dict())
@test strip(read(rcfile, String)) == strip(rcfile_content)

# using Comonicon.BuildTools: read_toml

# using Foo

# Foo.command_main(String[])

# read_toml(PATH.project("test", "Comonicon.toml"))


@test_throws ErrorException Comonicon.install(Foo)

d = Dict(
    "name" => "foo",
    "download" => Dict(
        "repo" => "Foo.jl",
        "host" => "github.com",
        "user" => "Roger-luo",
    ),
    "install" => Dict(
        "optimize"=>2,
        "quiet"=>false,
        "export_path"=>true,
        "completion"=>true,
        "compile"=>"min",
    ),
    "sysimg" => Dict(
        "filter_stdlibs"=>false,
        "cpu_target"=>"native",
        "incremental"=>true,
        "path"=>"deps/lib",
    )
)

@test d == read_toml(Foo)

Comonicon.build(Foo, false; bin=PATH.project("test", "bin"), quiet=true, export_path=false)
@test isfile(PATH.project("test", "bin", "foo"))
@test isfile(PATH.project("test", "bin", "foo.jl"))


mock(create_sysimage) do plus
    @assert plus isa Mock
    Comonicon.build(Foo, true; bin=PATH.project("test", "bin"), quiet=true, export_path=false)
end

@test ispath(PATH.project("test", "Foo", "deps"))

empty!(ARGS)
push!(ARGS, "sysimg")
mock(create_sysimage) do plus
    @assert plus isa Mock
    Comonicon.install(Foo; bin=PATH.project("test", "bin"), quiet=true, export_path=false)
end

@test isfile(PATH.project("test", "Foo", "deps", BuildTools.tarball_name("foo")))
