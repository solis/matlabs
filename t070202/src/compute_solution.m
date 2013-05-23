function [ U ] = compute__solution(X, T, f)
    U = zeros(length(T), length(X));
    for t = 1:length(T)
        for x = 1:length(X)
            U(t, x) = f(X(x), T(t));
        end     
    end
end
