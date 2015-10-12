using DataFrames

column(xs) = collect(xs)

DataSet(d::DataFrame) = DataSet([name => column(d[name]) for name in names(d)]...)
