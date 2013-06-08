function [] = plot_contour_err(X, T, U, U_a)
    figure;
    subplot(2, 1, 1)
        [C, h] = contourf(X, T, U, 20);
        shading flat;
        title('Absolute error');
        xlabel('x');
        ylabel('t');
        clabel(C, h);
        colorbar('location', 'EastOutside');


    subplot(2, 1, 2)
        [C, h] = contourf(X, T, U_a, 20);
        shading flat;
        title('Relative error');
        xlabel('x');
        ylabel('t');
        clabel(C, h);
        colorbar('location', 'EastOutside');
end
