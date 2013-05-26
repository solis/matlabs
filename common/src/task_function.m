%%
% Аналогично индикатору области из area.m создадим кусочно непрерывную функцию по таким же правилам.

function [ f ] = task_function(bar_heights, bar_sizes, x, y)
    function [ v ] = task_f(u)
            % Смещаем в 0, 0
            u = u - x;

            j = 1;
            while (j <= length(bar_sizes)) & (u > bar_sizes(j))
                j = j + 1;
            end

            if (j > length(bar_sizes) | (u < 0))
                v = 0;
            else
                v = y + bar_heights(j);
            end
        end

        f = @task_f;
end
