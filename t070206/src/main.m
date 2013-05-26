%%
% stud_num   - номер студента
% bar_hi     - высота большого столбца
% bar_lo     - высота маленького столбца
% summ_count - число частных сумм рядов

function [] = main(stud_num, bar_hi, bar_lo, summ_count)
    bars = area_description(stud_num, bar_hi, bar_lo);
    widths = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
    x_0 = 0;
    y_0 = 0;
    X_STEP = 0.01;

    task_f = task_function(bars, widths, x_0, y_0);

    function [ hlegendre ] = Legendre(task_f, summ_count)
        function [ y ] = f(x)
            % значения в точке x n первых функций Лежандра.
            P_n = legendre(summ_count, x, 'norm');

            % Это скорее всего будет не очень эффективно, но пока так

            % Объявим sneaky-tricky функцию, которая будет возвращать значение полинома Лежандра
            % n-ого порядка, в точке x
            function [ y ] = legendren(n, x)
                % Это самый медленный момент. Вообще говоря если quad для разных
                % порядков будет проходить по тем же точкам, то имеет смысл сохранять
                % этот массив. Но похоже что нет.
                Y = legendre(summ_count, x, 'norm');
                y = Y(n,1:length(x));
            end
            y = 0;
            for k = 1:summ_count
                y = y + P_n(k)*quad(@(t) task_f(t) * legendren(k,t), -1, 1);
            end
        end
        hlegendre = @f;
    end

    function [ hbessel ] = Bessel(task_f, summ_count)
        function [ z ] = besselzero(alpha, n)
            z = fzero(@(x)besselj(alpha , x), n);
        end

        Z = zeros(summ_count);
        for k = 1:length(Z)
            Z(k) = besselzero(summ_count, k);
        end


        function [ y ] = f(x)
            y = 0;
            for k = 1:summ_count
                y = y + besselj(summ_count, x*Z(k))*quad(@(t) task_f(t)*besselj(summ_count, Z(k)*t), -pi, pi);
            end
        end

        hbessel = @f;
    end

    X = (x_0):X_STEP:(max(widths) + x_0);
    F = zeros(1, length(X));
    B = zeros(1, length(X));
    L = zeros(1, length(X));

    bessel = Bessel(task_f, summ_count);
    legedr = Legendre(task_f, summ_count);

    for i = 1:length(X)
        disp(i)
        F(i) = task_f(X(i));
        B(i) = bessel(X(i));
        L(i) = legedr(X(i));
    end

    subplot(2, 1, 1);
    title('Fourier expansion with Legendre functions as basis');
    hold on;
        plot(X, F);
        plot(X, L);
    hold off;
    subplot(2, 1, 2);
    title('Fourier expansion with Bessel functions as basis');
    hold on;
        plot(X, F);
        plot(X, B);
    hold off;

end
