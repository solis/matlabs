%% Основной код Лабораторной работы #2
% stud_num   - номер студента
% bar_hi     - высота большого столбца
% bar_lo     - высота маленького столбца
% widths     - широты столбцов, считая, что первый столбец начинается в 0.
%              каждое следующее значение дает конец столбца по x.
% summ_count - число частных сумм рядов
%
function [] = main(stud_num, bar_hi, bar_lo, widths, x_0, y_0, summ_count)
    bars = area_description(stud_num, bar_hi, bar_lo);
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
    %% Функция разложения в ряд Фурье по функциям Лежандра
    % f          -   функция, которую собираемся аппроксимировать
    % summ_count -   число частных сумм
    % See http://mathworld.wolfram.com/Fourier-LegendreSeries.html
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

    %% Функция разложения в ряд Фурье по функциям Бесселя
    % f          -   функция, которую собираемся аппроксимировать
    % summ_count -   число частных сумм
    % See http://www.math.upenn.edu/~rimmer/math241/ch12sc6frbess.pdf
    % See https://www.math.lsu.edu/~rich/4038_Downloads/Bessel_Series_example.pdf
    function [ hbessel ] = Bessel(f, summ_count)
        % Порядок функции Бесселя
        nu = 0;

        function [ z ] = besselzero(alpha, n)
            z = fzero(@(x)besselj(alpha , x), n);
        end

        %% Округлим до нужного порядка после запятой
        function [ Y ] = rounddig(X, n)
            Y = round(X*10.^n)/10.^n;
        end

        Z = [];
        % Так мы должны исключить 0. Так как это 0 любой другой функции Бесселя.
        last_zero = 0;
        while (length(Z) < summ_count)
            last_zero = last_zero + 1;
            next_zero = besselzero(nu, last_zero);
            while (rounddig(next_zero, 5) == 0)
                last_zero  = last_zero + 1;
                next_zero = besselzero(nu, last_zero);
            end

            % Уберем все повторяющиеся нули (кратности больше чем 1).
            % Округляем, потому что совпадают они неточно
             Z = unique(rounddig([Z, next_zero], 5));
        end

        function [ y ] = partial_summ(x)
            y = 0;
            for k = 1:summ_count
                coeff = quad(@(t) besselj(nu, Z(k) * t) .* f(t), 0, 1);
                norm = (( besselj(nu + 1, Z(k)) ).^2) / 2;
                y = y + besselj(nu, x * Z(k)) * coeff / norm;
            end
        end

        hbessel = @partial_summ;
    end

    % Сетка для Лежандра, на которой будем приближать функцию
    X_leg = -1:X_STEP:1;
    % Сетка для Бесселя, на которой будем приближать функцию
    X_bes =  0:0.1:1;
    % Accurate grid для построения точной формы. Ну чтобы красиво.
    X_acc = x_0:0.00005:(x_0 + max(widths));

    % Значения нашей функции на аккуратной сетке.
    F = task_f(X_acc);

    % Подготовим векторы для приближенных форм.
    B = zeros(1, length(X_bes));
    L = zeros(1, length(X_leg));

    % Получим хэндл функции, которая вычисляет приближенное значение с базисом Бесселя
    abessel = Bessel(@(t) sin(t), summ_count);
    % Получим хэндл функции, которая вычисляет приближенное значение с базисом Лежандра
    alegendre = Legendre(f_legendre, summ_count);

    disp('Computing Legendre...')
    for i = 1:length(X_bes)
        B(i) = abessel(X_bes(i));
    end

    disp('Computing Bessel...');
    for i = 1:length(X_leg)
        L(i) = alegendre(X_leg(i));
    end


    % Имея значения функции на [-1, 1] и [0, 1]
    % нужно выполнить обратное преобразование
    % т.е. просто нужно выполнить преобразование для нашей сетки
    X_leg = gl(X_leg);
    X_bes = gb(X_bes);

    %%   Функция для построения графиков приближенной и точной формы
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
    plot_series(X_acc, F, X_leg, L, 'Legendre');

    subplot(2, 1, 2);
    plot_series(X_acc, F, X_bes, B, 'Bessel');

end
