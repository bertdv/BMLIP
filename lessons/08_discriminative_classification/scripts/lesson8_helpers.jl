# Helper function for lesson 8 lecture notes.

function genDataset(N::Int64)
    # Generate dataset D={(x1,y1),...,(xN,yN)}
    # x is a 2d feature vector [x1,x2]
    # y ∈ {false,true} is a binary class label
    # p(x|y) is multi-modal (mixture of uniform and Gaussian distributions)
    X = Matrix{Float64}(2,N); y = Vector{Bool}(N)
    for n=1:N
        if (y[n]=(rand()>0.6)) # p(y=true) = 0.6
            # Sample class 1 conditional distribution
            if rand()<0.5
                X[:,n] = [6.0; 2.0] .* rand(2) + [3.0; 6.0]
            else
                X[:,n] = sqrt(0.5) * randn(2) + [7.0, 3.0]
            end
        else
            # Sample class 2 conditional distribution
            if rand()<0.5
                X[:,n] = randn(2) + [1., 4.]
            else
                if rand()<0.5
                    X[:,n] = randn(2) + [5., -2.]
                else
                    X[:,n] = sqrt(0.7) * randn(2)
                end
            end
        end
    end

    return (X, y)
end