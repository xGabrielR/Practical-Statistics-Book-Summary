"""
    hedge_g function correction of value of cohen_d.
"""
include("cohen_d.jl");

function hedge_g(x, y)
    d = cohen_d(x, y)
    n_x = length(x)
    n_y = length(y)
    
    return ( d * ( 1 - ( 3 / (4*(n_x + n_y - 9)))));
end;