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
        [C, h] = contourf(X, T, U_a);
        shading flat;
        title('Relative error');
        xlabel('x');
        ylabel('t');
        clabel(C, h);
        colorbar('location', 'EastOutside');
end
