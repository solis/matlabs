function value = approxBessel(f, x, N)
% APPROXBESSEL   Approximate with Bessel functions.
% approxBessel(f, x, N)
value = 0;
for k = 1:N
    Z = fzero(@(x) (besselj(0, x)), [(k - 1), k]*pi);
    value = value + besselj(0, x*Z)*2*quad(@(t)(t.*besselj(0, Z*t).*f(t)), 0, 1)/((besselj(1, Z)).^2);
end

end