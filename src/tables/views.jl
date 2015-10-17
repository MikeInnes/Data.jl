import Base: getindex, length, names
import ArrayViews: view

immutable DataView{T, I} <: Table
  data::T
  cols::Vector{Symbol}
  index::I
end

typealias DataRow{T, I<:Integer} DataView{T, I}

view(data::Table, cols, i) = DataView(data, cols, i)
view(data::Table, i) = view(data, Symbol[], i)

view(d::DataView, cols, i) = DataView(d.data, cols, d.index[i])
view(d::DataView, i) = view(d.data, Symbol[], d.index[i])

getindex(d::DataView, f::Column) = sub(d.data[f], d.index)
getindex(d::DataView, f::Column, i) = d.data[f, d.index[i]]
getindex(d::DataView, i) = d.data[d.index[i]]

length{T, I<:AbstractArray}(d::DataView{T, I}) = length(d.index)

names(d::DataView) = isempty(d.cols) ? names(d.data) : d.cols

@forward DataView.data Base.names
