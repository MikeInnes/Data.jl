module Data

using MacroTools

Base.call{T<:Number}(x::T, y) = x*y

include("misc.jl")

include("arrays/nulls.jl")
include("arrays/pooled.jl")

include("tables/typeddicts.jl")
include("tables/datasets.jl")
include("tables/views.jl")
include("tables/compat.jl")

end # module
