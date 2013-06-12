function t070201
    plotter = Plotter;

    % Строим семейство характеристик и прямую на которой задано условие
    b =  @(x) -5*x;
    c1 = @(x) - 9*x;
    c2 = @(x) - x;

    plotter.plot_boundaries_and_characteristics(b, c1, c2)

    % Строим линии уровня для решения
    f = '(x+y).^2 + x - 2*y';
    plotter.plot_contour(f)

    % Строим поверхность решения
    f = @(x,y) (x+y).^2 +x - 2*y;
    plotter.plot_surface(f)
end
