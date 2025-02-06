module Plotting

using Plots

f(x) = sin(1 / x)
simple(f)
many(f)
vector()

end # module Plotting

function simple(f)
    x = π/1000:π/1000:π
    plot(x, f.(x))
end

function many(f)
    plot([sin, cos, f], -π, π)
end

function vector()
    x = 0:5π/1000:5π

    # Run this to see what it looks like. What's happening is the 
    # independent variable is getting appended to itself shifted right by 5pi.
    # The first half of this runs through sin, the second half through sin * exp
    plot([x; 5π .+ x], [sin.(x); -exp.(-x .* 0.2) .* sin.(x)])
end