function [ u ] = numeric_solution_w( x, t )
    if ( t < x / a )        
        u = dblquad( @(z, p) f(z, p) .* (z >= x - a*(t - p)) .* (z <= x + a*(t - p)), x - a*t, x + a*t, 0, t) / (2*a);    
    else
        if ( t > x / a )
            i1 = -(6*x * ((x - a*t).^2))/(a.^2) + (28*x*(x - a*t)/ a) +  48*x*( a*t.^2 - x.^2/a);

            % Я не могу понять почему э
            
            %i1 = dblquad( @(z, p) f(z, p) .* (z >= a*(t - p) - x) .* (z <= x + a*(t - p)), 0, a*t + x, 0, t);            
            i2 = dblquad( @(z, p) f(z, p) .* (z >= x - a*(t - p)) .* (z <= x + a*(t - p)), x - a*t, x + a*t, t - x / a, t);                        
            u = (i1 + i2) / (2*a);                  
        else
            % Доопределим функцию в точке t = u, занчением  в точке (x + 0.0001, t). Это заодно не будет вводить quad в замешательство, когда промежуток интегрирования становится длинны 0
            u = numeric_solution_w(x + 0.0001, t);
        end
    end
end

