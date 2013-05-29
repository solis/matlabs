function z = compute_z(x, t, a, mu)
    if (t >= x/a)
        z = mu(t - x/a);
    else
        z = 0;
    end
end