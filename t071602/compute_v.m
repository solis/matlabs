function v = compute_v(x, t, a, phi, psi)
    if (t < x/a)
        v = (phi(x + a*t) + phi(x - a*t))/2 + (1/(2*a))*quad(@(z) psi(z), x - a*t, x + a*t);
    else
        v = (phi(x + a*t) - phi(a*t - x))/2 + (1/(2*a))*quad(@(z) psi(z), a*t - x, x + a*t);    
    end
end