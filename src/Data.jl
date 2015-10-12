module Data

using DataFrames, MacroTools

Base.call{T<:Number}(x::T, y) = x*y

include("typeddicts.jl")
include("datasets.jl")

end # module
