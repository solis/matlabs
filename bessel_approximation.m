function approximation = bessel_approximation(f, x, summ_count)
    approximation = 0;
    for k = 1:summ_count
        Z = fzero(@(x) (besselj(0, x)), [(k - 1), k]*pi);
        approximation = approximation + besselj(0, x*Z)*2*quad(@(t) (t.*besselj(0, Z*t).*f(t)), 0, 1)/(besselj(1, Z)).^2;
    end
end