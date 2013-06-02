function value = approxLegendre(f, x, N)
% APPROXBESSEL   Approximate with Bessel functions.
% approxBessel(f, x, N)
    function y = legendren(n, x)
        Y = legendre(n, x, 'norm');
        y = Y(1, 1:length(x));
    end
value= quad(@(t)f(t), -1, 1)/2;
for k = 1:N
    value = value + legendren(k, x)*quad(@(t)(f(t).* legendren(k,t)), -1, 1);
end

end
