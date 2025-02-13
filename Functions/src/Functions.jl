module Functions

# Splat and slurp
function addthree(a, b, c)
    a + b + c
end
function addthreeCoefficients(a, b, c; f1=1, f2=1, f3=1)
    f1 * a + f2 * b + f3 * c
end
v3 = [1, 2, 3]
coeffs = (f1=100, f2=10)
addthree(v3...)
addthreeCoefficients(1, 2, 3; coeffs...)

function addonlythreewithNote(a, b, c, more...)
    if length(more) > 0
        println!("Ignoring $(length(more)) additional arguments")
    end
    a + b + c
end

# The usual higher order Functions
double(x) = 2x
map(double, [2 3; 4 5])
map(+, [2 3], [4 5], [6 7]) # This is pretty cool
q(a, b) = a/b
reduce(q, 1:3)

# These are useful for specifying the associativity
foldl(q, 1:3)
foldr(q, 1:3)

mapreduce(x -> x^2, +, 1:100) # This avoids allocating an intermediate array

foldl(q, 3:-1:0)

# A slightly annoying way to write anonymous functions with full blocks
foldl(3:-1:0) do x, y
    if y == 0
        return x
    else 
        return x/y
    end
end

end # module Functions
