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
