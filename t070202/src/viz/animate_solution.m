function [] = animate_solution(X, T, U, U_a)
    figure;
    h_plot = line(X, U(1, 1:length(X)), 'color','k','erase','normal','linewidth',2);
    h_plot_a = line(X, U_a(1, 1:length(X)), 'color', 'g', 'erase', 'normal', 'linewidth', 2);
    xlabel('x')
    ylabel('u')
    axis([min(X) max(X) min(min(U)) max(max(U))]); 
    h_title = title(sprintf('u(x, t) at t = %d', 0));
    h_at = line([T(1) * a  T(1) * a], [min(min(U))  max(max(U))]);   
    legend('Numeric solution', 'Analytic solution', 'x = a*t');
    
    valid = true;
    while(valid)
        for t = 1:length(T)                                   
            if (valid)
                pause(1);                             
                try
                    set(h_plot,   'ydata', U  (t, 1:length(X)));
                    set(h_at, 'ydata', [(min(min(U))) (max(max(U)))] ,    'xdata', [(T(t) * a) (T(t) * a)]);                    
                    set(h_plot_a, 'ydata', U_a(t, 1:length(X)));
                    set(h_title, 'String', sprintf('u(x, t) at t = %0.3f', T(t)))                            
                catch
                    valid = false;
                end
                drawnow;
            else
                break;
            end
        end
    end
end
