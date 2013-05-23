function [ERR_ABS, ERR_REL] = errors(RESULT, TEST)
    size_res = size(RESULT);
    size_test = size(TEST);
    if ( size_test(1) ~= size_res(1) ) || ( size_res(2) ~= size_test(2) )
        error('Dimensions not match')
    end

    m = size_res(1); n = size_res(2);
    ERR_ABS = zeros(size_res(1), size_res(2)); ERR_REL = zeros(size_res(1), size_res(2));

    for i = 1:m
        for j = 1:n 
            ERR_ABS(i, j) = abs(RESULT(i, j) - TEST(i, j));
            ERR_REL(i, j) = ERR_ABS(i, j) / abs(TEST(i, j));
        end
    end
end

