function _precompile_()
    ccall(:jl_generating_output, Cint, ()) == 1 || return nothing
    isdefined(Comonicon, Symbol("##LeafCommand#11")) && precompile(Tuple{
        getfield(Comonicon.Types, Symbol("##LeafCommand#11")),
        String,
        Array{Comonicon.Types.Arg,1},
        Array{Comonicon.Types.Option,1},
        Array{Comonicon.Types.Flag,1},
        Comonicon.Types.CommandDoc,
        LineNumberNode,
        Type{Comonicon.Types.LeafCommand},
        typeof(identity),
    })
    isdefined(Comonicon, Symbol("##LeafCommand#11")) && precompile(Tuple{
        getfield(Comonicon.Types, Symbol("##LeafCommand#11")),
        String,
        Array{Comonicon.Types.Arg,1},
        Array{Comonicon.Types.Option,1},
        Array{Comonicon.Types.Flag,1},
        String,
        LineNumberNode,
        Type{Comonicon.Types.LeafCommand},
        typeof(identity),
    })
    isdefined(Comonicon, Symbol("##partition#12")) && precompile(Tuple{
        getfield(Comonicon.Types, Symbol("##partition#12")),
        Int64,
        typeof(Comonicon.Types.partition),
        Base.IOContext{Base.GenericIOBuffer{Array{UInt8,1}}},
        Comonicon.Types.Arg,
        String,
        String,
    })
    isdefined(Comonicon, Symbol("##partition#12")) && precompile(Tuple{
        getfield(Comonicon.Types, Symbol("##partition#12")),
        Int64,
        typeof(Comonicon.Types.partition),
        Base.IOContext{Base.GenericIOBuffer{Array{UInt8,1}}},
        Comonicon.Types.Flag,
        String,
        String,
    })
    isdefined(Comonicon, Symbol("##partition#12")) && precompile(Tuple{
        getfield(Comonicon.Types, Symbol("##partition#12")),
        Int64,
        typeof(Comonicon.Types.partition),
        Base.IOContext{Base.GenericIOBuffer{Array{UInt8,1}}},
        Comonicon.Types.LeafCommand,
        String,
    })
    isdefined(Comonicon, Symbol("##partition#12")) && precompile(Tuple{
        getfield(Comonicon.Types, Symbol("##partition#12")),
        Int64,
        typeof(Comonicon.Types.partition),
        Base.IOContext{Base.GenericIOBuffer{Array{UInt8,1}}},
        Comonicon.Types.NodeCommand,
        String,
    })
    isdefined(Comonicon, Symbol("##partition#12")) && precompile(Tuple{
        getfield(Comonicon.Types, Symbol("##partition#12")),
        Int64,
        typeof(Comonicon.Types.partition),
        Base.IOContext{Base.GenericIOBuffer{Array{UInt8,1}}},
        Comonicon.Types.Option,
        String,
        String,
    })
    isdefined(Comonicon, Symbol("##xcall#6")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("##xcall#6")),
        Base.Iterators.Pairs{Symbol,QuoteNode,Tuple{Symbol},NamedTuple{(:line,),Tuple{QuoteNode}}},
        typeof(Comonicon.Parse.xcall),
        Module,
        typeof(identity),
        Symbol,
        Int,
    })
    isdefined(Comonicon, Symbol("##xcall#7")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("##xcall#7")),
        Base.Iterators.Pairs{Symbol,QuoteNode,Tuple{Symbol},NamedTuple{(:line,),Tuple{QuoteNode}}},
        typeof(Comonicon.Parse.xcall),
        Module,
        Symbol,
        Symbol,
        Int,
    })
    isdefined(Comonicon, Symbol("##xcall#7")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("##xcall#7")),
        Base.Iterators.Pairs{Union{},Union{},Tuple{},NamedTuple{(),Tuple{}}},
        typeof(Comonicon.Parse.xcall),
        Module,
        Symbol,
        String,
        Int,
    })
    isdefined(Comonicon, Symbol("##xcall#8")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("##xcall#8")),
        Base.Iterators.Pairs{Symbol,QuoteNode,Tuple{Symbol},NamedTuple{(:line,),Tuple{QuoteNode}}},
        typeof(Comonicon.Parse.xcall),
        typeof(identity),
        Symbol,
        Int,
    })
    isdefined(Comonicon, Symbol("##xcall#9")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("##xcall#9")),
        Base.Iterators.Pairs{Symbol,QuoteNode,Tuple{Symbol},NamedTuple{(:line,),Tuple{QuoteNode}}},
        typeof(Comonicon.Parse.xcall),
        GlobalRef,
        Symbol,
        Int,
    })
    isdefined(Comonicon, Symbol("##xcall#9")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("##xcall#9")),
        Base.Iterators.Pairs{Union{},Union{},Tuple{},NamedTuple{(),Tuple{}}},
        typeof(Comonicon.Parse.xcall),
        GlobalRef,
        GlobalRef,
        Int,
    })
    isdefined(Comonicon, Symbol("##xcall#9")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("##xcall#9")),
        Base.Iterators.Pairs{Union{},Union{},Tuple{},NamedTuple{(),Tuple{}}},
        typeof(Comonicon.Parse.xcall),
        GlobalRef,
        String,
        Int,
    })
    isdefined(Comonicon, Symbol("#@cast")) &&
        precompile(Tuple{getfield(Comonicon.Parse, Symbol("#@cast")),LineNumberNode,Module,Int})
    isdefined(Comonicon, Symbol("#@main")) &&
        precompile(Tuple{getfield(Comonicon.Parse, Symbol("#@main")),LineNumberNode,Module,Int})
    isdefined(Comonicon, Symbol("#cmd_script##kw")) && precompile(Tuple{
        getfield(Comonicon, Symbol("#cmd_script##kw")),
        NamedTuple{
            (:exename, :project, :sysimg, :compile, :optimize),
            Tuple{String,String,Nothing,Nothing,Int64},
        },
        typeof(Comonicon.cmd_script),
        Module,
        String,
    })
    isdefined(Comonicon, Symbol("#command##kw")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("#command##kw")),
        NamedTuple{(:line,),Tuple{LineNumberNode}},
        typeof(Comonicon.Parse.command),
        typeof(identity),
        Array{Tuple{String,DataType,Bool},1},
        Array{Any,1},
    })
    isdefined(Comonicon, Symbol("#command##kw")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("#command##kw")),
        NamedTuple{(:line,),Tuple{LineNumberNode}},
        typeof(Comonicon.Parse.command),
        typeof(identity),
        Array{Tuple{String,DataType,Bool},1},
        Array{Tuple{String,DataType,Bool},1},
    })
    isdefined(Comonicon, Symbol("#install##kw")) && precompile(Tuple{
        getfield(Comonicon, Symbol("#install##kw")),
        NamedTuple{(:bin, :completion),Tuple{String,Bool}},
        typeof(Comonicon.install),
        Module,
    })
    isdefined(Comonicon, Symbol("#xcall##kw")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("#xcall##kw")),
        NamedTuple{(:line,),Tuple{QuoteNode}},
        typeof(Comonicon.Parse.xcall),
        GlobalRef,
        Symbol,
        Expr,
        Expr,
    })
    isdefined(Comonicon, Symbol("#xcall##kw")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("#xcall##kw")),
        NamedTuple{(:line,),Tuple{QuoteNode}},
        typeof(Comonicon.Parse.xcall),
        Module,
        Symbol,
        Symbol,
        Int,
    })
    isdefined(Comonicon, Symbol("#xcall##kw")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("#xcall##kw")),
        NamedTuple{(:line,),Tuple{QuoteNode}},
        typeof(Comonicon.Parse.xcall),
        Module,
        typeof(identity),
        Symbol,
        Int,
    })
    isdefined(Comonicon, Symbol("#xcall##kw")) && precompile(Tuple{
        getfield(Comonicon.Parse, Symbol("#xcall##kw")),
        NamedTuple{(:line,),Tuple{QuoteNode}},
        typeof(Comonicon.Parse.xcall),
        typeof(identity),
        Symbol,
        Expr,
        Expr,
    })
    precompile(Tuple{
        typeof(Comonicon.CodeGen.codegen),
        Comonicon.CodeGen.ASTCtx,
        Comonicon.Types.LeafCommand,
    })
    precompile(Tuple{
        typeof(Comonicon.CodeGen.codegen),
        Comonicon.CodeGen.ASTCtx,
        Comonicon.Types.NodeCommand,
    })
    precompile(Tuple{
        typeof(Comonicon.CodeGen.codegen),
        Comonicon.CodeGen.ZSHCompletionCtx,
        Comonicon.Types.EntryCommand,
    })
    precompile(Tuple{typeof(Comonicon.CodeGen.codegen),Comonicon.Types.EntryCommand})
    precompile(Tuple{typeof(Comonicon.CodeGen.prettify),Expr})
    precompile(Tuple{typeof(Comonicon.CodeGen.prettify),Int64})
    precompile(Tuple{typeof(Comonicon.CodeGen.prettify),Symbol})
    precompile(Tuple{typeof(Comonicon.CodeGen.rm_lineinfo),Int64})
    precompile(Tuple{typeof(Comonicon.CodeGen.rm_lineinfo),Symbol})
    precompile(Tuple{typeof(Comonicon.CodeGen.xparse_args),Type{Int},Expr})
    precompile(Tuple{typeof(Comonicon.CodeGen.xparse_args),Type{Int},Int64})
    precompile(Tuple{typeof(Comonicon.PATH.project),Module,String,String})
    precompile(Tuple{typeof(Comonicon.PATH.project),String,String,String})
    precompile(Tuple{typeof(Comonicon.PATH.project),String,String})
    precompile(Tuple{typeof(Comonicon.Parse.cast_m),Module,QuoteNode,Expr})
    precompile(Tuple{typeof(Comonicon.Parse.create_entry),Module,QuoteNode,Expr,Expr})
    precompile(Tuple{
        typeof(Comonicon.Parse.create_option),
        String,
        Type{Int},
        Base.Dict{String,Tuple{String,String,Bool}},
        LineNumberNode,
    })
    precompile(Tuple{typeof(Comonicon.Parse.disable_cache)})
    precompile(Tuple{typeof(Comonicon.Parse.main_m),Module,QuoteNode,Expr,Expr})
    precompile(Tuple{typeof(Comonicon.Parse.main_m),Module,QuoteNode,Expr})
    precompile(Tuple{typeof(Comonicon.Parse.read_doc),Markdown.MD})
    precompile(Tuple{
        typeof(Comonicon.Parse.set_cmd!),
        Base.Dict{String,Any},
        Comonicon.Types.EntryCommand,
        String,
    })
    precompile(Tuple{
        typeof(Comonicon.Parse.set_cmd!),
        Base.Dict{String,Any},
        Comonicon.Types.LeafCommand,
    })
    precompile(Tuple{typeof(Comonicon.Parse.to_argument),Base.Dict{Symbol,Any},Expr})
    precompile(Tuple{typeof(Comonicon.Parse.to_argument),Base.Dict{Symbol,Any},Symbol})
    precompile(Tuple{typeof(Comonicon.Parse.to_option_or_flag),Expr})
    precompile(Tuple{typeof(Comonicon.Parse.xcall),GlobalRef,String,QuoteNode,Int})
    precompile(Tuple{typeof(Comonicon.Parse.xcall),Module,Symbol,String,Int})
    precompile(Tuple{typeof(Comonicon.Types.cmd_doc),Comonicon.Types.LeafCommand})
    precompile(Tuple{typeof(Comonicon.Types.cmd_doc),Comonicon.Types.NodeCommand})
    precompile(Tuple{typeof(Comonicon.Types.cmd_name),Comonicon.Types.LeafCommand})
    precompile(Tuple{typeof(Comonicon.Types.cmd_name),Comonicon.Types.NodeCommand})
    precompile(Tuple{typeof(Comonicon.Types.ignore_type),Type{Int}})
    precompile(Tuple{
        typeof(Comonicon.Types.partition),
        Base.IOContext{Base.GenericIOBuffer{Array{UInt8,1}}},
        Comonicon.Types.Arg,
        String,
        String,
    })
    precompile(Tuple{
        typeof(Comonicon.Types.partition),
        Base.IOContext{Base.GenericIOBuffer{Array{UInt8,1}}},
        Comonicon.Types.Flag,
        String,
        String,
    })
    precompile(Tuple{
        typeof(Comonicon.Types.partition),
        Base.IOContext{Base.GenericIOBuffer{Array{UInt8,1}}},
        Comonicon.Types.Option,
        String,
        String,
    })
    precompile(Tuple{
        typeof(Comonicon.Types.print_cmd),
        Base.IOContext{Base.GenericIOBuffer{Array{UInt8,1}}},
        Comonicon.Types.EntryCommand,
    })
    precompile(Tuple{
        typeof(Comonicon.Types.print_cmd),
        Base.IOContext{Base.GenericIOBuffer{Array{UInt8,1}}},
        Comonicon.Types.LeafCommand,
    })
    precompile(Tuple{
        typeof(Comonicon.Types.print_cmd),
        Base.IOContext{Base.GenericIOBuffer{Array{UInt8,1}}},
        Comonicon.Types.NodeCommand,
    })
    precompile(Tuple{typeof(Comonicon.precompile_script),Module})
end
