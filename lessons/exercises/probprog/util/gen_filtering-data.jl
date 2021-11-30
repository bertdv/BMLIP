using JLD
using LinearAlgebra
using Distributions
using Plots
pyplot()

# Dimensionalities
DX = 1
DY = 1

# Length of time-series
T = 100

# Process noise precision
τ = 2.

# Measurement noise precision
γ = 10.

# Preallocate data arrays
X = zeros(T,)
Y = zeros(T,)

# Initial state
X_0 = 0.0

# Keep previous state in memory
X_tmin1 = X_0

# Generate data for entire time-series
for t = 1:T
    
    # Transition from previous state
    X[t] = X_tmin1 + sqrt(inv(τ))*randn(1,)[1]
    
    # Emission of current state
    Y[t] = X[t] + sqrt(inv(γ))*randn(1,)[1]
    
    # Update previous state
    X_tmin1 = X[t]
    
end

# Write data to file
save("source/probprog4/signal.jld", 
     "Y", Y,
     "γ", γ,
     "T", T)

# Visualization of states
plot(1:T, X, color="red", label="states", grid=false, xlabel="time (t)", ylabel="signal")
scatter!(1:T, Y, color="black", label="observations")
