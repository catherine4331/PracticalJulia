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

function weather_report(raining::Bool)
    if raining
        n = ""
    else
        n = "not "
    end
    gf = "London"
    println("It is $(n)raining in $gf today.")
end

function weather_report(raining) 
    println("Please tell us if it's raining with \"true\" or 
\"false\".") 
    return 
end

end # module Types
