function [] = plot_surface(X, T, U, U_a)
    figure;
    subplot(2, 1, 1)
        surface(X, T, U)
        shading flat;
        title('Absolute error surface');
        xlabel('x');
        ylabel('t');
        zlabel('Absolute error at (x,t)');
        view(-99, 51);

    subplot(2, 1, 2)
        surface(X, T, U_a)
        shading flat;
        title('Relative error surface');
        xlabel('x');
        ylabel('t');
        zlabel('Relative error at (x,t)');
        view(-99, 51)
end
