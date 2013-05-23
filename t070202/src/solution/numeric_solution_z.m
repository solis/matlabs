function [ u ] = numeric_solution_z( x, t )
    if ( t >= x / a )
        u = mu(t - x / a);
    else
        u = 0;
    end
end

