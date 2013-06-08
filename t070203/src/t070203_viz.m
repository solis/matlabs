load('solution.mat');
plot_contour(X, T, UN, UA);
plot_surface(X, T, UN, UA);
plot_contour_err(X, T, ABS_ERR, REL_ERR);
