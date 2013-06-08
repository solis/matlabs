function [] = plot_contour(X, T, U, U_a)
    figure;
    subplot(2, 1, 1), contourf(X, T, U);
    title('Numeric solution contour');
    colorbar('location', 'EastOutside')
    xlabel('x');
    ylabel('t');

    subplot(2, 1, 2), contourf(X, T, U_a);
    title('Analytic solution contour', 'FontName', 'Arial Cyr');
    colorbar('location', 'EastOutside')
    xlabel('x');
    ylabel('t');
end
