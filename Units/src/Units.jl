module Units

using Plots, Unitful, Measurements

u"1m" + u"1cm"
u"1.0m" + u"1cm"
u"1.0m/1s"

typeof(u"1m")

earth_accel = "9.8m/s^2"
kg_weight_earth = uparse("kg * " * earth_accel)

# We can strip off the units if we need to
convert(Float64, u"1m/100cm")

u"1m * 100cm" |> upreferred

# Another way if we want to preserve the numeric type
vi = 17u"m/s"
vf = 17.0u"m/s"

ustrip(vi), ustrip(vf)
unit(vi)

mass = 6.3u"kg"
velocity = (0:0.05:1)u"m/s"
KE = mass .* velocity.^2 / 2
plot(velocity, KE; xlabel="Velocity", ylabel="KE",
    lw=3, legend=:topleft, label="Kinetic Energy")

# Let's try out propagating some errors
f = 92.1343 ± 3
typeof(f)
f

emass = measurement("9.1093837015(28)e-31")
emass + emass
emass/2emass # This one is cool

# Let's combine this with Unitful
mass = 6.3u"kg" ± 0.5u"kg"
velocity = (0:0.05:1)u"m/s"
KE = mass .* velocity.^2 ./ 2
plot(velocity, uconvert.(u"J", KE); xlabel="Velocity",
    ylabel="K.E.", lw=2, legend=:topleft, label="Kinetic Energy")

end # module Units
