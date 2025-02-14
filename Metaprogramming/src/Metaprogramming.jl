module Metaprogramming

using Chain
using Printf

expr = :(3 * 5)
eval(expr)

ex = quote
    a = 3
    a + 2
end
eval(ex)

# We can interpolate expressions
w = 3
ex = :(w * 5)
ey = :($w * 5)

mkvar(s, v) = eval(:($(Symbol(s)) = $v))
mkvar("Arthur", 42)

# Macros!
macro mkvarmacro(s, v)
    ss = Symbol(s)
    return esc(:($ss = $v))
end
@mkvarmacro "color" 17

macro until(condition, body)
    quote
        while !$condition
            $(esc(body))
        end
    end
end
i =0
@until i == 11 (println(i^3); i+=1)

# Some useful macros
r = 1:10
[r (@. exp(r) > r^4) (exp.(r) .> r.^4)]

@chain "hello" begin
    uppercase
    reverse
    occursin("OL", _)
end

@time sum((1:1e8).^2)

x = (1:1e6).^2
s = 0
# We don't really need to use this in modern Julia (I assume the compiler can figure out when it's safe to do this)
@inbounds for i in 1:2:1000
    s += x[i]
end

const d = 1.0045338347428372e6
@time sum(i/d for i in 1:1e9)
@time @fastmath sum(i/d for i in 1:1e9)
@printf "10! is about %.2e and √2 is approximately %.4f" factorial(10) sqrt(2)

end # module Metaprogramming
