# NOTE: This file is work-in-progress!!
# TODO: Discuss with Bert if we should also introduce the extra constant in X to the notebook

# Generate dataset {(x1,y1),...,(xN,yN)}
# x is a 2-d feature vector [x_1;x_2]
# y ∈ {false,true} is a binary class label
# p(x|y) is multi-modal (mixture of uniform and Gaussian distributions)
using PyPlot, Optim
include("scripts/lesson8_helpers.jl")
N = 200
X, y = genDataset(N) # Generate data set, collect in matrix X and vector y
X_c1 = X[:,find(!y)]'; X_c2 = X[:,find(y)]' # Split X based on class label
plot(X_c1[:,1], X_c1[:,2], "bx", markersize=10)
plot(X_c2[:,1], X_c2[:,2], "ro", markersize=10, fillstyle="none")
xlabel(L"x_1"); ylabel(L"x_2"); legend([L"y=0", L"y=1"], 2)
xlim([-2;10]); ylim([-4, 8]);

# Generate class-1 indicator vector y_1
y_1 = zeros(length(y))
y_1[y.==false] = 1.

# Define log-likelihood function and its gradient
# We extend X with a constant term so the decision boundary does not have to pass through (0,0)
X_ext = vcat(X, ones(1, length(y)))
function neg_loglik_and_gradient!(θ::Vector, gradient::Vector)
    # Return negative log-likelihood: -1 * L(θ)
    # Write gradient to negative log-likelihood to gradient argument
    p_1 = 1.0 ./ (1.0 + exp(-1.*(X_ext' * θ)[:,1]))   # P(C1|X,θ)
    gradient[:] = -1. .* X_ext * (y_1-p_1)

    return -1.0 * sum(log( (y_1.*p_1) + ((1.-y_1).*(1.-p_1))) ) # Log-likelihood
end
neg_loglik(θ) = neg_loglik_and_gradient!(θ, zeros(length(θ)))

# Maximize the log-likelihood (actually: minimize the negative log-likelihood)
objective = DifferentiableFunction(neg_loglik, neg_loglik_and_gradient!, neg_loglik_and_gradient!)
results = optimize(objective, [0.0; 0.0; 0.0])
θ = results.minimum

# Plot the decision boundary
p_1(x) = 1.0 ./ (1.0 + exp(-1.*([x;1.]' * θ)[:,1]))
boundary(x1) = -1./θ[2] * (θ[1]*x1 + θ[3])
plot([-2.;10.], boundary([-2.;10.]), "k-")
PyPlot.show()
