function [ u ] = numeric_solution_w( x, t )
    if ( t < x / a )
        u = dblquad( @(z, p)  f(z, p) .* (z >= x - a*(t - p)) .* (z <= x + a*(t - p)), 0, x + a*t, 0, t) / (2*a);
    else
        if (t > x / a)
            i1 = 0;
            i2 = 0;
            i1 = dblquad( @(z, p) f(z, p) .* (z >= a*(t - p) - x) .* (z <= x + a*(t - p)), 0, x + a*t, 0, t - x / a);
            i2 = dblquad( @(z, p) f(z, p) .* (z >= x - a*(t - p)) .* (z <= x + a*(t - p)), 0, 2*x, t - x / a, t);
            u = (i1 + i2) / (2*a);
            else
                u = (numeric_solution_w(x + 0.0001, t) + numeric_solution_w(x - 0.0001, t)) /2;
        end
    end
end

