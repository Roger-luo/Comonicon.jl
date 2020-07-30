using Comonicon.Types
using Comonicon.CodeGen
using Test

function test_sin(theta; foo = 1.0)
    @test theta == "1.0"
    @test foo == "2.0"
end

function test_cos(theta::AbstractFloat)
    @test theta == 2.0
end

function test_tanh(theta::Real)
    @test theta == 3.0
end


opt = Option("foo", Arg("theta"); short = true, doc = "sadasd aasdas dsadas dasdasdasd asdasdas")
cmd_sin = LeafCommand(
    test_sin;
    args = [Arg("theta")],
    options = [opt],
    doc = "sdasdbsa dasdioasdmasd dsadas",
)
cmd_cos = LeafCommand(
    test_cos;
    args = [Arg("theta"; type = AbstractFloat)],
    doc = "dasdas dasidjmoasid dasdasd dasdasd dasd dasd",
)
cmd1 = NodeCommand("foo", [cmd_sin, cmd_cos]; doc = "asdasd asdasd asd asdasd asdas asdasd dasdas")
cmd2 = NodeCommand(
    "goosadas",
    [LeafCommand(test_tanh; args = [Arg("theta"; type = Real)])],
    doc = "asdasdasdasdfunuikasnsdasdasdasdas",
)
cmd = NodeCommand("dummy", [cmd1, cmd2]; doc = "dasdasdujkink asdas dasdas das dasd asdasd adsd as")
entry = EntryCommand(cmd)
eval(codegen(entry))

@test command_main(["foo", "test_cos", "2"]) == 0
@test command_main(["foo", "test_sin", "1.0", "--foo=2.0"]) == 0
@test command_main(["foo", "test_sin", "1.0", "--foo", "2.0"]) == 0
@test command_main(["foo", "test_sin", "1.0", "-f2.0"]) == 0

@testset "prettify" begin
    ex1 = quote
        if x > 0
            begin
                x += 1
            end
        end
    end

    ex2 = quote
        if x > 0
            x += 1
        end
    end

    @test prettify(ex1) == prettify(ex2)
end

module Issue23

using Comonicon, Test

@cast function run(host = "127.0.0.1"; port::Int = 1234, launchbrowser::Bool = false)
    @test host == "127.0.0.1"
    @test port == 2345
end

@main name = "pluto" doc = "Pluto CLI - Lightweight reactive notebooks for Julia"
end

Issue23.command_main(["run", "--port", "2345"])
