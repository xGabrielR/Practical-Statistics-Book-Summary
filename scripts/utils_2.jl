

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

function prepare_dataset(df)
    x = df[:, 1:8];
    x = hcat(x[:, 1], x[:, 2], x[:, 3], x[:, 4], x[:, 5], x[:, 6], x[:, 7]);

    y = df[:, 9];

    # Transform Variables
    mms = prepro.MinMaxScaler()
    x = mms.fit_transform( x );

    # Split Dataset
    x_train, x_test, y_train, y_test = md_sel.train_test_split( x, y, train_size=0.9 );

    return x_train, x_test, y_train, y_test 
end

function plot_three_bn( prob, colors, label )
    for i in zip( [0.1, 0.5, 0.9], ["r", "g", "b"], ["Prob: 10%", "Prob: 50%", "Prob: 90%"] )
        res = [ss.binom.pmf(r, 10, i[1]) for r in 0:10]
        plt.bar(Array(1:11), res, color=i[2], label=i[3]);
        plt.legend()
    end
end;

function plot_poisson( x, c )
    fig, ax = plt.subplots( figsize=(7, 4) )
    ax = sns.distplot(x, color=c, hist=false, label="Poisson");
    ax.vlines( np.mean(x), 0, 0.27, color="k", linestyle="--", label="Média" )
    ax.vlines( np.median(x), 0, 0.27, color="c", linestyle="--", label="Mediana" )
    ax.vlines( 0, -0.05, 0.28, color="#12004f", linewidth=2, linestyle="-")
    ax.hlines( -0.001, -1.7, 8.5, color="#12004f", linewidth=2, linestyle="-")
    ax.set_xlabel("Contagem");
    ax.set_ylabel("Densidade");
    ax.set_title("Distribuição Poisson")
    ax.legend();
end;

function plot_normal( x, sim=true )
    fig, ax = plt.subplots( figsize=(7, 4) )
    ax.plot(x, ss.norm.pdf(x), color="b", linewidth=2, label="Normal");
    ax.hlines( .003, -4, 4, color="k")
    ax.vlines( 0, 0, 0.4, color="k", linestyle="--", label="Média")
    ax.set_title("Distribuição Normal")
    fig.legend();
    if sim == true 
        [ax.vlines(  i, 0, 0.24, color="r") for i in -1:1 if i != 0]
        [ax.vlines(  i, 0, 0.055, color="r") for i in -2:2 if i != 0]
        [ax.vlines( -i, 0, (0.50/(i*2.0)-.01), color="r", linestyle="--" ) for i in 1:.1:1.3];
        [ax.vlines( -i, 0, (0.50/(i*2.3)-.01), color="r", linestyle="--" ) for i in 1.3:.1:1.6];
        [ax.vlines( -i, 0, (0.50/(i*3)-.01), color="r", linestyle="--" )   for i in 1.6:.1:1.9];
        [ax.vlines(  i, 0, (0.50/(i*2.0)-.01), color="r", linestyle="--" ) for i in 1:.1:1.3];
        [ax.vlines(  i, 0, (0.50/(i*2.3)-.01), color="r", linestyle="--" ) for i in 1.3:.1:1.6];
        [ax.vlines(  i, 0, (0.50/(i*3)-.01), color="r", linestyle="--" )   for i in 1.6:.1:1.9];
    else
    end
end;

function plot_qq(x, y, z, g_type)
    fig, (ax1, ax2, ax3, ax4, ax5, ax6) = plt.subplots( 2, 3, figsize=(16, 7) )
    ss.probplot( x, dist="norm", plot=ax1 );
    ss.probplot( y, dist="norm", plot=ax5 );
    ss.probplot( z, dist="norm", plot=ax3 );
    for i in zip( [ax2, ax6, ax4], [x, y, z], ["Normal", "Log", "Skewed"], ["r", "g", "b"] )
        i[1].hist( i[2], histtype=g_type, linewidth=2, color=i[4], label=i[3] );
        i[1].legend()
        i[1].set_ylabel("Density")
        i[1].set_xlabel("Bins")
        plt.show()
    end;
end;

function plot_exp( x, c )
    fig, ax = plt.subplots( figsize=(7, 4) )
    ax = sns.distplot(x, color=c, hist=false, label="Exponencial");
    ax.set_xlabel("Contagem");
    ax.vlines( np.mean(x), 0, 0.4, color="k", linestyle="--", label="Média" )
    ax.vlines( np.median(x), 0, 0.55, color="c", linestyle="--", label="Mediana" )
    ax.vlines( 0, 0, 0.7, color="#12004f", linestyle="-")
    ax.vlines( 0, -0.05, 0.28, color="#12004f", linewidth=2, linestyle="-")
    ax.hlines( -0.001, -1.7, 8.5, color="#12004f", linewidth=2, linestyle="-")
    ax.set_title("Distribuição Exponencial")
    ax.legend();
end;

function plot_wei(x)
    fig, ax = plt.subplots( figsize=(7, 4) )
    ax = sns.distplot( x, color=c, label="Weibull");
    ax.hlines( -.1/(1000*100), 150*150, -200, color="#12004f", linewidth=2, linestyle="-")
    ax.vlines( -.1/(1000*100), -.1/(500*10), .1/(500), color="#12004f", linewidth=2, linestyle="-")
    ax.set_title("Distribuição Weibull")
    ax.legend();
end;

function plot_permutation(x, d, c1, c2, ex, with_ex=false)
    fig, ax = plt.subplots( figsize=(6, 5))
    ax.hist(x, histtype="step", color="r", linewidth=2)
    ax.axvline( x=d, c=c1, lw=1, ls="--", label="Diferença" );
    if with_ex == true
        ax.vlines( ex, 0, 100, color=c2 );
        plt.legend();
    else
        plt.legend();
    end
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