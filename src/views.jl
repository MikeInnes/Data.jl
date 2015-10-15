import Base: getindex
import ArrayViews: view

immutable DataView{T, I} <: Table
  data::T
  index::I
end

typealias DataRow{T, I<:Integer} DataView{T, I}

view(data::Table, i) = DataView(data, i)

getindex(d::DataView, f::Column) = d.data[f, d.index]
getindex(d::DataView, f::Column, i) = d.data[f, d.index[i]]
