export vartype, vareltype, Categorical, Ordinal, Continuous, DataSet

type Categorical end
type Ordinal end
type Continuous end

vartype(::DataType) = Categorical()
vartype{T<:Number}(::Type{T}) = Continuous()
vartype(x) = vartype(typeof(x))
vareltype(xs) = vartype(eltype(xs))
