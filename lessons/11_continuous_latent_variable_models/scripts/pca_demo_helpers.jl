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
    # X may contain missing values, indicated by NaN
    N = size(X, 2); D = size(X, 1)

    # Shift X to be zero-mean, ignoring missing values
    # Missing values are treated as latent variables,
    # so we keep track of E[x-μ] and E[(x-μ)' * (x-μ)].
    # In case there are no missing values, both expectations are constants.
    missing_values = isnan(X)
    has_missing_values = sum(missing_values) > 0
    e_X = copy(X) # E[X.-μ]
    e_X[missing_values] = 0.0 # set missing values to 0.0 to ignore them in mean calculation
    μ = ( sum(e_X, 2) ./ (N*ones(D)-sum(missing_values,2)) )[:,1] # make sure missing values don't influence the mean. [:,1] makes sure this is a Vector
    e_X = X .- μ
    e_X[missing_values] = 0.0 # Initialize expected value of missing values to the mean
    e_xx = [(e_X[:,n]'*e_X[:,n])[1,1] for n=1:N] # E[(x-μ)' * (x-μ)]

    # Initialize variables
    θ = pPCAParams(Matrix{Float64}(D,M), μ, 0.0) # θ holds the parameters
    e_z = [randn(M) for i=1:N]        # e_z[n] = E[z_n]
    e_zz = Vector{Matrix{Float64}}(N) # e_zz[n] = E[z_n * z_n']
    for n=1:N
        e_zz[n] = e_z[n] * e_z[n]'
    end

    function eStep!(e_z, e_zz, e_X, e_xx)
        # Update e_z and e_zz
        W = θ.W; σ2 = θ.σ2
        R = W'*W + σ2*eye(M)
        K = inv(R) * W'
        C = σ2*inv(R)

        e_X[missing_values] = 0.0 # ignore missing values in calculation of e_z
        for n=1:N
            e_z[n] = K * e_X[:,n]
            e_zz[n] = C + e_z[n] * e_z[n]'
        end

        if has_missing_values
            # Update e_X and e_xx
            for idx in find(missing_values)
                n = Int(ceil(idx / D)) # index of data point
                d = (idx-1)%D + 1 # dimension
                e_X[d,n] = (W[d,:] * e_z[n])[1,1]
            end
            for n in find(sum(missing_values,1)) # every datapoint with at least 1 missing value
                e_xx[n] = (e_X[:,n]'*e_X[:,n])[1,1] + sum(missing_values[:,n])*σ2
            end
        end
    end

    function mStep!(θ)
        # Update W and σ2
        W1 = zeros(D,M)
        for n=1:N
            W1 += e_X[:,n] * e_z[n]'
        end
        W = W1 * inv(sum(e_zz))
        θ.W = W

        accum = 0.0
        W2 = W'*W
        for n=1:N
            accum += (e_xx[n] - 2 * e_z[n]' * W' *e_X[:,n] + trace(e_zz[n]*W2))[1,1]
        end
        θ.σ2 = accum / (N*D) # update σ2
    end

    for i=1:30 # Here should be a decent convergence check, but hey, this also works...
        mStep!(θ)
        eStep!(e_z, e_zz, e_X, e_xx)
    end

    # Collect E[z_1],...,E[z_N] in a matrix
    Z = Matrix{Float64}(M,N)
    for n=1:N
        Z[:,n] = e_z[n]
    end

    return (θ, Z) # Z is actually redundant, but we return it for convenient plotting
end