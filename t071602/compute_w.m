function w = compute_w(x, t, a, f)
    if (t < x/a)
        w = (1/(2*a))*dblquad(@(z, tau) f(z, tau) .* (z >= x - a*(t-tau)) .* (z <= x + a*(t - tau)), x - a*t, x + a*t, 0, t);
    else
        w = (1/(2*a))*dblquad(@(z, tau) f(z, tau) .* (z >= a*(t - tau) - x) .* (z <= x + a*(t - tau)), 0, x + a*t, 0, t - x/a) + (1/(2*a))*dblquad( @(z, tau) f(z, tau) .* (z >= x - a*(t - tau)) .* (z <= x + a*(t - tau)), 0, 2*x, t - x/a, t);
    end
end
