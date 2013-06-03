function [] = t070205

    load('t070205/solution.mat');

    X = 0:0.01:1;
    Y = 0:0.01:1;

    UXY = tri2grid(p, t, u, X, Y);

    [X, Y] = meshgrid(X, Y);
    AXY = X.*cos(Y) + Y.*sin(X);
    AXY(isnan(UXY)) = NaN;

    AERR = abs(UXY - AXY);
    RERR = AERR ./ UXY;

    %%Визуализация

    subplot(2, 1, 1)
    surf(X, Y, UXY);
    title('PDETool solution')
    shading flat;
    view(-128, 46);

    subplot(2, 1, 2)
    surf(X, Y, AXY);
    title('Exact solution');
    shading flat;
    view(-128, 46);

    figure;

    subplot(2, 1, 1);
    [C, h] = contourf(X, Y, UXY);
    title('PDETool solution');
    clabel(C, h);
    colorbar('EastOutside');

    subplot(2, 1, 2);
    [C, h] = contourf(X, Y, AXY);
    title('Exact solution');
    clabel(C, h);
    colorbar('EastOutside');


    figure;

    subplot(2, 1, 1);
    [C, h] = contourf(X, Y, AERR);
    title('Absolute error');
    clabel(C, h);
    colorbar('EastOutside');


    subplot(2, 1, 2);
    [C, h] = contourf(X, Y, RERR);
    title('Relative error');
    clabel(C, h);
    colorbar('EastOutside');

    clear p; clear u; clear t; clear e;
end
