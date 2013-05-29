%% Задание 06. Разложение в ряды Фурье с помощью функций Бесселя и Лежандра
% Бинарное представление 716: 1011001100
% Минимальное значение функции: 0.3
% Максимальное значение функции: 1.3
% Начальное положение: (1, 1)
% Функция: f_x = [0.1, 0.4, 0.7, 0.8, 1.0, 1.1, 1.3, 1.6, 1.8, 2.0]
%          f_y = [1.3, 0.3, 1.3, 1.3, 0.3, 0.3, 1.3, 1.3, 0.3, 0.3]

function t071606
    %% Начальная инициализация
    f_x = [0.1, 0.4, 0.7, 0.8, 1.0, 1.1, 1.3, 1.6, 1.8, 2.0];
    f_y = [1.3, 0.3, 1.3, 1.3, 0.3, 0.3, 1.3, 1.3, 0.3, 0.3]; 
    x_0         = 1;
    y_0         = 1;
    summ_count  = 25;
       
    x_step = 0.00005;
    approximation_step = 0.05;
    
    x_legendre = -1:approximation_step:1;
    x_bessel = 0:approximation_step:1;
    x = x_0:x_step:(x_0 + max(f_x));
    
    f = build_f(f_x, f_y, x_0, y_0, x);

    legendre_transform = @(t) (((t+1)/2)*max(f_x) + x_0);
    bessel_transform = @(t) (t*max(f_x) + x_0);  
 
    %% Разложение в ряд Фурье с помощью функций Бесселя
    disp('Bessel approximating');
    f_bessel = zeros(1, length(x_bessel));
    for i = 1:length(x_bessel)
        f_bessel(i) = bessel_approximation(@(t) (build_f(f_x, f_y, x_0, y_0, bessel_transform(t))),...
            x_bessel(i), summ_count);
    end
    
    %% Разложение в ряд Фурье с помощью функций Лежандра
    disp('Legendre approximating');
    f_legendre = zeros(1,length(x_bessel));
    for i = 1:length(x_legendre)
        f_legendre(i) = legendre_approximation(@(t) (build_f(f_x, f_y, x_0, y_0, legendre_transform(t))),...
            x_legendre(i), summ_count);
    end
    
    %% Визуализация разложений
    disp('Visualizing');  
    visualize(x, f, bessel_transform(x_bessel), f_bessel, legendre_transform(x_legendre), f_legendre);
end