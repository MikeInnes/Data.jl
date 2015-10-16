using DataFrames

column(xs) = column(vareltype(xs), xs)

column(vt, xs) = collect(xs)

function column(::Categorical, xs)
  if length(unique(xs)) < length(xs)/10
    PooledVector(collect(xs))
  else
    collect(xs)
  end
end

DataSet(d::DataFrame) = DataSet([name => column(d[name]) for name in names(d)]...)
