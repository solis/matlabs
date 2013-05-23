function [] = plot_surface(X, T, U, U_a)
    figure;
    subplot(2, 1, 1)
        surface(X, T, U)
        shading flat;
        title('Numeric solution surface');
        xlabel('x');
        ylabel('t');
        zlabel('u(x,t)');        
        view(-99, 51);

    subplot(2, 1, 2)
        surface(X, T, U_a)
        shading flat;
        title('Analytic solution surface');
        xlabel('x');
        ylabel('t');
        zlabel('u(x,t)');
        view(-99, 51)
end
