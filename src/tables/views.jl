import Base: getindex, length
import ArrayViews: view

immutable DataView{T, I} <: Table
  data::T
  index::I
end

typealias DataRow{T, I<:Integer} DataView{T, I}

view(data::Table, i) = DataView(data, i)

view(d::DataView, i) = DataView(d.data, d.index[i])

getindex(d::DataView, f::Column) = sub(d.data[f], d.index)
getindex(d::DataView, f::Column, i) = d.data[f, d.index[i]]
getindex(d::DataView, i) = d.data[d.index[i]]

length{T, I<:AbstractArray}(d::DataView{T, I}) = length(d.index)

@forward DataView.data Base.names
