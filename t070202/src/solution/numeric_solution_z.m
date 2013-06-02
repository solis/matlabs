function [ u ] = numeric_solution_z( x, t )
    if ( t <= x ./ a )
        u = 0;
    else
        u = mu(t - x ./ a);
    end
end

