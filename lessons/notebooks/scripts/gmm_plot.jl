using Distributions, PyPlot

function plotGMM(X::Matrix, clusters::Vector, γ::Matrix)
    # Plot data set and (fitted) mixture model consisting of two Gaussian distributions
    # X contains a 2-d data set (every column holds a data point)
    # clusters holds the 2 Gaussian elements of the mixture model
    # γ contains p(cluster|X), and should contain NaN elements if not yet known

    # Plot contours of the element distributions
    K = length(clusters)
    eff_K = sortperm(vec(sum(γ,dims=2)))
    col = ["black", "green", "red", "blue", "yellow","pink"]
    for k=1:K
        X1=Matrix{Float64}(undef,50,50); X2=Matrix{Float64}(undef,50,50); d=Matrix{Float64}(undef,50,50)
        # Create bounding box for thse contour plot
        lims = [-3*sqrt(cov(clusters[eff_K[k]])[1,1]) 3*sqrt(cov(clusters[eff_K[k]])[1,1]);
                -3*sqrt(cov(clusters[eff_K[k]])[2,2]) 3*sqrt(cov(clusters[eff_K[k]])[2,2])] + repeat(mean(clusters[eff_K[k]]), 1, 2)
        for i=1:50
            for j=1:50
                X1[i,j] = (i-1)/50 * abs.(lims[1,2]-lims[1,1]) + lims[1,1]
                X2[i,j] = (j-1)/50 * abs.(lims[2,2]-lims[2,1]) + lims[2,1]
                d[i,j] = pdf(clusters[eff_K[k]], [X1[i,j];X2[i,j]])
            end
        end
        if vec(sum(γ,dims=2))[k] > 20
            contour(X1, X2, d, 3, colors=col[eff_K[k]])
        end
    end

    # Plot data points
    # if isnan(γ[1,1])
    #     scatter(X[1,:], X[2,:], marker="o", s=20, c="k")
    # else
    #     scatter(X[1,:], X[2,:], marker="o", s=20, c=γ[1,:], cmap="PiYG")
    # end
    if isnan(γ[1,1])
        scatter(X[1,:], X[2,:], marker="o", s=20)
    else
        scatter(X[1,:], X[2,:], marker="o", s=20)
    end

    # Figure make-up
    plotlimits = hcat(minimum(X,dims=2), maximum(X,dims=2))
    margin = 0.2*abs.(plotlimits[:,1] - plotlimits[:,2])
    xlim([plotlimits[1,1]-margin[1]; plotlimits[1,2]+margin[1]])
    ylim([plotlimits[2,1]-margin[2]; plotlimits[2,2]+margin[2]])
end
