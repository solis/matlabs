function approximation = legendre_approximation(f, x, summ_count)
    function y = legendre_n(n, x)
        Y = legendre(n, x, 'norm');
        y = Y(1, 1:length(x));
    end
    approximation = quad(@(t) f(t), -1, 1) / 2;
    for k = 1:summ_count
        approximation = approximation + legendre_n(k, x)*quad(@(t) f(t) .* legendre_n(k,t), -1, 1);
    end
end