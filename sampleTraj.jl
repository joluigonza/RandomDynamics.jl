using Distributions, StaticArrays

include("typeRDS.jl")

# This is our main sampling method for our package using type RDS
function sampleTraj(f, distr, n, x0)
    if n < 0
        return "n is $n, but n must be a positive number of iterations!"
    end
    return 1
end

function sampleTraj(rds::RDS, n, x0)
    # Check if number of iterations inputted is sufficient
    if n < 0
        return "n is $n, but n must be a positive number of iterations!"
    end

    # Where the Markov chain progress will be tracked
    markovProgression = Vector{Float64}(undef, n)
    markovProgression[1] = x0
    for i in 2:n
        nextX = f(rds, i - 1)
    end
    # Would we want to store anything as a Static Array? We have to generate everything before storing because 
    return markovProgression
end