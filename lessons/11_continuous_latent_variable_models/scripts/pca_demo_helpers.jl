# Helper function for the PCA demo

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

type pPCAParams
    W::Matrix
    μ::Vector
    σ2::Float64
end

function pPCA(X::Matrix, M::Int64)
    # Implement probabilistic PCA using the EM algorithm]𝜓
    # X collects the data points on its columns
    _X = copy(X)
    N = size(_X, 2); D = size(_X, 1)

    # Shift _X to be zero-mean
    μ = (sum(_X, 2) / N)[:,1] # [:,1] makes sure this is a Vector
    _X = _X .- μ

    # Initialize variables
    θ = pPCAParams(Matrix{Float64}(D,M), μ, 0.0) # θ holds the parameters
    e_z = [randn(M) for i=1:N]        # e_z[n] = E[z_n]
    e_zz = Vector{Matrix{Float64}}(N) # e_zz[n] = E[z_n * z_n']
    for n=1:N
        e_zz[n] = e_z[n] * e_z[n]'
    end

    function eStep!(e_z, e_zz)
        # Update e_z and e_zz
        W = θ.W; σ2 = θ.σ2
        R = W'*W + σ2*eye(M)
        K = inv(R) * W'
        C = σ2*inv(R)

        for n=1:N
            e_z[n] = K * _X[:,n]
            e_zz[n] = C + e_z[n] * e_z[n]'
        end
    end

    function mStep!(θ)
        # Update W and σ2
        W1 = zeros(D,M)
        for n=1:N
            W1 += _X[:,n] * e_z[n]'
        end
        W = W1 * inv(sum(e_zz))
        θ.W = W

        accum = 0.0
        W2 = W'*W
        for n=1:N
            accum += (_X[:,n]'*_X[:,n] - 2 * e_z[n]' * W' *_X[:,n] + trace(e_zz[n]*W2))[1,1]
        end
        θ.σ2 = accum / (N*D) # update σ2
    end

    for i=1:20 # Here should be a decent convergence check, but hey, this also works...
        mStep!(θ)
        eStep!(e_z, e_zz)
    end

    # Collect E[z_1],...,E[z_N] in a matrix
    Z = Matrix{Float64}(M,N)
    for n=1:N
        Z[:,n] = e_z[n]
    end

    return (θ, Z) # Z is actually redundant, but we return it for convenient plotting
end