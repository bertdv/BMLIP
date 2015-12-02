# Interactive Expectation Maximization demo for the 'old faithful' data set
# This script should be executed from the commandline

include("gmm_old_faithful_helpers.jl")

X = loadOldFaithfulDataset()
N = size(X, 2)

# Initialization
#clusters = MvNormal[MvNormal([3.;50.].*rand(2)+[2.;40.], diagm([.5;10^2])); MvNormal([3.;50.].*rand(2)+[2.;40.], diagm([.5;10^2]))]
clusters = MvNormal[MvNormal([4.;60.], diagm([.5;10^2])); MvNormal([2.;80.], diagm([.5;10^2]))]
π_hat = [0.5;0.5]
γ = fill!(Matrix{Float64}(2,N), NaN)

ion()
plotGMM(X, clusters, γ)
print("Press [enter] for E-step or ctrl+c to quit"); readline()

while(true)
    # E-step: update γ
    γ_1 = Float64[π_hat[1]*pdf(clusters[1], X[:,n]) / (π_hat'*[pdf(clusters[1], X[:,n]);pdf(clusters[2], X[:,n])])[1,1] for n=1:N]
    γ = [γ_1'; (1-γ_1')]
    clf(); plotGMM(X, clusters, γ)
    print("Press [enter] for M-step or ctrl+c to quit"); readline()

    # M-step: update cluster parameters and π_hat
    m = sum(γ, 2)
    π_hat = m / N
    μ_hat = (X * γ') ./ m'
    for k=1:2
        μ_k = μ_hat[:,k]
        Σ_k = (((X .- μ_k) .* γ[k,:]) * (X .- μ_k)') / m[k]
        clusters[k] = MvNormal(μ_k, Σ_k)
    end
    clf(); plotGMM(X, clusters, γ)
    print("Press [enter] for E-step or ctrl+c to quit"); readline()
end