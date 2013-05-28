%% Задание 02. Задача Коши для волнового уравнения на полупрямой
% Исходное уравнение: u_tt = u_xx - 24x + 12t - 2
% Начальные условия: u(0, t) = 3t^3 - 2t^2 + 3t + 2
%                    u(x, 0) = 3x^3 - x^2 - 3x + 2
%                  u_t(x, 0) = 3x^2 - x + 3

function t071602
    %% Начальная инициализация

    a = 1;
    f = @(x,t) (-24*x + 12*t - 2);
    mu = @(t) (3*t.^3 - 2*t.^2 + 3*t + 2);
    phi = @(x) (3*x.^3 - x.^2 - 3*x + 2);
    psi = @(x) (3*x.^2 - x + 3);

    x_min = 0; 
    x_max = 3;
    x_count = 20;
    t_min = 0;
    t_max = 3;
    t_count = 20;

    x_h = (x_max - x_min) / x_count;
    t_h = (t_max - t_min) / t_count;
    X = x_min:x_h:x_max;
    T = t_min:t_h:t_max;

    %% Построение численного и аналитического решений
    
    U = @(x,t) (compute_v(x, t, a, phi, psi) + compute_w(x, t, a, f) + compute_z(x, t, a, mu));

    u_analytical = @(x, t) (2 + 3*t.^3 - 3*x - x.^2 + 3*x.^3 - t.^2*(2 + 3*x) + t*(3 - x + 3*x.^2));
    u_numerical = @(x, t) U(x, t);
    
    disp('Computing..');
    analytical_grid = zeros(length(X), length(T));
    numerical_grid = zeros(length(X), length(T));
    for x = 1:length(X)
        for t = 1:length(T)
            analytical_grid(x, t) = u_analytical(X(x), T(t));
            numerical_grid(x, t) = u_numerical(X(x), T(t));
        end
    end
    %% Визуализация решений
    
    disp('Visualizing..');
    visualize(x_min, x_max, X, T, analytical_grid, numerical_grid);
end