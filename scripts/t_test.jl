"""
    cramer_corr function computes X, Y One Dims vector or matrix and return correlation of the two vectors, used on categorical data.
"""
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
function make_data(x, y)
    info = []
    for i in [x, y]
        n = length(i)
        m = sum(i)/length(i)
        s = sum((x .- m).^2) / n
        append!(info, [n, m, s])
    end
    return Dict("m_x" => info[2], "s_x" => info[3], "n_x" => info[1],
                "m_y" => info[5], "s_y" => info[6], "n_y" => info[4], "g_l" => (info[1] + info[4] - 2))
end
function t_test(x, y, n_1=false)
    check_array(x, y)
    data = make_data(x, y)
    if n_1 == true
        t_statistic = (data["m_x"] - data["m_y"]) / sqrt((((data["n_x"]-1) * data["s_x"] + data["n_y"] * data["s_y"]) / data["g_l"]) * (((data["n_x"]-1) + data["n_y"]) / (data["n_x"] * data["n_y"])))
    else
        t_statistic = (data["m_x"] - data["m_y"]) / sqrt((((data["n_x"]) * data["s_x"] + data["n_y"] * data["s_y"]) / data["g_l"]) * (((data["n_x"]) + data["n_y"]) / (data["n_x"] * data["n_y"])))
    end
    return t_statistic
end;