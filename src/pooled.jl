import Base: getindex, unique, convert, names

export PooledVector, SubPooledVector, maxunique

immutable PooledVector{T} <: AbstractVector{T}
  values::Vector{T}
  data::Vector{Int}
end

typealias SubPooledVector{T, P<:PooledVector} SubArray{T, 1, P}

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

getdata(xs::PooledVector) = xs.data
getdata(xs::SubPooledVector) = slice(xs.parent.data, xs.indexes...)

convert{T}(::Type{PooledVector{T}}, xs::AbstractVector) =
  PooledVector(convert(AbstractVector{T}, xs))

typealias Indexes{T<:Integer} AbstractVector{T}

getindex(xs::PooledVector, i::Integer) = xs.values[xs.data[i]]
getindex(xs::PooledVector, i::Indexes) = PooledVector(xs.values[xs.data[i]])

unique(xs::PooledVector) = xs.values

names(xs::PooledVector) = unique(xs)
names(xs::SubPooledVector) = unique(xs.parent)

@forward PooledVector.data Base.size
