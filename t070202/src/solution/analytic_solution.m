function [ u ] = analytic_solution( x, t )
    function [ v ] = v(x, t)
        if (t > x / a)
            v = (phi( x + a*t ) + phi( x - a*t )) / 2 + (2*a*t * (a.^2 * t.^2 + 3*x.^2 - 2*x + 3)) / (2*a);
        else
            v = (phi( x + a*t ) - phi( x - a*t )) / 2 +  (2*x * (3*(a.^2) * (t.^2) + 2*a*t + x.^2 + 3)) / (2*a);
        end
    end

    function [ w ] = w(x, t)
        if (t < x / a)
            w = (-2*a*t.^3 - 14*a*t.^2 + 48 * a * t.^2 * x)/ (2*a) ;
        else            
            i1 = -(6*x * ((x - a*t).^2))/(a.^2) + (28*x*(x - a*t)/ a) +  48*x*( a*t.^2 - x.^2/a);
            i2 = (4*x.^3 - 6*a*t*x.^2)/a - (14*x.^2) / a + (48*x.^3) / a;                        
            w = ( i1 + i2 ) / (2*a);                        
        end
    end

    function [ z ] = z(x, t)
       if (t >= x / a)
         z = mu(t - x / a);
        else
         z = 0;
        end
    end

    u = z(x, t) + v(x, t) + w(x, t);
end

