function [] = t070203_comp

    X = 0:0.1:1;
    T = 0:0.1:1;
    [X, T] = meshgrid(X, T);
    K = 2;
    TOLERACNE = 0.00001;


    %% Задача:
    L = 1;
    % Функция
    u       = @(x, t) -sin( 2*x - 3 ) .* cos( 2*t + 3 ) .* exp( -3*t.^2 -1 );
    %  u(x, 0)
    phi     = @(x)    u(x, 0);
    % du/dt (x, 0)
    Psi     = @(x)    2*sin( 2*x - 3) * sin(3) * exp(-1);
    % du/dx (0, t)
    mu_1    = @(t)    -2 * cos(-3) * cos( 2*t +3 ) .* exp( -3*t -1 );
    % du/dx (L, t)
    mu_2    = @(t)    -2 * cos(-1) * cos( 2*t +3 ) .* exp( -3*t -1 );
    % Неоднородность
    f       = @(x, t) exp( -3*t.^2 -1 ) .* ( 6*sin(2*x - 3).*cos(2*t+3).*(6 +t) - 2*sin(2*x - 3).*sin(2*t+3) );

    %%% Задача с однородными условиями
    % Неоднородность
    %
    g0      = @(t) -18 * cos(2*t + 3) .* exp(-3*t.^2 - 1) * (cos(-3) - cos(-1));
    g       = @(x, t)  g0(t) + f(x, t);
    % v(x, 0)
    v_tzero = @(x)    exp(-1) * cos(3) * ( -sin(2*x - 3) + x.^2 * cos(3) + (1-x).^2 * cos(1));



    % Полагая u = v + w. Где v породит однородную задачу, w:
    w = @(x, t)  -cos(2*t+3) .* exp(-3*t.^2 -1) .* (x.^2 .* cos(-3) + (1-x).^2 * cos(-1));

    % Нормированный базис решений задачи Штурма-Лиувилля
    Xk = @(x, k) sin(pi*k*x) / 2;

    Xk_quaded = zeros(1, K);
    for i = 1:K
        Xk_quaded(i) = quad(@(p) Xk(p, i), 0, 1);
    end

    function [r] = g_k (k, t)
        % Чтобы кваду было полегче, разобьем фукнкцию на сумму 2x
        % g0 не зависит от x, тогда
        r = g0(t) * Xk_quaded(k);
        for n = 1:length(t)
            % И вторая часть функции это f(x,t)
            % f1 = exp( -3*t.^2 -1 ) .*cos(2*t+3).*(6 +t) .* 6*sin(2*x - 3)
            % f2 =  2*sin(2*x - 3).*sin(2*t+3) .* exp( -3*t.^2 -1 )

            r(n) = r(n) + (exp( -3*t.^2 -1 ) .*cos(2*t+3).*(6 +t) * 6 -  ...
                          sin(2*t+3) .* exp( -3*t.^2 -1 ) * 2) .* ...
                          quad(@(p) sin(2*p -3) .* Xk(p, k), 0, L, TOLERACNE);
        end
    end
    v_tzero_k = @(k) quad( @(p) v_tzero(p) .* Xk(p, k), 0, 1, TOLERACNE);

    %% Предрасчитаем все что не зависит от переменных
    V_TZERO_K = zeros(1, K);
    for k = 1:K
        V_TZERO_K(k) = v_tzero_k(k);
    end

    % Получаем задачу Коши для ОДУ первого порядка
    % T_k' + 9 * lambda * T_k = g_k
    % Решением будетz
    Tk = @(k, t) V_TZERO_K(k) * exp( -9 * (pi * k).^2 .* t ) + quad( @(tau) g_k(k, tau) .* exp( -9 * (pi * k).^2 .* (tau - t) ), 0, t , TOLERACNE);

    %% Решением исходной задачи будет u(x,t) = w(x, t) + sum(Tk * Xk);
    U = zeros(length(X), length(T));

    for i = 1:length(X)
        for j = 1:length(T)
            U(i,j) = w(X(i), T(j));
        end
    end

    for k = 1:K
        xk = Xk(k, X);
        disp('k')
        for i = 1:length(X)
            for j = 1:length(T)
                T(j)
                tk = Tk(k, T(j));
                U(i, j) = U(i,j) + tk * xk(i);
            end
        end
        disp(k);
    end
end
