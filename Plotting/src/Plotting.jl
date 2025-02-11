module Plotting

using Plots

f(x) = sin(1 / x)
simple(f)
many(f)
vector()
plot!(sin) # This mutates the current plotting surface. We can give it a plot to mutate as an arg instead

parabola = plot(x -> x^2)
ps = plot(sin, 0, 2π)
plot!(ps, cos)
plot(ps, plot(f), plot(s -> s^3), parabola) # Multigraph!

# Parametric plots
circle = plot(sin, cos, 0, 2π)
spiral = plot(r -> r * sin(r), r -> r * cos(r), 0, 8π)

# Polar plots
plot(0:2π/500:2π, t -> 1 + 0.2 * sin(8t); proj=:polar)
plot(0:8π/200:8π, t -> t; proj=:polar)

# Let's try some discrete data
x = [20.0]
y = [9.0]
for i in 1:4000
    x2, y2 = ginger(x[end], y[end], 1.76)
    push!(x, x2)
    push!(y, y2)
end
scatter(x, y, ms=0.5, legend=false)


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

function ginger(x, y, a)
    x2 = 1.0 - y + a * abs(x)
    y2 = x
    x2, y2
end

# Example of optional arguments
function g(x, y=2)
    x + y
end

# Example of keyword arguments
function

end # module Plotting
