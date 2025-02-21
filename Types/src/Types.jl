module Types

using Plots
using Graphs
using GraphRecipes

typeof(π)
typeof(ℯ)

supertype(Int)
supertype(Signed)
supertype(Integer)
supertype(Real)
supertype(Number)
supertype(Any)

subtypes(Number)
supertypes(Irrational)
 
sometypes = [Any, Complex, Float64, Int64, Number, Signed, 
             Irrational, AbstractFloat, Real, 
             AbstractIrrational, Integer, String, Char, 
             AbstractString, AbstractChar, Rational, 
             Int32, Vector, DenseVector, AbstractVector, 
             Array, DenseArray, AbstractArray] 

type_tree = SimpleDiGraph(length(sometypes)) 
 
for t in sometypes[2:end] 
    add_edge!(type_tree, indexin([supertype(t)], sometypes)[1], 
              indexin([t], sometypes)[1]) 
end 
 
graphplot(type_tree; names=[string(t) for t in sometypes], 
nodeshape=:rect, 
          fontsize=4, nodesize=0.17, nodecolor=:white, method=:buchheim)

# This is a type assertion
17::Number
17::String

# Concrete type declarations
a::Int16 = 17
typeof(a)

function weather_report(raining::Bool, city::String)
    if raining
        n = ""
    else
        n = "not "
    end
    println("It is $(n)raining in $city today.")
end

function weather_report(raining) 
    println("Please tell us if it's raining with \"true\" or 
\"false\".") 
    return 
end

methods(weather_report)

# We can extend build in functions with new methods
import Base.+
function +(a::Number, b::String)
    if Meta.parse(b) isa Number
        return a + Meta.parse(b)
    else
        return a
    end
end

1 + "1"


#Unions
17 isa Union{Number, String}
Real <: Union{Number, String}

# We can declare our own types
abstract type MyNumber <: Number end
struct EarthLocation
    latitude::Float64
    longitude::Float64
    timezone::String
end
EarthLocation(a, b) = EarthLocation(a, b, "Unknown")

NYC = EarthLocation(40.7128, -74.0060, "EDT")
typeof(NYC)
NYC.timezone

abstract type Circle end

struct FloatingCircle <: Circle
    r::Real
end

struct PositionedCircle <: Circle
    x::Real
    y::Real
    r::Real
end

function circle_area(c::Circle)
    return π * c.r^2
end

function is_inside(c1::PositionedCircle, c2::PositionedCircle)
    d = sqrt((c2.x - c1.x)^2 + (c2.y - c1.y)^2)
    return d + c2.r < c1.r
end

# This is a nice macro for creating constructors
@kwdef struct Ellipse
    axis1::Real = 1
    axis2::Real = 1
end

oval = Ellipse(axis2=2.6)

# For good performance, we generally want to ensure types are stable
# This function is problematic - We get a float back if b is not 0, but
# an integer if b is 0
function safe_divide(a, b)
    if b == 0
        return 0
    else
        return a/b
    end
end

# This is so important that Julia has a macro to help us with it
@code_warntype safe_divide(1, 2)

# Let's fix it and see what happens
function safe_divide_better(a, b)
    if b == 0
        return 0.0
    else
        return a/b
    end
end
@code_warntype safe_divide_better(1, 2)

# Another type stability gotcha is changing the type of a variable
function leibn(N)
    s = 0
    for n in 1:N
        s += (-1)^(n+1) * 1/(2n-1)
    end
    return 4.0s
end

# Once again code_warntype can help us
@code_warntype leibn(100)
        
# We can create our own type aliases
const F64 = Float64

# We can also create parametric types
@kwdef struct CEllipse{T<:Number}
    axis1::T
    axis2::T
end

# Now, because we are taking any number, it could be complex. So we need
# specialisation in some methods to handle this
function eccentricity(e::CEllipse{<:Real})
    a = max(e.axis1, e.axis2)
    b = min(e.axis1, e.axis2)
    return sqrt(a^2 - b^2)/a
end

function eccentricity(e::CEllipse{<:Complex})
    a = max(abs(e.axis1), abs(e.axis2))
    b = min(abs(e.axis1), abs(e.axis2))
    return sqrt(a^2 - b^2)/a
end

function orientation(e::CEllipse{<:Complex})
    if abs(e.axis1) > abs(e.axis2)
        a = e.axis1
    else
        a = e.axis2
    end
    return angle(a)
end

end # module Types
