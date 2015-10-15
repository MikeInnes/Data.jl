import Base: getindex, convert, sub, names

export PooledVector

immutable PooledVector{T, D<:Indexes} <: AbstractVector{T}
  values::Vector{T}
  data::D
end

function PooledVector(xs::AbstractVector)
  values = unique(xs)
  data = Array(Int, length(xs))
  for i = 1:length(xs)
    for j = 1:length(values)
      if xs[i] == values[j]
        data[i] = j
        break
      end
    end
  end
  return PooledVector(values, data)
end

sub(xs::PooledVector, i::Indexes) = PooledVector(xs.values, sub(xs.data, i))

convert{T}(::Type{PooledVector{T}}, xs::AbstractVector) =
  PooledVector(convert(AbstractVector{T}, xs))

getindex(xs::PooledVector, i::Integer) = xs.values[xs.data[i]]
getindex(xs::PooledVector, i::Indexes) = PooledVector(xs.values[xs.data[i]])

names(xs::PooledVector) = xs.values

@forward PooledVector.data Base.size
