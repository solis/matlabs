%%
% stud_num   - номер студента
% bar_hi     - высота большого столбца
% bar_lo     - высота маленького столбца
% summ_count - число частных сумм рядов

function [] = main(stud_num, bar_hi, bar_lo, summ_count)
    bars = area_description(stud_num, bar_hi, bar_lo);
    widths = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
    x_0 = 2;
    y_0 = 0;
    X_STEP = 0.05;

    task_f = task_function(bars, widths, x_0, y_0);

    %% Лежандр
    % Нам нужно, чтобы функция была определена на [-1, 1]
    % Поэтому
    % gl1(t): gl1([-1, 1]) -> [0, 1]
    gl1 = @(t) (t+1) / 2;

    % gl2(t): gl2([0, 1]) -> [x_0, x_0 + w],
    %где w = max(widths), последняя точка определенности функции
    gl2 = @(t) ((t*max(widths) + x_0)); % Можно брать просто последний элемент вектора, по условию он неубывающий,
                                        % но так просто логически правильнее.

    % Окончательно
    gl = @(t) gl2(gl1(t));

    % Тогда функция для разложения по полиномам Лежандра
    f_legendre = @(t) task_f(gl(t));

    %% Бессель
    % Тут в некотором смысле проще
    % мы можем раскладывать в ряд на интервале [0, b],
    % однако удобнее конечно на [0, 1], поэтому нужна функция
    % gb(t) : gb([0, 1]) -> [x_0, x_0 + w]
    gb = @(t) (t * max(widths) + x_0);

    f_bessel = @(t) task_f(gb(t));


    % Потом выполним приближение
    % Функция разложения в ряд Фурье по функциям Лежандра
    function [ hlegendre ] = Legendre(f, summ_count)
        function [ y ] = partial_summ(x)
            % Это скорее всего будет не очень эффективно, но пока так

            % Объявим sneaky-tricky функцию, которая будет возвращать значение полинома Лежандра
            % n-ого порядка, в точке x
            function [ y ] = legendren(n, x)
                % Это самый медленный момент. Вообще говоря если quad для разных
                % порядков будет проходить по тем же точкам, то имеет смысл сохранять
                % этот массив. Но похоже что нет.
                Y = legendre(n, x, 'norm');
                y = Y(1,1:length(x));
            end
            y = quad(@(t) f(t), -1, 1) / 2;
            for k = 1:summ_count
                y = y + legendren(k, x)*quad(@(t) f(t) .* legendren(k,t), -1, 1);
            end
        end
        hlegendre = @partial_summ;
    end

    % Функция разложения в ряд Фурье по функциям Бесселя
    function [ hbessel ] = Bessel(f, summ_count)
        function [ z ] = besselzero(alpha, n)
            z = fzero(@(x)besselj(alpha , x), n);
        end

        Z = zeros(summ_count);
        for k = 1:length(Z)
            Z(k) = besselzero(summ_count, k);
        end


        function [ y ] = partial_summ(x)
            y = quad(@(t) f(t), -pi, pi) / (2*pi);
            for k = 1:summ_count
                coeff = quad(@(t) f(t) .* besselj(summ_count,t), -pi, pi);
                %norm = quad(@(t) besselj(summ_count, x*Z(k)))
                y = y + besselj(summ_count, x*Z(k))*coeff;
            end
        end

        hbessel = @partial_summ;
    end

    X_leg = -1:X_STEP:1;
    X_acl = -1:0.00005:1;
    X_bes =  0:X_STEP:1;
    X_acb =  0:0.00005:1;

    F_leg = f_legendre(X_acl);
    F_bes = f_bessel(X_acb);
    B = zeros(1, length(X_bes));
    L = zeros(1, length(X_leg));

    % Получим хэндл функции, которая вычисляет приближенное значение с базисом Бесселя
    abessel = Bessel(f_bessel, summ_count);
    % Получим хэндл функции, которая вычисляет приближенное значение с базисом Лежандра
    alegendre = Legendre(f_legendre, summ_count);

    for i = 1:length(X_bes)
        B(i) = abessel(X_bes(i));
    end

    for i = 1:length(X_leg)
        L(i) = alegendre(X_leg(i));
    end

    %%
    %   Функция для построения графиков приближенной и точной формы
    %   X_F   - сетка для F
    %   F     - точная форма (значения)
    %   X_A   - сетка для A
    %   A     - приближенная форма (значения)
    %   basis - какой базис используем, строка
    function [] = plot_series(X_F, F, X_A, A, basis)
        title(sprintf('Fourier expansion with %s functions as basis', basis));

        axis([min(X_A) - 0.2 , max(X_A) + 0.2, min(A) - 0.5 , max(A) + 0.5])
        hold on;
            p = plot(X_F, F);
            set(p,'Color','red','LineWidth',3)
            p = plot(X_A, A);
            set(p, 'Color', 'green', 'LineWidth', 2)
        hold off;
        legend('Exact form', 'Approximate form');
    end

    subplot(2, 1, 1);
    plot_series(X_acl, F_leg, X_leg, L, 'Legendre');

    subplot(2, 1, 2);
    plot_series(X_acb, F_bes, X_bes, B, 'Bessel');

end
