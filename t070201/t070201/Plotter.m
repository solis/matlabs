classdef Plotter
   properties (Constant)
      X_MIN = -10;
      X_MAX = 10;      
      X_STEP = 0.1;
      
      Y_MIN = -10;
      Y_MAX = 10;  
      Y_STEP = 0.1;     
   end
   
   methods
       function plot_contour(obj, f)
          figure(1);          
          ezcontourf(f, [Plotter.X_MIN, Plotter.X_MAX, Plotter.Y_MIN, Plotter.Y_MAX]);
          colorbar('location', 'EastOutside')
       end

       function plot_boundaries_and_characteristics(obj, boundary, characteristic_1, characteristic_2)                   

          x = Plotter.X_MIN:Plotter.X_STEP:Plotter.X_MAX;
          b =  boundary(x)
          c1 = characteristic_1(x)
          c2 = characteristic_2(x)         

          figure(2);          
          hold on;
          axis([Plotter.X_MIN Plotter.X_MAX Plotter.Y_MIN Plotter.Y_MAX])
          plot(x, b, 'r-', x, c1, 'k--', x, c2, 'k--');

          moved = @(x, f, c)(f(x) + c)
          for i = -5:5
            c1 = moved(x, characteristic_1, i*20)
            c2 = moved(x, characteristic_2, i*5)
            plot(x, c1, 'k-.', x, c2, 'k-.')
          end 

          xlabel('x');
          ylabel('y');          
          hold off; 
       end

       function plot_surface(obj, f)
          figure(3);          
          x = Plotter.X_MIN:Plotter.X_STEP:Plotter.X_MAX;
          y = Plotter.Y_MIN:Plotter.Y_STEP:Plotter.Y_MAX;
          [X, Y] = meshgrid(x, y);
          Z = f(X,Y)
          surf(X, Y, Z)
          shading flat;
          view(30, 25);
          xlabel('x');
          ylabel('y');
          zlabel('z');
       end
   end
   
end
