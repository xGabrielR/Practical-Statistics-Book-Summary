
linear(x, a, b) = a * x .+ b


function plot_afim_function(a, b)
    fig, ax = plt.subplots(1, 2, figsize=(15, 5))
    x = collect(-10:.1:10)
    for i in zip([1, 2], [a, -a], ["Crescente", "Decrescente"])
        y = [linear(x, i[2], 1) for xi in x];
        ax[i[1]].hlines( 0, x[1], x[end], color="#12004f", linewidth=2, linestyle="-");
        ax[i[1]].scatter(x, y[1], s=3, label=@sprintf "a: %d b: %d" a b)
        ax[i[1]].set_xlabel("x")
        ax[i[1]].set_ylabel("y")
        ax[i[1]].set_title("Função" * i[3])
        ax[i[1]].legend()
    end;
end;

function plot_afim_function_new(a, b)
    fig, (ax1, ax2) = plt.subplots( 1, 2, figsize=(13, 4) )
    for i in zip( [[a * p + b for p in collect( -5:1:10 )], [-a * p + b for p in collect( -5:1:10 )]], 
                   [ax1, ax2], ["r", "b"], ["Função Crescente", "Função Decrescente"], [-7, -15], ["α > 0", "α < 0"] )
        i[2].plot( i[1], c=i[3], label=i[6] );
        i[2].set_title(i[4])
        i[2].hlines( 0, 0, 15, color="#12004f", linewidth=2, linestyle="-");
        i[2].vlines( 0, i[5], 20, color="#12004f", linewidth=2, linestyle="-");
        i[2].legend();
    end
end;

function plot_linear_function()
    fig, ax = plt.subplots( figsize=(5, 4) )
    ax.plot( collect( -5:1:10 ) );
    ax.vlines( 0, -5, 10, color="#12004f", linewidth=2, linestyle="-")
    ax.hlines( 0, -.1, 15, color="#12004f", linewidth=2, linestyle="-");
    ax.vlines( 10, 0, 5, color="k", linestyle="--" )
    ax.hlines( 5, 0, 10, color="k", linestyle="--" )
    ax.scatter( 5, 0, c="r" )
    ax.scatter( 10, 5, c="g" )
    ax.set_title("Função do 1° Grau");
end;

function plot_quadratic_function()
    fig, (ax1, ax2) = plt.subplots( 1, 2, figsize=(13, 5) )
    for i in zip( [[1p^2 + 1p + 1 for p in collect(-5:.5:5)], [-1p^2 + 1p + 1 for p in collect(-5.5:.5:5.5)]],
                   [ax1, ax2], [1, .09], ["c", "m"], ["a > 0", "a < 0"], ["Concavidade Positiva", "Concavidade Negativa"] )
        i[2].plot( i[1], c=i[4], label=i[5] );
        i[2].hlines( -2, 0, 15, color="#12004f", linewidth=2, linestyle="-");
        i[2].scatter( 10, i[3], c="b", label="X = 1" )
        i[2].set_title(i[6])
        i[2].legend();
    end
    ax1.vlines( 10, -4, 30, color="#12004f", linewidth=2, linestyle="-");
    ax2.vlines( 10, -30, 10, color="#12004f", linewidth=2, linestyle="-");
end;

function plot_quadratic_function_new(a, b, c)
    fig, (ax1, ax2) = plt.subplots( 1, 2, figsize=(13, 5) )
    for i in zip( [[a*p^2 + b*p + c for p in collect(-5:.5:5)], [(-a*p^2) + b*p + c for p in collect(-5.5:.5:5.5)]],
                   [ax1, ax2], [1, .09], ["c", "m"], ["a > 0", "a < 0"], ["Concavidade Positiva", "Concavidade Negativa"] )
        i[2].plot( i[1], c=i[4], label=i[5] );
        i[2].hlines( -2, 0, 15, color="#12004f", linewidth=2, linestyle="-");
        i[2].scatter( 10, c, c="b", label=@sprintf "C: %d" c  )
        i[2].set_title(i[6])
        i[2].legend();
    end
    ax1.vlines( 10, -4, 30, color="#12004f", linewidth=2, linestyle="-");
    ax2.vlines( 10, -30, 10, color="#12004f", linewidth=2, linestyle="-");
end;

function plot_exp()
    fig, (ax1, ax2) = plt.subplots( 1, 2, figsize=(13, 4) )
    for i in zip( [[exp(p) for p in collect(-5:.5:5)], [exp(-p) for p in collect(-5:.5:5)]], 
                   [ax1, ax2], ["r", "b"], ["Exponencial Crescente", "Exponencial Decrescente"], ["a > 1", "a ]0, 1["], [17, 3] )
        i[2].plot( i[1], color=i[3], label=i[5] );
        i[2].hlines( 0, 0, 20, color="#12004f", linewidth=2, linestyle="-");
        i[2].scatter( i[6], 35, c="c", label="1" )
        i[2].set_title(i[4])
        i[2].legend()
    end
    ax1.vlines( 17, -5, 150, color="#12004f", linewidth=2, linestyle="-");;
    ax2.vlines( 3, -5, 150, color="#12004f", linewidth=2, linestyle="-");
end;

function plot_log()
    fig, (ax1, ax2) = plt.subplots( 1, 2, figsize=(13, 4) )
    for i in zip( [[log(i) for i in 0:.1:20], [-log(Complex(i)) for i in -50*10:1:50*10]], [ax1, ax2], ["c", "m"],
                   [350, 650], [-1, 1], ["navy", "darkorchid"] )
        i[2].plot( i[1], color=i[3], label="Log" );
        i[2].set_title("Função Logarítimica")
        ax2.scatter( i[4], -5, c=i[6], label=i[5] )
        ax1.scatter( 28, 1, c="k", label="1" )
        i[2].legend();
    end;
    ax1.vlines( 0, -2, 3, color="#12004f", linewidth=2, linestyle="-")
    ax1.hlines( 1, 0, 120, color="#12004f", linewidth=2, linestyle="-")
    ax2.hlines( -5, 10*100, -50, color="#12004f", linewidth=2, linestyle="-")
    ax2.vlines( 499, -6, -1, color="#12004f", linewidth=2, linestyle="-");
end;

function limit_example()
    fig, (ax1, ax2, ax3) = plt.subplots( 1, 3, figsize=(15, 5)) # Precisa Melhorar KKKKKKKKK
    for i in [ax1, ax2, ax3]
        i.plot( collect( -2:1:10 ) );
        i.vlines( 7, 0, 5, color="navy", linestyle="--" )
        i.hlines( 5, 0, 7, color="navy", linestyle="--" )
        i.vlines( 0, -2, 10, color="#12004f", linewidth=2, linestyle="-")
        i.hlines( 0, -.1, 15, color="#12004f", linewidth=2, linestyle="-");

        if i == ax1
            i.vlines( 10, 0, 8, color="k", linestyle="--" )
            i.hlines( 8, 0, 10, color="k", linestyle="--" )
            i.vlines( 4, 0, 2, color="k", linestyle="--" )
            i.hlines( 2, 0, 4, color="k", linestyle="--" )
            i.scatter( 7, 5, c="r" )
            i.scatter( 6, 4, c="y" )
            i.scatter( 5, 3, c="y" )
            i.scatter( 4, 2, c="y" )
            i.scatter( 8, 6, c="aqua" )
            i.scatter( 9, 7, c="aqua" )
            i.scatter( 10, 8, c="aqua" )
            i.set_title("Noção de Limite");

        elseif i == ax2
            i.vlines( 9, 0, 7, color="k", linestyle="--" )
            i.hlines( 7, 0, 9, color="k", linestyle="--" )
            i.vlines( 5, 0, 3, color="k", linestyle="--" )
            i.hlines( 3, 0, 5, color="k", linestyle="--" )
            i.scatter( 7, 5, c="r" )
            i.scatter( 6, 4, c="y" )
            i.scatter( 5, 3, c="y" )
            i.scatter( 8, 6, c="aqua" )
            i.scatter( 9, 7, c="aqua" )
            i.set_title("Noção de Limite");

        else
            i.vlines( 7, 0, 5, color="navy", linestyle="--" )
            i.hlines( 5, 0, 7, color="navy", linestyle="--" )
            i.vlines( 0, -2, 10, color="#12004f", linewidth=2, linestyle="-")
            i.hlines( 0, -.1, 15, color="#12004f", linewidth=2, linestyle="-");
            i.vlines( 8, 0, 6, color="k", linestyle="--" )
            i.hlines( 6, 0, 8, color="k", linestyle="--" )
            i.vlines( 6, 0, 4, color="k", linestyle="--" )
            i.hlines( 4, 0, 6, color="k", linestyle="--" )
            i.scatter( 7, 5, c="r" )
            i.scatter( 6, 4, c="y" )
            i.scatter( 8, 6, c="aqua" )
            i.set_title("Noção de Limite")
        end
    end;
end;

function derivative()
    fig, ax = plt.subplots( figsize=(5, 4) )
    ax.plot( [1p^2 + 1p + 1 for p in collect(:.5:20)], linewidth=3 );

    for i in zip( [20, 16, 10], ["Reta Secante", "Reta Secante", "Reta Tangente"], 
                  [14.9, 11, 5], [250, 140, 30], ["orange", "g", "r"] )
        ax.plot( [i[1]*p + 10 for p in collect(-3:1:20)], label=i[2] )
        ax.hlines( 0, -.1, 25, color="#12004f" )
        ax.vlines( 3, -50, 350, color="#12004f" )
        ax.scatter( i[3], i[4], c=i[5] )
        ax.legend();
    end
    ax.vlines( 5, -15, 25, linestyle="--", color="k")
end;

function complex_functions()
    fig, (ax1, ax2) = plt.subplots( 1, 2, figsize=(15, 6))
    for k in [ax1, ax2]
        if k == ax1
            x = collect(-1:.01*.8:1)
            k.plot(x, x.^2 + np.exp(-2*(x .- .18).^2), color="b");
            for i in zip( [1, .5], [1.25, 1.05], ["r", "c"], ["b", "a"] )
                k.vlines( i[1], 0, i[2], color=i[3], label=i[4], linestyle="--" )
            end
            k.hlines( 0, -1, 1, color="#12004f", linewidth=2 )
            k.vlines( 0, -.1, 1, color="#12004f", linewidth=2 )
        else
            x = [-log(i) for i in 1*10:1:50*10]
            k.plot( x, color="b" );
            for i in zip( [200, 300], [-5.4, -5.7], ["r", "c"], ["b", "a"] )
                k.vlines( i[1], i[2], -4, color=i[3], label=i[4], linestyle="--" )
            end
            k.hlines( -4, 0, 400, color="#12004f", linewidth=2 )
            k.vlines( 0, 0, -5, color="#12004f", linewidth=2 )
        end
        k.legend()
    end;
end;

###
# Questions List
###

function question_one(a, b)
    fig, ax = plt.subplots( figsize=(5, 5) );
    ax.hlines( 0, -5, 15, color="#12004f", linewidth=2, linestyle="-");
    ax.vlines( 0, -4, 15, color="#12004f", linewidth=2, linestyle="-");
    ax.scatter( [1, 3], [5, -1], color="r" )
    ax.plot( [.8, 3.3], [6, -2], c="b", label="Afim" )
    ax.plot( [(a) * p + b for p in collect(-.05:5)], c="g", linestyle="--", label="Reta da Fórmula" ) #-3x + 8
    ax.legend();
end;
