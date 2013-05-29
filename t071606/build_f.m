function f = build_f(f_x, f_y, x, y, u)
    f = zeros(1, length(u));
    for k = 1:length(u)
        u(k) = u(k) - x;
        j = 1;
        while (j <= length(f_x)) && (u(k) > f_x(j))
            j = j + 1;
        end
        if (j < length(f_x) || (u(k) > 0))
            f(k) = y + f_y(j);
        end
    end
end