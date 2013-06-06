%% Задание 03. Решение смешанной задачи методом разделения переменных
% Постановка задачи: 
%   Точное решение: u(x,t)=cos(x+1)*sin(t+1)*e^(-2t^2-1)
%   Тип уравнения: гиперболическое (Г)
%   Тип граничных условий: слева – 3-го рода, справа – 3-го рода
%   L=1, a=2, h=2, T_MAX = 0.9

function t071603
    clc; clear all;
    
    %% Начальная инициализация
    
    L = 1;
    a = 2;
    h = 2;
    T_MAX = 0.9;

    tolerance = 0.0001;
    epsilon = 0.00001;

    x_min = 0;
    x_max = L;
    t_min = 0;
    t_max = T_MAX;
    count = 20;
    
    x_h = (x_max - x_min) / count;
    t_h = (t_max - t_min) / count;
    x = x_min : x_h : x_max;
    t = t_min : t_h : t_max;    
    
    u = @(x, t) (cos(x+1) .* sin(t+1) .* exp(-2*t.^2-1));
    nu = @(x) (sin(1)*(-6*cos(1)-2*cos(2)+8*cos(x+1)-3*sin(1)+sin(2)+2*x*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))/(8*exp(1)));
    mu = @(x) (cos(1)*(-6*cos(1)-2*cos(2)+8*cos(x+1)-3*sin(1)+sin(2)+2*x*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))/(8*exp(1)));
    w = @(x,t) (1/8*exp(-2*t.^2-1) .* (6*cos(1)+2*cos(2)+3*sin(1)-sin(2)-2*x.*sin(t+1)*(2*cos(1)-2*cos(2)+sin(1)+sin(2))));

    sqrt_lambda_size = 250;
    sqrt_lambda_k = zeros(sqrt_lambda_size);
    sqrt_lambda_k(1) = fzero(@(x) tan(x*L) + (2*x*h) / (h^2 - x), 2);
    sqrt_lambda_k(2) = fzero(@(x) tan(x*L) + (2*x*h) / (h^2 - x), 5.3);
    for k = 3 : sqrt_lambda_size
        sqrt_lambda_k(k) = fzero(@(x) tan(x*L) + (2*x*h) / (h^2 - x), (k-1)*pi);
    end

    Xk = @(x, k)((sqrt_lambda_k(k) / h) .* cos(sqrt_lambda_k(k) .* x) + sin(sqrt_lambda_k(k) .* x));
    %g = @(x, t) ((1/8)*exp(-2*t.^2-1) .* ((8*(16*t.^2-1).*cos(x+1)+(16*t.^2-5) .* (-6*cos(1)-2*cos(2)-3*sin(1)+sin(2)+2*x*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))).*sin(t+1)-8*t.*cos(t+1) .* (-6*cos(1)-2*cos(2)+8*cos(x+1)-3*sin(1)+sin(2)+2*x*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))));
    %Xn = @(k) (quad(@(x) (Xk(x, k).*Xk(x, k)), 0, L, tolerance));
    trapz_x = x_min : x_h/100 : x_max;
    Xn = @(k) (trapz(trapz_x, (Xk(trapz_x, k) .* Xk(trapz_x, k))));
    nuk = @(k) (trapz(trapz_x, (Xk(trapz_x, k) .* nu(trapz_x))) ./ Xn(k));
    muk = @(k) (trapz(trapz_x, (Xk(trapz_x, k) .* mu(trapz_x))) ./ Xn(k));
    %nuk = @(k) (quad(@(x) (Xk(x,k).*nu(x)), 0, L, tolerance) ./ Xn(k));
    %muk = @(k) (quad(@(x) (Xk(x,k).*mu(x)), 0 ,L, tolerance) ./ Xn(k));
    %gk = @(t, k) (quad(@(x) ((Xk(x, k).*g(x, t))), 0, L) ./ Xn(k));
    gk = @(t, k) ((exp(-2*t.^2-1) .* (cos(t) .* (((16*sqrt_lambda_k(k))*(2*cos(1)+sin(1)))...
        .* ((4*sqrt_lambda_k(k).^2+16*t.^2-5)*sin(1)-(8*t)*cos(1))-((4*sqrt_lambda_k(k))...
        .* cos(sqrt_lambda_k(k)))*((-7*cos(1)-5*cos(2)+7*cos(3)-6*sin(1)+10*sin(2)-((16*t)...
        .* ((2*t)*sin(1)-cos(1))) .* (2*cos(1)-2*cos(2)+sin(1)-3*sin(2))+6*sin(3)+5)...
        .* sqrt_lambda_k(k).^2+(2*((16*t.^2-5)*sin(1)-(8*t)*cos(1)))*(2*cos(1)+2*cos(2)+sin(1)-sin(2)))...
        + ((-15*cos(1)-5*cos(2)+15*cos(3)-22*sin(1)+10*sin(2)-((16*t)...
        .* ((2*t)*sin(1)-cos(1)))*(2*cos(1)-2*cos(2)+sin(1)-3*sin(2))+22*sin(3)+5)... 
        .* sqrt_lambda_k(k).^4+(11*cos(1)+25*cos(2)-11*cos(3)+((16*t)...
        .* ((2*t)*sin(1)-cos(1)))*(10*cos(1)-2*cos(2)+5*sin(1)-15*sin(2))-5*(2*sin(1)+10*sin(2)-2*sin(3)+5))...
        .* sqrt_lambda_k(k).^2-(8*((16*t.^2-5)*sin(1)-(8*t)*cos(1)))*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))...
        .* sin(sqrt_lambda_k(k)))+(((16*sqrt_lambda_k(k))*(2*cos(1)+sin(1)))...
        .* ((4*sqrt_lambda_k(k)^2+16*t.^2-5)*cos(1)+(8*t)*sin(1))-((4*sqrt_lambda_k(k))...
        .* cos(sqrt_lambda_k(k)))*((6*cos(1)+10*cos(2)+6*cos(3)-7*sin(1)+5*sin(2)-((16*t)...
        .* ((2*t)*cos(1)+sin(1)))*(2*cos(1)-2*cos(2)+sin(1)-3*sin(2))-7*sin(3)+10)...
        .* sqrt_lambda_k(k).^2+(2*((8*t) .* ((2*t)*cos(1)+sin(1))-5*cos(1)))...
        .* (2*cos(1)+2*cos(2)+sin(1)-sin(2)))+((22*cos(1)+10*cos(2)+22*cos(3)-((16*t)...
        .* ((2*t)*cos(1)+sin(1)))*(2*cos(1)-2*cos(2)+sin(1)-3*sin(2))+5*(-3*sin(1)+sin(2)-3*sin(3)+2))... 
        .* sqrt_lambda_k(k).^4+(10*cos(1)-50*cos(2)+10*cos(3)+11*sin(1)-25*(sin(2)+2)+((16*t)...
        .* ((2*t)*cos(1)+sin(1)))*(10*cos(1)-2*cos(2)+5*sin(1)-15*sin(2))+11*sin(3))...
        .* sqrt_lambda_k(k).^2-(8*((8*t) .* ((2*t)*cos(1)+sin(1))-5*cos(1)))*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))... 
        .* sin(sqrt_lambda_k(k))).*sin(t))) ./ (((4*sqrt_lambda_k(k)) .* (sqrt_lambda_k(k).^2-1))...
        .* (sqrt_lambda_k(k) .* (sqrt_lambda_k(k).^2-2*cos(2*sqrt_lambda_k(k))+(sqrt_lambda_k(k)...
        .* cos(sqrt_lambda_k(k))) .* sin(sqrt_lambda_k(k))+6)-2*sin(2*sqrt_lambda_k(k)))));
    Tk_OO = @(t, k) (nuk(k) .* cos(sqrt_lambda_k(k)*a.*t) + (muk(k) ./ (sqrt_lambda_k(k)*a)) .* sin(sqrt_lambda_k(k)*a*t));
    K = @(t, k) (1 / (sqrt_lambda_k(k)*a) .* sin(sqrt_lambda_k(k)*a.*t));
    %Tk_ChN = @(t, k) (quad((@(tau) (K(t-tau, k).*gk(tau, k))), 0, t, tolerance));
    trapz_t = 0 : t_h/100 : t_max;
    Tk_ChN = @(t, k) (trapz(trapz_t, (K(t-trapz_t, k).*gk(trapz_t, k))));
    Tk = @(t, k) (Tk_OO(t, k) + Tk_ChN(t, k));
    
    %% Вычисление точного и приближённого решений 
    
    disp('Computing solutions..');
    [X, T] = meshgrid(x, t); 
    exact_solution = zeros(length(X), length(T));
    numerical_solution = zeros(length(X), length(T));
    for i = 1 : count + 1
        for j = 1 : count + 1
            clc;
            fprintf('Progress: %d%', (i - 1)*count + j + 1);
            fprintf('/%d%', (count)*count + count);
            disp(' ');
            
            k = 0;
            previous_solution = 1;
            current_solution = 0;
            while (abs(current_solution - previous_solution) > epsilon) && (k < sqrt_lambda_size)
                k = k + 1;
                previous_solution = current_solution;
                current_solution = current_solution + Xk(X(i, i), k) .* Tk(T(j, j), k);
            end
            exact_solution(j, i) = u(X(i, i), T(j, j));
            numerical_solution(j, i) = current_solution + w(X(i, i), T(j, j));
        end
    end
    disp('Computing: done.');
    
    %% Сохранение полученных результатов в файл
    
    save solutions.mat X T exact_solution numerical_solution
    disp('All results saved to "solutions.mat"');
end