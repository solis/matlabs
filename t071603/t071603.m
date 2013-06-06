%% Задание 03. Решение смешанной задачи методом разделения переменных
%  Постановка задачи: 
%   Точное решение: u(x,t)=cos(x+1)*sin(t+1)*e^(-2t^2-1)
%   Тип уравнения: гиперболическое (Г)
%   Тип граничных условий: слева – 3-го рода, справа – 3-го рода
%   L=1, a=2, h=2, T_MAX = 0.9

function t071603
    clc; clear all;
    
    format long;
    
    %% Начальная инициализация
    
    L = 1;
    a = 2;
    h = 2;
    T_MAX = 0.9;

    epsilon = 0.0001;

    x_min = 0;
    x_max = L;
    t_min = 0;
    t_max = T_MAX;
    count = 10;
    max_sum_count = 50;
    
    x_h = (x_max - x_min) / count;
    t_h = (t_max - t_min) / count;
    x = x_min : x_h : x_max;
    t = t_min : t_h : t_max;    
    
    trapz_x = x_min : x_h/100 : x_max;
    trapz_t = 0 : t_h/100 : t_max;
    
    u = @(x, t) (cos(x+1) .* sin(t+1) .* exp(-2*t.^2-1));
    ut = @(x, t) ((exp(-2*t.^2-1).*cos(x+1)).*(cos(t+1)-(4*t)*sin(t+1)));
    %utt = @(x, t) ((exp(-2*t.^2-1).*cos(x+1)).*((16*t.^2-5).*sin(t+1)-(8*t).*cos(t+1)));
    ux = @(x, t) ((-exp(-2*t.^2-1).*sin(t+1)).*sin(x+1));
    %uxx = @(x, t) ((-exp(-2*t.^2-1).*cos(x+1)).*sin(t+1));
    %f = @(x, t) (utt(x, t) - a^2*uxx(x, t));
    phi = @(x) (u(x, 0));
    psi = @(x) (ut(x, 0));
    mu1 = @(t) (ux(0, t) - h*u(0, t));
    mu2 = @(t) (ux(L, t) + h*u(L, t));
    A = @(t) ((mu1(t) + mu2(t))/(2 + h*L));
    B = @(t) ((A(t) - mu1(t))/h);
    w = @(x, t) (A(t).*x + B(t));
    wt = @(x, t) (-(1/8)*exp(-2*t.^2-1).*(-6*cos(1)-2*cos(2)-3*sin(1)+sin(2)+2*x*(2*cos(1)-2*cos(2)+sin(1)+sin(2))).*(cos(t+1)-4*t.*sin(t+1)));
    %wtt = @(x, y) (1/8*exp(-2*t.^2-1).*(6*cos(1)+2*cos(2)+3*sin(1)-sin(2)-2*x.*(2*cos(1)-2*cos(2)+sin(1)+sin(2))).*((16*t.^2-5).*sin(t+1)-8*t.*cos(t+1)));
    %g = @(x, t) ((1/8)*exp(-2*t.^2-1) .* ((8*(16*t.^2-1).*cos(x+1)+(16*t.^2-5) .* (-6*cos(1)-2*cos(2)-3*sin(1)+sin(2)+2*x*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))).*sin(t+1)-8*t.*cos(t+1) .* (-6*cos(1)-2*cos(2)+8*cos(x+1)-3*sin(1)+sin(2)+2*x*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))));
    nu = @(x) (phi(x) - w(x, 0));
    mu = @(x) (psi(x) - wt(x, 0));
    
    sqrt_lambda_k = zeros(max_sum_count);
    sqrt_lambda_k(1) = fzero(@(x) tan(x*L) + (2*x*h) / (h^2 - x), 2);
    sqrt_lambda_k(2) = fzero(@(x) tan(x*L) + (2*x*h) / (h^2 - x), 5.3);
    for k = 3 : max_sum_count
        sqrt_lambda_k(k) = fzero(@(x) tan(x*L) + (2*x*h) / (h^2 - x), (k-1)*pi);
    end

    Xk = @(x, k)((sqrt_lambda_k(k) / h) .* cos(sqrt_lambda_k(k) .* x) + sin(sqrt_lambda_k(k) .* x));
    Xn = @(k) (trapz(trapz_x, (Xk(trapz_x, k) .* Xk(trapz_x, k))));
    nuk = @(k) (trapz(trapz_x, (Xk(trapz_x, k) .* nu(trapz_x))) ./ Xn(k));
    muk = @(k) (trapz(trapz_x, (Xk(trapz_x, k) .* mu(trapz_x))) ./ Xn(k));
    %gk = @(t, k) (trapz(trapz_x, (Xk(trapz_x, k).*g(trapz_x, t))) ./ Xn(k));
    gk = @(t, k) ((exp(-2*t.^2-1).*(cos(t).*(((16*sqrt_lambda_k(k))*(2*cos(1)+sin(1)))...
        .* ((4*sqrt_lambda_k(k).^2+16*t.^2-5)*sin(1)-(8*t)*cos(1))-((4*sqrt_lambda_k(k))...
        .* cos(sqrt_lambda_k(k)))*((-7*cos(1)-5*cos(2)+7*cos(3)-6*sin(1)+10*sin(2)-((16*t)...
        .* ((2*t)*sin(1)-cos(1))).*(2*cos(1)-2*cos(2)+sin(1)-3*sin(2))+6*sin(3)+5)...
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
        .* sqrt_lambda_k(k).^2+(2*((8*t).*((2*t)*cos(1)+sin(1))-5*cos(1)))...
        .* (2*cos(1)+2*cos(2)+sin(1)-sin(2)))+((22*cos(1)+10*cos(2)+22*cos(3)-((16*t)...
        .* ((2*t)*cos(1)+sin(1)))*(2*cos(1)-2*cos(2)+sin(1)-3*sin(2))+5*(-3*sin(1)+sin(2)-3*sin(3)+2))... 
        .* sqrt_lambda_k(k).^4+(10*cos(1)-50*cos(2)+10*cos(3)+11*sin(1)-25*(sin(2)+2)+((16*t)...
        .* ((2*t)*cos(1)+sin(1)))*(10*cos(1)-2*cos(2)+5*sin(1)-15*sin(2))+11*sin(3))...
        .* sqrt_lambda_k(k).^2-(8*((8*t).*((2*t)*cos(1)+sin(1))-5*cos(1)))*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))... 
        .* sin(sqrt_lambda_k(k))).*sin(t)))./(((4*sqrt_lambda_k(k)).*(sqrt_lambda_k(k).^2-1))...
        .* (sqrt_lambda_k(k).*(sqrt_lambda_k(k).^2-2*cos(2*sqrt_lambda_k(k))+(sqrt_lambda_k(k)...
        .* cos(sqrt_lambda_k(k))).*sin(sqrt_lambda_k(k))+6)-2*sin(2*sqrt_lambda_k(k)))));
    Tk_OO = @(t, k) (nuk(k).*cos(sqrt_lambda_k(k)*a.*t) + (muk(k)./(sqrt_lambda_k(k)*a)).*sin(sqrt_lambda_k(k)*a*t));
    K = @(t, k) (1/(sqrt_lambda_k(k)*a).*sin(sqrt_lambda_k(k)*a.*t));
    Tk_ChN = @(t, k) (trapz(trapz_t, (K(t-trapz_t, k).*gk(trapz_t, k))));
    Tk = @(t, k) (Tk_OO(t, k) + Tk_ChN(t, k));
    
    %% Вычисление точного и приближённого решений 
    disp('Computing solutions..');
    [X, T] = meshgrid(x, t); 
    exact_solution = zeros(length(x), length(t));
    numerical_solution = zeros(length(x), length(t));
    for i = 1 : count + 1
        for j = 1 : count + 1
            clc;
            fprintf('Progress: %d%', (i - 1)*count + (j - 1));
            fprintf('/%d%', count*(count + 1));
            disp(' ');
            
            if t(j) == 0
                numerical_solution(j, i) = phi(x(i));
                exact_solution(j, i) = phi(x(i));
                continue;
            end
            
            k = 0;
            previous_solution = 1;
            current_solution = 0;
            while (abs(current_solution - previous_solution) > epsilon) && (k < max_sum_count)
                k = k + 1;
                previous_solution = current_solution;
                current_solution = current_solution + Xk(x(i), k) .* Tk(t(j), k);
            end
            exact_solution(j, i) = u(x(i), t(j));
            numerical_solution(j, i) = current_solution + w(x(i), t(j));
        end
    end
    disp('Computing: done.');
    
    %% Сохранение полученных результатов в файл
    
    save solutions.mat X T exact_solution numerical_solution
    disp('All results saved to "solutions.mat"');
end