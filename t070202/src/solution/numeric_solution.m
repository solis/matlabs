function [ u ] = numeric_solution( x, t )
    v = @(x, t) numeric_solution_v(x, t);
    w = @(x, t) numeric_solution_w(x, t);
    z = @(x, t) numeric_solution_z(x, t);

    u = v(x, t) + w(x, t) + z(x, t);
end

