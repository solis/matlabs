function visualize(X, T, analytical_grid, numerical_grid)
    scrsz = get(0, 'ScreenSize');

    %% 1. ����������� ������� � ������������ �������

    figure('Position', [50 125 scrsz(3)-250 scrsz(4)-250], 'Name', '1. ����������� ������� � ������������ �������', 'NumberTitle', 'off');

    % ������ ����������� ������� �������
    subplot(1, 2, 1);
    grid on;
    hold on;
        surf(X, T, analytical_grid, 'EdgeColor', 'none');
        set(gca, 'CameraPosition', [0, 0, 60]);
        title('����������� ������� �������');
        xlabel('x');
        ylabel('t');
        zlabel('u(x,t)');
    hold off;

    % ������ ����������� ������������ �������
    subplot(1, 2, 2);
    grid on;
    hold on;
        surf(X, T, numerical_grid, 'EdgeColor', 'none');
        set(gca, 'CameraPosition', [0, 0, 60]);
        title('����������� ������������ �������');
        xlabel('x');
        ylabel('t');
        zlabel('u(x,t)');
    hold off;


    %% 2. ����� ������ ������� � ������������ �������

    figure('Position', [75 100 scrsz(3)-250 scrsz(4)-250], 'Name', '2. ����� ������ ������� � ������������ �������', 'NumberTitle', 'off');

    % ������ ����� ������ ������� �������
    subplot(1, 2, 1);
    grid on;
    hold on;
        [C, h] = contour(X, T, analytical_grid, 10, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('����� ������ ������� �������');
        xlabel('x');
        ylabel('t');
    hold off;

    % ������ ����� ������ ������������ �������
    subplot(1, 2, 2);
    grid on;
    hold on;
        [C, h] = contour(X, T, numerical_grid, 8, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('����� ������ ������������ �������');
        xlabel('x');
        ylabel('t');
    hold off;


    %% 3. ����� ������ ���������� � ������������� �����������

    figure('Position', [100 75 scrsz(3)-250 scrsz(4)-250], 'Name', '3. ����� ������ ���������� � ������������� �����������', 'NumberTitle', 'off');

    % ������ ����� ������ ���������� �����������
    subplot(1, 2, 1);
    hold on;
        [C, h] = contour(X, T, abs(analytical_grid - numerical_grid), 8, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('����� ������ ���������� �����������');
        xlabel('x');
        ylabel('t');
    hold off;

    % ������ ����� ������ ������������� �����������
    subplot(1, 2, 2);
    hold on;
        [C, h] = contour(X, T, abs((analytical_grid - numerical_grid) ./ analytical_grid), 8, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('����� ������ ������������� �����������');
        xlabel('x');
        ylabel('t');
    hold off;
end