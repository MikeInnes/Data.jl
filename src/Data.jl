module Data

using MacroTools

Base.call{T<:Number}(x::T, y) = x*y

include("vartypes.jl")
include("nulls.jl")
include("typeddicts.jl")
include("datasets.jl")
include("views.jl")
include("compat.jl")

end # module
