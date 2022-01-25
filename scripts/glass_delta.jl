"""
    glass_delta function is the mean differences between the two groups divided by the standard deviation of the control group.
"""
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