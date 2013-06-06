clc; clear all;

L = 1;
a = 2;
h = 2;
t_max = 0.9;

syms x t tau;

xMin = 0;
xMax = L;
tMin = 0;
tMax = t_max;
tN = 10;
xN = 10;
xH = (xMax - xMin) / xN;
tH = (tMax - tMin) / tN;
rowsX = xMin : xH : xMax;
colsT = tMin : tH : tMax;

[X,T] = meshgrid(rowsX, colsT); 

exactSolution = cos(X + 1).*sin(T + 1).*exp(-2*T.^2 - 1);
numSolution = zeros(length(rowsX),length(colsT));

nu = @(x) (sin(1)*(-6*cos(1)-2*cos(2)+8*cos(x+1)-3*sin(1)+sin(2)+2*x*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))/(8*exp(1)));
mu = @(x) (cos(1)*(-6*cos(1)-2*cos(2)+8*cos(x+1)-3*sin(1)+sin(2)+2*x*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))/(8*exp(1)));
w = @(x,t) (1/8*exp(-2*t.^2-1).*(6*cos(1)+2*cos(2)+3*sin(1)-sin(2)-2*x.*sin(t+1)*(2*cos(1)-2*cos(2)+sin(1)+sin(2))));

n = 200;
sqrt_lambda_k = zeros(n);
sqrt_lambda_k(1) = fzero(@(x) tan(x*L)+(2*x*h)/(h^2-x), 2);
sqrt_lambda_k(2) = fzero(@(x) tan(x*L)+(2*x*h)/(h^2-x), 5.3);
for j=3:n
    sqrt_lambda_k(j) = fzero(@(x) tan(x*L)+(2*x*h)/(h^2-x), (j-1)*pi);
end

Xk = @(x, k)((sqrt_lambda_k(k)/h).*cos(sqrt_lambda_k(k).*x)+sin(sqrt_lambda_k(k).*x));

g = @(x, t) ((1/8)*exp(-2*t.^2-1).*((8*(16*t.^2-1).*cos(x+1)+(16*t.^2-5).*(-6*cos(1)-2*cos(2)-3*sin(1)+sin(2)+2*x*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))).*sin(t+1)-8*t.*cos(t+1).*(-6*cos(1)-2*cos(2)+8*cos(x+1)-3*sin(1)+sin(2)+2*x*(2*cos(1)-2*cos(2)+sin(1)+sin(2)))));
Xn = @(k) (quad(@(x) (Xk(x, k).*Xk(x, k)), 0, L));
nuk = @(k) (quad(@(x) (Xk(x,k).*nu(x)), 0, L) ./ Xn(k));
muk = @(k) (quad(@(x) (Xk(x,k).*mu(x)), 0 ,L) ./ Xn(k));
gk = @(t, k) (quad(@(x) ((Xk(x, k).*g(x, t))), 0, L) ./ Xn(k));
Tk_OO = @(t, k) (nuk(k).*cos(sqrt_lambda_k(k)*a.*t) + (muk(k)./(sqrt_lambda_k(k)*a)).*sin(sqrt_lambda_k(k)*a*t));
K = @(t, k) (1/(sqrt_lambda_k(k)*a).*sin(sqrt_lambda_k(k)*a.*t));
Tk_ChN = @(t, k) (quad((@(tau)(K(t-tau, k).*gk(tau, k))), 0, t));
Tk = @(t, k) (Tk_OO(t, k) + Tk_ChN(t, k));

disp('Building grid');
for i = 1 : xN+1
    currX = (i-1)*xH;
    for j = tN+1 : -1: 1
        currT = (j-1)*tH;
        k = 1;
        solution = rand(1);
        currentSol = 0;
        while abs(solution - currentSol) > 0.00001
             solution = currentSol;
             currentSol = currentSol + Xk(currX, k).*Tk(currT, k);
             k = k + 1;
        end
        numSolution(j,i) = currentSol + w(currX, currT);
    end
    clc;
    fprintf('%d%%', round((i-1)/xN*100));
end
disp(' ');
disp('Grid built');

save solution.mat X T exactSolution numSolution