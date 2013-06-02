function value = func719(fX, fY, x, y, z)
% FUNC719   Function to approximate for number 719.
% func719(fX, fY, x, y, z)
value = zeros(1, length(z));
for k = 1:length(z)
    z(k) = z(k) - x;
    j = 1;
    while (j <= length(fX)) && (z(k) > fX(j))
        j = j + 1;
    end
    if (j < length(fX) || (z(k) > 0))
        value(k) = y + fY(j);
    end
end
    
end