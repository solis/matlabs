load('t070205/solution.mat');

X = 0:0.01:1;
Y = 0:0.01:1;

UXY = tri2grid(p, t, u, X,Y);

real = @(x, t) sin(x) * cos(t);
subplot(2, 1, 1)
m = mesh(X, Y, UXY);

subplot(2, 1, 2)

Z = [];
for i = 1:length(X)
    for j = 1:length(Y)
        Z(i, j) = real(X(i), Y(j));
    end
end
surf(X, Y, Z);
