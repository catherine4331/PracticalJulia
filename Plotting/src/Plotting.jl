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

# A quick demo of plot settings
p1 = plot(sin, cos, 0, 2π; title="A circle", ratio=1, grid=false, ticks=false, legend=false)
p2 = plot(x -> x^2, -1, 1; title="A parabola", gridalpha=0.4, gridstyle=:dot, legend=false)
plot(p1, p2; title="Two shapes", plot_titlefontsize=20)

# Let's try using a legend
plot()
for n in 1:5
    plot!(x -> x^n; lw=3, ls=:auto, label=n)
end
plot!(; legend=:topleft, legendtitle="Exponent")

# Using LaTeX titles
plot()
for n = 1:5
    # This bit is clever
    xlabel = (0.2 + 0.12n)
    ylabel = xlabel^n
    plot!(x -> x^n; lw=3, ls=:auto,
        annotation=(xlabel, ylabel, n),
        annotationfontsize=25)
end
using LaTeXStrings
plot!(; legend=false, xguide="x", yguide="y", guidefontsize=18, title=L"x^n \textrm{~labeled~by~}n", titlefontsize=30)

# Let's try a regression line
x = [20.0]
y = [9.0]
for i in 1:100_000
    x2, y2 = ginger(x[end], y[end], 1.4)
    push!(x, x2)
    push!(y, y2)
end
scatter(x, y, ms=0.5, legend=false)
sc = scatter(x, y; smooth=true, ms=1, legend=false, xguide="x", yguide="y", guidefontsize=18)
pl = plot(x[1:100]; smooth=true, legend=false)
pl = plot!(x[1:100]; lc=:lightgray, legend=false, xguide="iteration", yguide="x", guidefontsize=18)
comb = plot(sc, pl, plot_title="Gingerbread map with a = 1.6", plot_titlefontsize=22)

savefig(comb, "gingerbread.png")

# Inset plots
lens!([-26, -22], [31, 38];
    inset=(1, bbox(0.1, 0, 0.3, 0.3)),
    ticks=false, framestyle=:box, subplot=2,
    linecolor=:green, linestyle=:dot)

# 3D Plots
x = -1:2/100:1
surface(x, x, (x, y) -> exp(-(0.05x^2 + y^2) / 0.1);
    fillalpha=0.5, camera=(45, 50), c=[Gray(0), Gray(0.8)],
    xrotation=45, yrotation=-45)

heatmap(x, x, (x, y) -> exp(-(0.05x^2 + y^2) / 0.1);
    c=:blues)

contour(x, x, (x, y) -> exp(-(0.05x^2 + y^2) / 0.1);
    clabels=true, levels=[0.1, 0.3, 0.5, 0.7, 0.9, 1.0],
    colorbar=false, framestyle=:box)

# And finally, a nice parametric plot in 3D
t = 0:2π/100:2π
xp = sin.(3 .* t)
yp = cos.(3 .* t)
zp = t .* 0.2
plot(xp, yp, zp; lw=3, gridalpha=0.4, camera=(30, 50))

# Now, vector plots
xc = 0:0.3:π
yc = sin.(xc)
quiver(xc, yc; quiver=(xc .- π / 2, yc .- 0.25), lw=3)

# We can even do 3D scatter plots (how cool)
x = []
y = []
z = []
for i in 0:20, j in 0:20, k in 0:20
    push!(x, i / 10 - 1)
    push!(y, j / 10 - 1)
    push!(z, k / 10 - 1)
end
pot(x, y, z) = 1 / sqrt(x^2 + y^2 + z^2)
scatter(x, y, z; ms=min.(pot.(x, y, z), 10), ma=0.4, legend=false)


# The book has a list of backends (Gaston could be useful)
# It also has a demo of the layout system if we need that kind of thing

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
function p(x; y=2)
    g(x, y)
end

end # module Plotting
