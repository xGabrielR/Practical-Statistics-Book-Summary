wrg.filterwarnings("ignore")

pearson_r(ti, df) = √( (ti^2) / (ti^2 + df ) );
glass_delt( x_bari, x_barj, stdi ) = (x_bari - x_barj) / stdi;
cohen_d(x_bari, x_barj, stdi, stdj) = ( x_bari - x_barj ) / √( ( stdi^2 + stdj^2 ) / 2 );
hedge_g( d, ni, nj ) = ( d * ( 1 - ( 3 / (4*(ni + nj - 9)))));

function cramer_v( x, y )
    cm = freqtable(x, y)
    n  = sum(cm)
    r, k = size(cm)
    
    chi2 = ChisqTest( cm ).stat
    chi2corr = max( 0, chi2 - ((( k-1 ) * ( r-1 )) / ( n-1 ) ))
    
    kcorr = k - ((( k-1 )^2) / ( n-1 ))
    rcorr = r - ((( r-1 )^2) / ( n-1 ))

    return sqrt( ( chi2corr / n ) / ( min( kcorr - 1, rcorr - 1 ) ) )
end;

function permutation(x, n_a, n_b)
    n = n_a + n_b
    rand_b = sample(1:n, n_b)
    rand_a = setdiff(1:n, rand_b)
    return np.mean(x[rand_b]) - np.mean(x[rand_a])
end;

function pages()
    info = []
    for i in ["Page A", "Page B"]
        mean = np.mean( df[df.Page .== i, 2] )
        std = np.std( df[df.Page .== i, 2] )
        n = length(df[df.Page .== i, 2])
        [append!(info, k) for k in [mean, std, n]];
    end
    return Dict("mean_a" => info[1], "std_a" => info[2], "n_a" => info[3],
                "mean_b" => info[4], "std_b" => info[5], "n_b" => info[6])
end;

function generate_data( x, y, z )
    res = []
    for k in [x, y, z]
        mean = np.mean( k )
        std = np.std( k )
        append!(res, [mean, std])
    end
    return Dict("mean_x1" => res[1], "std_x1" => res[2],
                "mean_x2" => res[3], "std_x2" => res[4],
                "mean_x3" => res[5], "std_x3" => res[6])
end

function plot_permutation(x1, x2, x3, mean_diff )
    fig, ax = plt.subplots( 1, 3, figsize=(15, 4));
    for i in zip([x1, x2, x3], [1, 2, 3])
        ax[i[2]].hist(i[1], histtype="step", color="r", linewidth=2)
        ax[i[2]].axvline( x=mean_diff, c="b", lw=1, ls="--", label="Mean Diff" );
        ax[i[2]].legend()
    end;
end;

function plot_page_diff()
    fig, ax = plt.subplots( figsize=(7, 5) )
    ax.hist( df[df.Page .== "Page A", 2], histtype="step", linewidth=2, color="r", label="Page A")
    ax.hist( df[df.Page .== "Page B", 2], histtype="step", linewidth=2, color="b", label="Page B")
    ax.hlines( y=2.0, xmin=-0, xmax=4., linestyle="--", color="k" )
    ax.set_xlabel("Time")
    ax.set_ylabel("Count")
    ax.legend();
end;

# function chi2_func( observed, expected )
#     pearson_res = []
#     for re in zip(observed, expected)
#         append!(pearson_res, [(i - re[2])^2 / re[2] for i in re[1]])
#     end
#     return sum(pearson_res)
# end

# function permutation_chi2_julia()
#     data = append!(vec(zeros(1, 2266)), vec(ones(1, 34)))
#     data = round.(Int, data)
#     values = [[14, 8, 12], [986, 992, 988]]
#     expected = [34/3, 1000-(34/3)];
#     chi2obsv = chi2_func(values, expected)
    
#     function permutation_box( data )
#         sample_click = [sum(py"samp"(sort(data))), sum(py"samp"(sort(data))), sum(py"samp"(sort(data)))]
#         sample_noclick = [(1000 - i) for i in sample_click]
#         return chi2_func([sample_click, sample_noclick], expected)
#     end
#     perm_chi2 = [permutation_box( data ) for _ in 1:2000]
#     resample_p = sum(perm_chi2 .> chi2obsv) / length(perm_chi2)
    
#     return [chi2obsv, resample_p]
# end

function perm(data)
    sample_click = [sum(py"samp"(sort(data))), sum(py"samp"(sort(data))), sum(py"samp"(sort(data)))]
    sample_noclick = [(1000 - i) for i in sample_click]
    return ss.chi2_contingency([sample_click, sample_noclick])[1]
end

function perm_test_julia()
    data = append!(vec(zeros(1, 2266)), vec(ones(1, 34)))
    data = round.(Int, data)
    chi2obs = ss.chi2_contingency([[14, 8, 12], [986, 992, 988]])[1]

    R = [perm(data) for _ in 1:2_000]
    p_perm = sum(R .> chi2obs) / length(R)
    
    return (chi2obs, p_perm)
end