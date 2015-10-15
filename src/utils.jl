export @static

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
