# Keep track of parameter estimates
m_x = zeros(T+1,)
w_x = .1 *ones(T+1,)
a_τ = 1. *ones(T+1,)
b_τ = .5 *ones(T+1,)

for k = 1:T
    
    # Initialize recognition distribution marginals
    marginals = Dict(:x_kmin1 => ProbabilityDistribution(Univariate, GaussianMeanPrecision, m=m_x[k], w=w_x[k]),
                     :x_k => ProbabilityDistribution(Univariate, GaussianMeanPrecision, m=m_x[k], w=w_x[k]),
                     :τ => ProbabilityDistribution(Univariate, Gamma, a=a_τ[k], b=b_τ[k]))
    
    # Initialize data
    data = Dict(:y_k => Y[k],
                :m_x_kmin1 => m_x[k],
                :w_x_kmin1 => w_x[k],
                :τ1 => a_τ[k],
                :τ2 => b_τ[k])
    
    # Iterate updates
    for n = 1:10
        stepx!(data, marginals)
        stepτ!(data, marginals)
    end
    
    # Store estimates
    m_x[k+1] = mean(marginals[:x_k])
    w_x[k+1] = inv(cov(marginals[:x_k]))
    a_τ[k+1] = marginals[:τ].params[:a]
    b_τ[k+1] = marginals[:τ].params[:b]
    
end

# Generate plot of state estimates
p1 = scatter(1:T, Y, color="black", markersize=6, label="observations", xlabel="time (t)", ylabel="signal")
plot!(1:T, m_x[2:end], ribbon=[sqrt.(inv.(w_x[2:end])) sqrt.(inv.(w_x[2:end]))], color="blue", label="inferred states")

# Generate plot of process noise precision estimates
m_τ = a_τ ./ b_τ
s_τ = sqrt.(a_τ ./ b_τ.^2)
p2 = plot(1:T, m_τ[2:end], ribbon=[s_τ[2:end] s_τ[2:end]], color="blue", xlabel="time (t)", legend=:bottomright, ylabel="τ", label="inferred precision")

# Actually plot
p3 = plot(p1,p2, layout=(2,1), size=(800,600))
