%% Лабораторная работа №6
% 719: 1011001111
function t071906
function f = Function(f_x, f_y, x, y, u)
    f = zeros(1, length(u));
    for k = 1:length(u)
        u(k) = u(k) - x;
        j = 1;
        while (j <= length(f_x)) && (u(k) > f_x(j))
            j = j + 1;
        end
        if (j < length(f_x) || (u(k) > 0))
            f(k) = y + f_y(j);
        end
    end
end

%% Общие переменные
f_x = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
f_y = [2.0, 1.0, 2.0, 2.0, 1.0, 1.0, 2.0, 2.0, 2.0, 2.0]; 
x_0         = 0;
y_0         = 1;
summ_count  = 20;

step = 0.00005;
approximation_step = 0.05;

xLegendre = -1:approximation_step:1;
xBessel = 0:approximation_step:1;
x = x_0:step:(x_0 + max(f_x));

f = Function(f_x, f_y, x_0, y_0, x);    

%% Разложение в ряд Фурье с помощью функций Бесселя
function approximation = bessel_approximation(f, x, summ_count)
    approximation = 0;
    for k = 1:summ_count
        Z = fzero(@(x) (besselj(0, x)), [(k - 1), k]*pi);
        approximation = approximation + besselj(0, x*Z)*2*quad(@(t) (t.*besselj(0, Z*t).*f(t)), 0, 1)/(besselj(1, Z)).^2;
    end
end
bessel_transform = @(t) (t*max(f_x) + x_0);
f_bessel = zeros(1, length(xBessel));
for i = 1:length(xBessel)
    f_bessel(i) = bessel_approximation(@(t) (Function(f_x, f_y, x_0, y_0, bessel_transform(t))),...
        xBessel(i), summ_count);
end

%% Разложение в ряд Фурье с помощью функций Лежандра
function approximation = legendre_approximation(f, x, summ_count)
    function y = legendre_n(n, x)
        Y = legendre(n, x, 'norm');
        y = Y(1, 1:length(x));
    end
    approximation = quad(@(t) f(t), -1, 1) / 2;
    for k = 1:summ_count
        approximation = approximation + legendre_n(k, x)*quad(@(t) f(t) .* legendre_n(k,t), -1, 1);
    end
end
legendre_transform = @(t) (((t+1)/2)*max(f_x) + x_0);
f_legendre = zeros(1,length(xBessel));
for i = 1:length(xLegendre)
    f_legendre(i) = legendre_approximation(@(t) (Function(f_x, f_y, x_0, y_0, legendre_transform(t))),...
        xLegendre(i), summ_count);
end

xBessel = bessel_transform(xBessel);
xLegendre = legendre_transform(xLegendre);

set(0, 'Units', 'pixels');
scrsz = get(0,'ScreenSize');

figure('Name', 'Разложение в ряд Фурье с помощью функций Бесселя', 'Position', [50 100 scrsz(3)-250 scrsz(4)-250]);
% Графики исходной функции и разложения с помощью функций Бесселя
axis([min(x) - 0.2 , max(x) + 0.2, min(f_bessel) - 0.5 , max(f_bessel) + 0.5])
hold on;
plot(x, f, 'Color', 'blue', 'LineWidth', 2);
plot(xBessel, f_bessel, 'Color', 'red', 'LineWidth', 2);
title ('Исходная функция и разложение с помощью функций Бесселя');
xlabel ('x');
ylabel ('y');
hold off;

figure('Name', 'Разложение в ряд Фурье с помощью функций Лежандра', 'Position', [25 125 scrsz(3)-250 scrsz(4)-250]);
% Графики исходной функции и разложения с помощью функций Лежандра
axis([min(x) - 0.2 , max(x) + 0.2, min(f_legendre) - 0.5 , max(f_legendre) + 0.5])
hold on;
plot(x, f, 'Color', 'blue', 'LineWidth', 2);
plot(xLegendre, f_legendre, 'Color', 'red', 'LineWidth', 2);
title ('Исходная функция и разложение с помощью функций Лежандра');
xlabel ('x');
ylabel ('y');
hold off;
end