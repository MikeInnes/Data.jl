export vartype, vareltype, Categorical, Ordinal, Continuous

type Categorical end
type Ordinal end
type Continuous end

vartype(::Type) = Categorical()
vartype{T<:Number}(::Type{T}) = Continuous()
vartype(x) = vartype(typeof(x))
vareltype(xs) = vartype(eltype(xs))

typealias Indexes{T<:Integer} AbstractVector{T}

macro forward(ex, fs)
  @capture(ex, T_.field_) || error("Syntax: @forward T.f f, g, h")
  T = esc(T)
  fs = isexpr(fs, :tuple) ? map(esc, fs.args) : [esc(fs)]
  :($([:($f(x::$T, args...) = $f(x.$field, args...)) for f in fs]...);nothing)
end

function staticm(ex)
  @match ex begin
    Array(T_, n_Integer) => begin
      @gensym xs
      eval(current_module(), :(const $xs = Array($T, $(env[:n]))))
      esc(xs)
    end
    Array(T_, n_) => quote
      xs = $(staticm(:(Array($T, 0))))
      while length(xs) < $(esc(n)) push!(xs, 0) end
      xs
    end
    zeros(T_, n_) => quote
      xs = $(staticm(:(Array($T, $n))))
      fill!(xs, 0)
      xs
    end
    zeros(n_) => staticm(:(zeros(Float64, $n)))
    _ => error("Invalid @static $ex")
  end
end

macro static(ex)
  staticm(ex)
end

macro unroll(n, ex)
  isa(n, Integer) || error("@unroll needs an integer")
  @match ex begin
    for i_ in range_ body_ end => quote
      state = start($(esc(range)))
      @unroll $n while !done($(esc(range)), state)
        $(esc(i)), state = next($(esc(range)), state)
        $(esc(body))
      end
    end
    while cond_ body_ end => quote
      while $(esc(cond))
        $(esc(body))
        $([:(!$(esc(cond)) && break; $(esc(body))) for i = 1:(n-1)]...)
      end
    end
    _ => error("@unroll needs a loop")
  end
end
