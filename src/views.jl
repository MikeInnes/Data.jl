import Base: getindex
import ArrayViews: view

type DataView{I, S}
  data::DataSet{I}
  index::S
end

typealias DataRow{I, S<:Integer} DataView{I, S}

view(data, i) = DataView(data, i)

getindex(d::DataView, f::Column) = d.data[f, d.index]
getindex(d::DataView, f::Column, i) = d.data[f, d.index[i]]
