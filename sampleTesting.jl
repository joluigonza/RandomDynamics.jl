###########
### Testing
###########

include("TypeRDS.jl")

using Statistics


"""
    testing(x0::AbstractVector, distribution::Distribution, iterations::Int64)

Plots the trajectory of an initial vector for a given distribution.

## Arguments
- `x0`: An initial vector of data points.
- `distribution`: A vector of possible distributions for a sample space Ω.
- 'func': f_ω
- `iterations`: Length of trajectory.
"""
function testing(x0::AbstractVector, distribution::Distribution, func::Function, iterations::Int64)
    rds = RDS(Interval{Closed, Closed}(0, 1), 1, distribution)
    data = sampleTraj(rds, iterations, x0, func)
    dataTraj = Vector{Vector{Float64}}(undef, length(x0))

    plot(title=distribution, xlabel="Iterations", ylabel="Values", titlefontsize=10) # Format plot object.

    # Instantiates a vector of vectors to store trajectory of datapoints.
    for i in eachindex(dataTraj)
        dataTraj[i] = Float64[]
    end
        
    # Fills vector of trajectories of datapoints.
    for dataPoint in data
        for (i, point) in enumerate(dataPoint)
            push!(dataTraj[i], point)
        end
    end

    for i in eachindex(dataTraj)
        plot!(dataTraj[i])
    end
    display(current())
end

"""
    testing(x0::AbstractVector, distributions::Vector{Distribution{Univariate, Continuous}}, iterations::Int64)

Plots the trajectory of an initial vector of data for each distribution provided in 'distributions'.

## Arguments
- `x0`: An initial vector of data points.
- `distributions`: A vector of possible distributions for a sample space Ω.
- 'func': f_ω
- `iterations`: Length of trajectory.
"""
function testing(x0::AbstractVector, distributions::Vector{Distribution{Univariate, Continuous}}, func::Function, iterations::Int64)
    for dist in distributions
        rds = RDS(Interval{Closed, Closed}(0, 1), 1, dist)
        data = sampleTraj(rds, iterations, x0, func)
        dataTraj = Vector{Vector{Float64}}(undef, length(x0))

        plot(title=dist, xlabel="Iterations", ylabel="Values", titlefontsize=10) # Format plot object.
        

        # Instantiates a vector of vectors to store trajectory of datapoints.
        for i in eachindex(dataTraj)
            dataTraj[i] = Float64[]
        end
        
        # Fills vector of trajectories of datapoints.
        for dataPoint in data
            for (i, point) in enumerate(dataPoint)
                push!(dataTraj[i], point)
            end
        end

        for i in eachindex(dataTraj)
            plot!(dataTraj[i])
        end
        display(current())  # displays the plot associated with the distribution.
    end
end

function tracking(x0::AbstractVector, distribution::Distribution, func::Function, iterations::Int64)
    rds = RDS(Interval{Closed, Closed}(0, 1), 1, distribution)
    data = sampleTraj(rds, iterations, x0, func)
   
    # Record and display distribution evolution over time.
    for i in eachindex(data)
        plt = histogram(data[i], xlims=(0,1)) # Plot the values sampled above
        display(plt)
    end

end

function normal_samples(n)
    samples = randn(n)  # Generate n samples from a standard normal distribution
    transformed_samples = (samples .+ 3) ./ 6  # Transform samples to the interval [0, 1]
    valid_samples = filter(x -> 0 ≤ x ≤ 1, transformed_samples)  # Filter out values outside [0, 1]
    return valid_samples
end

