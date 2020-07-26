const CACHE_FLAG = Ref{Bool}(true)

function enable_cache()
    CACHE_FLAG[] = true
    return
end

function disable_cache()
    CACHE_FLAG[] = false
    return
end

macro cast(ex)
    if CACHE_FLAG[] && iscached()
        return esc(ex)
    else
        return esc(cast_m(__module__, ex))
    end
end

function cast_m(m, ex)
    ret = Expr(:block)
    pushmaybe!(ret, create_casted_commands(m))

    if ex isa Symbol
        push!(ret.args, parse_module(m, ex))
        return ret
    end

    def = splitdef(ex; throw=false)
    if def === nothing
        push!(ret.args, parse_module(m, ex))
        return ret
    end

    push!(ret.args, parse_function(m, ex, def))
    return ret
end

function parse_function(m, ex, def)
    haskey(def, :name) || error("command entry cannot be annoymous")
    def[:name] isa Symbol || error("command name should be a Symbol")

    return quote
        $ex
        Core.@__doc__ $(def[:name])
        $(xcall(set_cmd!, casted_commands(m), xcall(command, def[:name], parse_args(def), parse_kwargs(def))))
    end
end

function parse_module(m, ex::Expr)
    ex.head === :module || throw(Meta.ParseError("invalid expression, can only cast functions or modules"))

    return quote
        $ex
        $(xcall(set_cmd!, casted_commands(m), xcall(command, ex.args[2])))
    end
end

function parse_module(m, ex::Symbol)
    return xcall(set_cmd!, casted_commands(m), xcall(command, ex))
end

function parse_args(def)
    types = Expr(:vect)
    haskey(def, :args) || return types

    # (name, type, require)
    for each in def[:args]
        push!(types.args, Expr(:tuple, to_argument(def, each)...))
    end
    return types
end

function parse_kwargs(def)
    types = Expr(:vect)
    haskey(def, :kwargs) || return types

    # (name, type, isflag)
    for each in def[:kwargs]
        push!(types.args, Expr(:tuple, to_option_or_flag(each)...))
    end
    return types
end

function to_argument(def, ex)
    @smatch ex begin
        ::Symbol => (string(ex), Any, true)
        :($name::$type) => (string(name), wrap_type(def, type), true)
        Expr(:kw, :($name::$type), _) => (string(name), wrap_type(def, type), false)
        Expr(:kw, name::Symbol, _) => (string(name), Any, false)
        _ => throw(Meta.ParseError("invalid syntax for command line entry: $ex"))
    end
end

function to_option_or_flag(ex)
    @smatch ex begin
        Expr(:kw, name::Symbol, value) => (string(name), Any, false)
        Expr(:kw, :($name::Bool), false) => (string(name), Bool, true)
        Expr(:kw, :($name::$type), value) => (string(name), type, false)
        Expr(:kw, :($name::Bool), true) => throw(Meta.ParseError("Boolean options must use false as default value, and will be parsed as flags. got $name"))
        ::Symbol || :($name::$type) => throw(Meta.ParseError("options should have default values or make it a positional argument"))
        _ => throw(Meta.ParseError("invalid syntax: $ex"))
    end
end

function wrap_type(def, type)
    if haskey(def, :whereparams)
        return Expr(:where, type, def[:whereparams]...)
    else
        return type
    end
end

function create_casted_commands(m)
    if isdefined(m, :CASTED_COMMANDS)
        return
    else
        return :(const CASTED_COMMANDS = Dict{String,Any}())
    end
end

casted_commands(m) = GlobalRef(m, :CASTED_COMMANDS)

# Entry
macro main(xs...)
    return esc(main_m(__module__, xs...))
end

function main_m(m, ex::Expr)
    if CACHE_FLAG[] && iscached()
        return quote
            Core.@__doc__ $ex
            include($(cachefile()[1]))
        end
    end

    ex.head === :(=) && return create_entry(m, ex)

    ret = Expr(:block)
    def = splitdef(ex; throw=false)
    var_cmd, var_entry = gensym(:cmd), gensym(:entry)
    push!(ret.args, ex)

    if def === nothing
        ex.head === :module || throw(Meta.ParseError("invalid expression, can only cast functions or modules"))
        cmd = xcall(command, ex.args[2]; name="main")
        push!(ret.args, :($var_cmd = $cmd))
    else
        push!(ret.args, :(Core.@__doc__ $(def[:name])))
        cmd = xcall(command, def[:name], parse_args(def), parse_kwargs(def); name="main")
        push!(ret.args, :($var_cmd = $cmd))
    end

    push!(ret.args, :($var_entry = $(xcall(Types, :EntryCommand, var_cmd))))
    push!(ret.args, precompile_or_exec(m, var_entry))
    return ret
end

function main_m(m, ex::Symbol)
    CACHE_FLAG[] && iscached() && return :(include($(cachefile()[1])))
    var_cmd, var_entry =gensym(:cmd), gensym(:entry)
    quote
        $var_cmd = $(xcall(command, ex; name="main"))
        $var_entry = $(xcall(Types, :EntryCommand, var_cmd))
        $(precompile_or_exec(m, var_entry))
    end
end

function main_m(m, kwargs...)
    CACHE_FLAG[] && iscached() && return :(include($(cachefile()[1])))
    return create_entry(m, kwargs...)
end

function create_entry(m, kwargs...)
    configs = Dict{Symbol,Any}(:name => default_name(m), :version => get_version(m), :doc => "")
    for kw in kwargs
        for key in [:name, :version, :doc]
            if kw.args[1] === key
                configs[key] = kw.args[2]
            end
        end
    end

    ret = Expr(:block)
    pushmaybe!(ret.args, create_casted_commands(m))
    
    var_cmd, var_entry =gensym(:cmd), gensym(:entry)
    cmd = xcall(Types, :NodeCommand, configs[:name], :(collect(values($m.CASTED_COMMANDS))), configs[:doc])
    entry = xcall(Types, :EntryCommand, var_cmd, configs[:version])

    push!(ret.args, :($var_cmd = $cmd))
    push!(ret.args, :($var_entry = $entry))
    push!(ret.args, xcall(set_cmd!, casted_commands(m), var_entry, "main"))
    push!(ret.args, precompile_or_exec(m, var_entry))
    return ret
end

function precompile_or_exec(m, entry)
    if m == Main && CACHE_FLAG[]
        return quote
            $create_cache($entry)
            include($(cachefile()[1]))
        end
    elseif m == Main
        return quote
            $(xcall(m, :eval, xcall(CodeGen, :codegen, entry)))
            command_main()
        end
    else
        quote
            $(xcall(m, :eval, xcall(CodeGen, :codegen, entry)))
            precompile(Tuple{typeof($m.command_main),Array{String,1}})
        end
    end
end
