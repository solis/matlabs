function [] = plot_contour(X, T, U, U_a)
    figure;
    subplot(2, 1, 1), [C1,h1] = contour(X, T, U, -0.5:0.05:0);
    clabel(C1, h1, 'LabelSpacing', 300);
    title('Numeric solution contour');
    colorbar('location', 'EastOutside')
    xlabel('x');
    ylabel('t');

    subplot(2, 1, 2), [C2,h2] = contour(X, T, U_a,-0.5:0.05:0);
    clabel(C2, h2, 'LabelSpacing', 300);
    title('Analytic solution contour', 'FontName', 'Arial Cyr');
    colorbar('location', 'EastOutside')
    xlabel('x');
    ylabel('t');

end
