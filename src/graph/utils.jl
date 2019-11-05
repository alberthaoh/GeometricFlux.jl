using LightGraphs, MetaGraphs
using LightGraphs: AbstractGraph, inneighbors
using MetaGraphs: AbstractMetaGraph

export adjlist, getvprops, geteprops, getvalue, getpairindices, cleangraph!
function adjlist(g::AbstractGraph)
    n = nv(g)
    adj = Vector{Int}[inneighbors(g, i) for i = 1:n]
    return adj
end 

function getvprops(g::AbstractMetaGraph, p::Array{<:Pair,1})
    propsinds = getpairindices(p,[])
    nf = length(propsinds)
    n = nv(g)
    features = Array{Float64,2}(undef, nf, n)
    for (i,v) in enumerate(vertices(g))
        feature = [getvalue(keys, props(g,v)) for keys in propsinds]
        features[:,i] .= feature
    end
    return features
end


function geteprops(g::AbstractMetaGraph, p::Array{<:Pair,1}, rev::Bool=false)
    propsinds = getpairindices(p,[])
    nf = length(propsinds)
    nofv = nv(g)
    nofe = ne(g)
    features = fill(Float64(0.0), nf, nofv, nofv)
    for (i,e) in enumerate(edges(g))
        r,s = dst(e),src(e)
        feature = [getvalue(keys, props(g,Edge(s,r))) for keys in propsinds]
        rev && (s = dst(e); r = src(e))
        features[:,s,r] .= feature
    end
    return features
end

function getvalue(indices, dict)
    v = dict[indices[1]]
    if length(indices) > 1
        for i in indices[2:end]
            v = v[i]
        end
    end
    v
end

function getpairindices(p::Array{<:Pair,1}, op)
    out = []
    for i in p
        oc = vcat(op, i[1])
        if isa(i[2], Array{<:Pair,1}) 
            push!(out, getpairindices(i[2], oc)...)
        elseif isa(i[2], Nothing)
            push!(out, oc)
        end
    end
    return out
end

function cleangraph!(g)
    rnodes = []
    redges = []
    for e in edges(g)
        edgeinfo = props(g, e)
        maininfo = props(g, src(e))
        neiginfo = props(g, dst(e))
        (edgeinfo[:dist] == -1.0) && push!(redges, e)
        ((maininfo[:nodeev][:ucRsrpRslt] == -1) | (maininfo[:cellsinfo] == -1 )) && push!(rnodes, src(e))
        ((neiginfo[:nodeev][:ucRsrpRslt] == -1) | (neiginfo[:cellsinfo] == -1)) && push!(rnodes, dst(e))
    end
    for n in vertices(g)
        maininfo = props(g,n)
        ((maininfo[:nodeev][:ucRsrpRslt] == -1) | (maininfo[:cellsinfo] == -1 )) && push!(rnodes, n)
    end
    for e in union(redges)
        rem_edge!(g,e)
    end
    for n in union(rnodes)
        rem_vertex!(g, n)
    end
end