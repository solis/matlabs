function [ u ] = numeric_solution( x, t )
    u =  numeric_solution_v(x, t) + numeric_solution_z(x, t)   + numeric_solution_w(x, t);
end

