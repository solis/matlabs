function visualize(x, f, x_bessel, f_bessel, x_legendre, f_legendre)
    scrsz = get(0, 'ScreenSize');  
    
    %% 1. Разложение в ряд Фурье с помощью функций Бесселя
    figure('Position', [50 125 scrsz(3)-250 scrsz(4)-250], 'Name', '1. Разложение в ряд Фурье с помощью функций Бесселя', 'NumberTitle', 'off');
    
    % Графики исходной функции и разложения с помощью функций Бесселя
    axis([min(x) - 0.2 , max(x) + 0.2, min(f_bessel) - 0.5 , max(f_bessel) + 0.5])
    hold on;
        plot(x, f, 'Color', 'blue', 'LineWidth', 2);
        plot(x_bessel, f_bessel, 'Color', 'red', 'LineWidth', 2);
        title('Исходная функция и разложение с помощью функций Бесселя');
        xlabel('x');
        ylabel('y');
    hold off;
    
    %% 2. Разложение в ряд Фурье с помощью функций Лежандра
    figure('Position', [75 100 scrsz(3)-250 scrsz(4)-250], 'Name', '2. Разложение в ряд Фурье с помощью функций Лежандра', 'NumberTitle', 'off');
    
    % Графики исходной функции и разложения с помощью функций Лежандра
    axis([min(x) - 0.2 , max(x) + 0.2, min(f_legendre) - 0.5 , max(f_legendre) + 0.5])
    hold on;
        plot(x, f, 'Color', 'blue', 'LineWidth', 2);
        plot(x_legendre, f_legendre, 'Color', 'red', 'LineWidth', 2);
        title('Исходная функция и разложение с помощью функций Лежандра');
        xlabel('x');
        ylabel('y');
    hold off;
end