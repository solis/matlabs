%%
% Аналогично индикатору области из area.m создадим кусочно непрерывную функцию по таким же правилам.

function [ f ] = task_function(bar_heights, bar_sizes, x, y)
    function [ v ] = task_f(u)
        v = zeros(1,length(u));
        for k = 1:length(u)
            % Смещаем в 0, 0
            u(k) = u(k) - x;

            j = 1;
            while (j <= length(bar_sizes)) && (u(k) > bar_sizes(j))
                j = j + 1;
            end

            if ~(j > length(bar_sizes) || (u(k) < 0))
                v(k) = y + bar_heights(j);
            end
        end
    end

    f = @task_f;
end
