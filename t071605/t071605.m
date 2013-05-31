load('solution.mat');

X = 1:0.01:3;
Y = 1:0.01:2.3;

UXY = tri2grid(p, t, u, X, Y);

u = @(x,y) ((x.^2).*sin(2*y));

[X, Y] = meshgrid(X, Y);
AXY = u(X, Y);
AXY(isnan(UXY)) = NaN;

visualize(X,Y,UXY,AXY);