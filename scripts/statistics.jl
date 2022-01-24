x = [collect(-100:20:0)];
y = [collect(0:20:100)];

"""
    pearson_corr function computes X, Y One Dims vector or matrix and return correlation of the two vectors.
"""
function pearson_corr(x, y)
    function check_array(x, y)
        if isempty(x) || isempty(y)
            return @error("Empty Array")
        else
            if typeof(x) == Vector{Vector{Int64}} || typeof(x) == Vector{Vector{Float64}}
                x = Array(x[1])
            end
            if typeof(y) == Vector{Vector{Int64}} || typeof(y) == Vector{Vector{Float64}}
                y = Array(y[1])
            end
            try float(x)
            catch e
                @warn("Array X with wrong Type")
            end
            try float(y)
            catch e
                @warn("Array Y with wrong Type") 
            end
            x = float(x)
            y = float(y)
        end
        return x, y
    end
    function compute_r(x, y)
        try x, y = check_array(x, y)
        catch e
            @error("Error", exception=e)
        end
        return (length(x)sum(x .* y) - (sum(x)sum(y))) / (sqrt((length(x)sum(x.^2) - (sum(x))^2) .* (length(y)sum(y.^2) - (sum(y))^2)))
    end
    return compute_r(x, y)
end

r = pearson_corr(x, y)