%% Лабораторная работа №6
% На отрезке [0,1] имеется функция, принимающая значения 2 и 1 в
% соответствии с бинарным представлением числа 719 (1011001111), 1->2, 0->1
% Требуется аппроксимировать эту функцию при помощи отрезка ряда Фурье, построенного с использованием:
% а - полиномов Лежандра
% б - функций Бесселя

% Очищаем переменные
clear all;


%% Общие переменные

% Количество слагаемых в отрезке ряда Фурье
N = 20;

% Изменения переменных
xMin = 0;
xMax = 1;
yMin = 1;
yMax = 2;

% Зададим шаг изменения переменных
step = (xMax-xMin)/N;

% Чтобы функция красиво выглядела, полоски должны быть вертикальными.
% Сделаем их почти такими.
epsilon = 0.0001;

fX = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
fY = [2.0, 1.0, 2.0, 2.0, 1.0, 1.0, 2.0, 2.0, 2.0, 2.0]; 

% Вектора, которыми бдем оперировать далее
xLegendre = -1:step:1;
xBessel = 0:step:1;
x = xMin:epsilon:(xMin + max(fX));
f = func719(fX, fY, xMin, yMin, x);    

%% Разложение в ряд Фурье с помощью функций Бесселя
reduceForBessel = @(t)(t*max(fX) + xMin);
fBessel = zeros(1, length(xBessel));
for i = 1:length(xBessel)
    fBessel(i) = approxBessel(@(t) (func719(fX, fY, xMin, yMin, reduceForBessel(t))),...
        xBessel(i), N);
end

%% Разложение в ряд Фурье с помощью функций Лежандра
reduceForLegendre = @(t) (((t+1)/2)*max(fX) + xMin);
fLegendre = zeros(1,length(xBessel));
for i = 1:length(xLegendre)
    fLegendre(i) = approxLegendre(@(t) (func719(fX, fY, xMin, yMin, reduceForLegendre(t))),...
        xLegendre(i), N);
end

xBessel = reduceForBessel(xBessel);
xLegendre = reduceForLegendre(xLegendre);

%% Визуализация
%Нужны 2 окна. На первом - аппроксимация функциями Бесселя.
%На втором - вппроксимация полиномами Лежандра.

%Изобразим эти окна каскадом, размером в половину экрана
set(0, 'Units', 'pixels');
scrsz = get(0,'ScreenSize');

%% Первое окно - аппроксимация функциями Бесселя

figure('Name', 'Аппроксимация функциями Бесселя', 'Position', [25 125 scrsz(3)-250 scrsz(4)-250]);
graph1 = subplot(1,1,1);
axis([xMin, xMax, min(fBessel), max(fBessel)]);

hold on;

% Изображаем исходную функцию и ее аппроксимацию
plot(x, f, 'Color', 'green', 'LineWidth', 2);
plot(xBessel, fBessel, 'Color', 'red', 'LineWidth', 2);

% Добавляем подписи осей и заголовок графика
title ('Исходная функция (зеленый) и ее аппроксимация функциями Бесселя (красный)');
xlabel ('x');
ylabel ('y');

% Не вращать
setAllowAxesRotate(rotate3d, graph1, false);

hold off;

%% Второе окно - аппроксимация полиномами Лежандра

figure('Name', 'Аппроксимация полиномами Лежандра', 'Position', [50 100 scrsz(3)-250 scrsz(4)-250]);
graph2 = subplot(1,1,1);
axis([xMin, xMax, min(fLegendre), max(fLegendre)]);

hold on;

% Изображаем исходную функцию и ее аппроксимацию
plot(x, f, 'Color', 'green', 'LineWidth', 2);
plot(xLegendre, fLegendre, 'Color', 'red', 'LineWidth', 2);

% Добавляем подписи осей и заголовок графика
title ('Исходная функция (зеленый) и ее аппроксимация полиномами Лежандра (красный)');
xlabel ('x');
ylabel ('y');

% Не вращать
setAllowAxesRotate(rotate3d, graph2, false);

hold off;
