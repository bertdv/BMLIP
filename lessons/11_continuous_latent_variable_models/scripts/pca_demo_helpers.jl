# Helper function for the PCA demo

using PyPlot

function readDataSet(filename)
    f = open(filename);
    data = nothing
    for line in eachline(f)
        row = map((s) -> parse(Int, s), split(replace(line, "  ", " "), " "))
        data = (data == nothing) ? row' : vcat(data, row')
    end
    close(f)

    return data
end

function pca(X::Matrix, M::Int64)
    # Implement deterministic PCA using the EM algorithm
    _X = X' # convert data points to columns
    N = size(_X, 2); D = size(_X, 1)

    # Shift _X to be zero-mean
    μ = sum(_X, 2) / N
    _X = _X - μ

    # Initialize variables
    W = Matrix{Float64}(D,M)
    σ2 = 0.0
    Z = randn(M,N)
    Z_out = Array{Matrix{Float64,1}(N)
    for n=1:N
        Z_out[n] = Z[:,n] * Z[:,n]'
    end

    function Estep!(Z, Z_out)
        # Update Z and Z_out
        R = W'*W + σ2*eye(M)
        Z = inv(R) * W' * _X
        C = σ2*inv(R)
        for n=1:N
            Z_out[n] = C + Z[:,n] * Z[:,n]'
        end
    end

    function Mstep!(W, σ2)
        # Update W and σ2
        W = _X * Z'

    end
end