module Errors

function finite_log(n)
    if n == 0
        throw(DomainError(n, "please supply a positive argument; log(0) = -Inf."))
    end
    
    return log(n)
end

end # module Errors
