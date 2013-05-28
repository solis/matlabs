function [] = main 
    X = 0:0.1:3;

    T_MAX =  max(X) / a;
    T_COUNT = 10;
    T_STEP = T_MAX / T_COUNT;

    T = 0:T_STEP:T_MAX;    
    
    disp('Computing numeric');
    U = compute_solution(X, T, @(x,t) numeric_solution(x, t));
    disp('Computing analytic');
    U_a = compute_solution(X, T, @(x,t) analytic_solution(x, t));
    plot_contour(X, T, U, U_a);
    plot_surface(X, T, U, U_a);
    [ ERR_ABS, ERR_REL ] = errors(U, U_a);

    plot_surface_err(X, T, ERR_ABS, ERR_REL);
    animate_solution(X, T, U, U_a);
end
