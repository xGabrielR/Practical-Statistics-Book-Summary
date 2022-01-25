"""
    cohen_d function size effect of means.
"""
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