X = -0.5:0.000005:1.5;
Y = [];

bars = area_description(702, 1, 0.3);

task_f = task_function(bars, [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1], 0, 0);

for i = 1:length(X)
    Y(i) = task_f(X(i));
end


plot(X, Y);
axis([min(X) max(X) min(Y) - 0.2 max(Y) + 0.2])
