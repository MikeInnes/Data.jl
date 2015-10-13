export NullableArray, NullableVector

export NullableArray, NullableVector

typealias NullableArray{T, N} AbstractArray{Nullable{T}, N}
typealias NullableVector{T} NullableArray{T, 1}
