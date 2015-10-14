import Base: getindex, unique, convert

export PooledVector

immutable PooledVector{T} <: AbstractVector{T}
  values::Vector{T}
  data::Vector{Int}
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

convert{T}(::Type{PooledVector{T}}, xs::AbstractVector) =
  PooledVector(convert(AbstractVector{T}, xs))

getindex(xs::PooledVector, i...) = xs.values[xs.data[i...]]

unique(xs::PooledVector) = xs.values

@forward PooledVector.data Base.size
