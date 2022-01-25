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

using HypothesisTests, FreqTables
"""
    cramer_corr function computes X, Y One Dims vector or matrix and return correlation of the two vectors, used on categorical data.
"""
function cramer_corr(x, y)
    function check_array(x, y)
        if isempty(x) || isempty(y)
            return @error("Empty Array")
        elseif !(length(x) == length(y))
            return @error("Arrays are not of the same length")
        else
        end
    end;
    function compute_v( x, y )
        cm = freqtable(x, y)
        n  = sum(cm)
        r, k = size(cm)

        chi2 = ChisqTest( cm ).stat
        chi2corr = max( 0, chi2 - ((( k-1 ) * ( r-1 )) / ( n-1 ) ))

        kcorr = k - ((( k-1 )^2) / ( n-1 ))
        rcorr = r - ((( r-1 )^2) / ( n-1 ))

        return sqrt( ( chi2corr / n ) / ( min( kcorr - 1, rcorr - 1 ) ) )
    end;
    check_array(x, y)
    return compute_v(x, y)
end;

function glass_delta(x, y)
    function check_array(x, y)
        if isempty(x) || isempty(y)
            return @error("Empty Array")
        else
            try float(x)
            catch e
                @warn("Array X with wrong Type")
            end
            try float(y)
            catch e
                 @warn("Array Y with wrong Type") 
            end
        end
    end;
    function compute_glass(x, y)
        try check_array(x, y)
        catch e
            @error("Error", exception=e)
        end
        mean_x = sum(x)/length(x)
        mean_y = sum(y)/length(y)
        std_x = sqrt(sum((x .- mean_x).^2)/length(x))
        return (mean_x - mean_y) / std_x
    end;
    return compute_glass(x, y)
end

function cohen_d(x, y)
    function check_array(x, y)
        if isempty(x) || isempty(y)
            return @error("Empty Array")
        else
            try float(x)
            catch e
                @warn("Array X with wrong Type")
            end
            try float(y)
            catch e
                 @warn("Array Y with wrong Type") 
            end
        end
    end;
    function compute_cohen(x, y)
        try check_array(x, y)
        catch e
            @error("Error", exception=e)
        end
        mean_x = sum(x)/length(x)
        mean_y = sum(y)/length(y)
        std_x = √(sum((x .- mean_x).^2)/length(x))
        std_y = √(sum((y .- mean_y).^2)/length(y))
        
        return ( mean_x - mean_y ) / √( ( std_x^2 + std_y^2 ) / 2 )
    end;
    return compute_cohen(x, y)
end