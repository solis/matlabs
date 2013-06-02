function [] = viz_boundary(X, Y)
    figure;

    Uxzero = zeros(1, length(X));
    for i = 1:length(X)
        Uyzero(i) = numeric_solution(X(i), 0);
    end

    subplot(2, 1, 1)
    hold on;
        plot(X, phi(X), 'color', 'red', 'LineWidth', 3);
        plot(X, Uyzero, 'color', 'blue', 'LineWidth', 2);
        plot(X, analytic_solution(X, 0), 'color', 'green')
    hold off;
    xlabel('x');
    ylabel('u');
    title('u(x, 0)')
    legend('Boundary condition', 'Numeric solution', 'Analytic solution')

    Uxzero = zeros(1, length(Y));
    for i = 1:length(Y)
        Uxzero(i) = numeric_solution(0, Y(i));
    end

    subplot(2, 1, 2)
    hold on;
        plot(Y, mu(Y), 'color', 'red', 'LineWidth', 3)
        plot(Y, Uxzero, 'color', 'blue', 'LineWidth', 2)
        plot(Y, analytic_solution(0, Y), 'color', 'green')
    hold off;
    xlabel('x');
    ylabel('u');
    title('u(0, t)')
    legend('Boundary condition',  'Numeric solution', 'Analytic solution')

end
