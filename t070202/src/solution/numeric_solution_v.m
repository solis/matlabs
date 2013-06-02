function [ u ] = numeric_solution_v( x, t )
     if (t <= x ./ a)
            u = (phi( x + a.*t ) + phi( x - a.*t )) / 2 + (1 / (2*a)) * quad(@(x) Psi(x), x - a*t, x + a*t);
     else
            u = (phi( x + a.*t ) - phi( a.*t - x )) / 2 + (1 / (2*a)) * quad(@(x) Psi(x), a*t - x, x + a*t);
     end
end

