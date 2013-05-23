function [ u ] = numeric_solution_v( x, t )
    if ( t < x / a )
        u = (phi( x + a*t ) + phi( x - a*t )) / 2 + (1 / (2*a)) * quad(@(x) Psi(x), x - a*t, x + a*t);
    else
        if ( t > x / a )
            u = (phi( x + a*t ) - phi( x - a*t )) / 2 + (1 / (2*a)) * quad(@(x) Psi(x), a*t - x, x + a*t);
        else
            % Доопределим функцию в точке t = u, занчением  в точке (x + 0.0001, t). Это заодно не будет вводить quad в замешательство, когда промежуток интегрирования становится длинны 0
            u =  numeric_solution_v(x + 0.0001, t);
        end
    end
end

