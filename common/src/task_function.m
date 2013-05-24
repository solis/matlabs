%%
% Аналогично индикатору области из area.m создадим кусочно непрерывную функцию по таким же правилам.

function [ f ] = task_function(bar_heights, bar_sizes, x, y)
    function [ y ] = task_f(x)
            % Смещаем в 0, 0
            u = u - x;


            j = 1;
            while (j <= length(bar_sizes)) && (u > bar_sizes(j))
                j = j + 1;
            end

            if (j > length(bar_sizes))
                y = 0;
            else
                y =  bar_heights(j);
            end
        end

        area = @task_f;
end
