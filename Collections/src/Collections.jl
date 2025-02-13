module Collections

xs = []

# Direct construction
for x in 1:5
    push!(xs, x^2)
end

# Using a comprehension
ys = [x^2 for x in 1:5]

mat = [2x for x in [1 2; 3 4]]

# More cool stuff
[x * y for x in 1:3 for y in 1:3] # Makes a vector
[x * y for x in 1:3, y in 1:3] # Makes a matrix

# And we can filter as well
[x * y for x in 1:9, y in 1:9
    if x * y % 2 == 0 && x * y % 7 == 0] |> unique

# This is a generator
mult_gen = (x * y for x in 1:9, y in 1:9)

bd = Dict("one" => 1, "two" => 2, "three" => 3)

# Structured data!
# These need to be marked mutable if we want to mutate them
struct Website
    url
    title
end

repeat(['a' 'b' '|'], 4, 3)
fill(['X' 'Y'], 3, 4)
zeros(4, 5)
ones(3, 5)

a1 = collect(1:6)
a2 = reshape(a1, (3, 2)) # This just changes the vector/matrix metadata, it doesn't change the underlying array

# Efficient storage of arrays of bools
s3 = (1:9) .% 3 .== 0
(1:9)[s3]

# Adjoints and transposes
MR = [[1 2]; [3 4]]
MR'
MR' == adjoint(MR) == permutedims(MR) # This is only true because the elements of MR are their own complex conjugates

M = [[1+im 2+2im]; [3+3im 4+4im]]
M'
adjoint(M)
permutedims(M)
transpose(M) # This looks the same as permutedims, but it acts recurisively on submatrices

# Matmuls!
a = π/2
RM = [[cos(a) -sin(a)]; [sin(a) cos(a)]]

RM * [1, 0]

# A subtle difference here
for letter in enumerate("François")
    println("Letter number $(letter[1]) is $(letter[2])")
end
collect(pairs("François"))

# Zip in Julia is pretty powerful
zip([1 2; 3 4], ['a' 'b'; 'c' 'd']) |> collect


end # module Collections
