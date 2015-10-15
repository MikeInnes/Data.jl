export vartype, vareltype, Categorical, Ordinal, Continuous

type Categorical end
type Ordinal end
type Continuous end

vartype(::Type) = Categorical()
vartype{T<:Number}(::Type{T}) = Continuous()
vartype(x) = vartype(typeof(x))
vareltype(xs) = vartype(eltype(xs))

typealias Indexes{T<:Integer} AbstractVector{T}
