function [] = plot_err(X, T, U, U_a)
    figure;
    subplot(2, 1, 1)
        [C, h] = contourf(X, T, U);
        shading flat;
        title('Absolute error');
        xlabel('x');
        ylabel('t');
        clabel(C, h);
        colorbar('location', 'EastOutside');


    subplot(2, 1, 2)
        [C, h] = contourf(X, T, U_a, [0.0001, 0.0005, 0.001, 0.005, 0.007, 0.009, 0.01, 0.05, 0.1, 0.3, 0.5, 0.8, 1 ]);
        shading flat;
        title('Relative error');
        xlabel('x');
        ylabel('t');
        clabel(C, h);
        colorbar('location', 'EastOutside');
end
