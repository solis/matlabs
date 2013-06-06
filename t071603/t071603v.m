function t071603v
    clc; clear all;
    
    disp('Loading solutions..');
    load('solutions.mat');
    clc;
    
    disp('Visualising solutions..');
    scrsz = get(0, 'ScreenSize');
    
    %% 1. Поверхности точного и приближённого решений

    figure('Position', [50 125 scrsz(3)-250 scrsz(4)-250], 'Name', '1. Поверхности точного и приближённого решений', 'NumberTitle', 'off');

    % График поверхности точного решения
    subplot(1, 2, 1);
    grid on;
    hold on;
        surf(X, T, exact_solution, 'EdgeColor', 'none');
        view(-160, 28)
        title('Поверхность точного решения');
        xlabel('x');
        ylabel('t');
        zlabel('u(x,t)');
    hold off;

    % График поверхности приближённого решения
    subplot(1, 2, 2);
    grid on;
    hold on;
        surf(X, T, numerical_solution, 'EdgeColor', 'none');
        view(-160, 28)
        title('Поверхность приближённого решения');
        xlabel('x');
        ylabel('t');
        zlabel('u(x,y)');
    hold off;


    %% 2. Линии уровня точного и приближённого решений

    figure('Position', [75 100 scrsz(3)-250 scrsz(4)-250], 'Name', '2. Линии уровня точного и приближённого решений', 'NumberTitle', 'off');
    
    % График линий уровня точного решения
    subplot(1, 2, 1);
    grid on;
    hold on;
        [C, h] = contour(X, T, exact_solution, 10, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('Линии уровня точного решения');
        xlabel('x');
        ylabel('t');
    hold off;

    % График линий уровня приближённого решения
    subplot(1, 2, 2);
    grid on;
    hold on;
        [C, h] = contour(X, T, numerical_solution, 8, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('Линии уровня приближённого решения');
        xlabel('x');
        ylabel('t');
    hold off;


    %% 3. Линии уровня абсолютной и относительной погрешности

    figure('Position', [100 75 scrsz(3)-250 scrsz(4)-250], 'Name', '3. Линии уровня абсолютной и относительной погрешности', 'NumberTitle', 'off');

    % График линий уровня абсолютной погрешности
    subplot(1, 2, 1);
    hold on;
        [C, h] = contour(X, T, abs(exact_solution - numerical_solution), 8, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('Линии уровня абсолютной погрешности');
        xlabel('x');
        ylabel('t');
    hold off;

    % График линий уровня относительной погрешности
    subplot(1, 2, 2);
    hold on;
        [C, h] = contour(X, T, abs((exact_solution - numerical_solution) ./ exact_solution), 8, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('Линии уровня относительной погрешности');
        xlabel('x');
        ylabel('t');
    hold off;
    
    clc;
    disp('Visualising: done.');
end