%% Погдотовим описание той_самой_области

%%
%    stud_num   -   номер студента
%    bar_hi     -   высота высокого столбца
%    bar_lo     -   высота низкого столбца
%%

function [ bars ] = area_description(stud_num, bar_hi, bar_lo)

    % Очевидно, что столбцов будет  ceil(log2(stud_num))
    bitcount = ceil(log2(stud_num));

    % Высота высокго столбца
    bar_hi = 1;

    % Высота низкого столбца
    bar_lo = 0.3;

    % Биты, соотвествующие нашему номеру
    bits = [];
    num = stud_num;
    while num ~= 0
        bits = [mod(num, 2), bits(1:length(bits))];
        num = floor(num / 2);
    end

    % Дополним недостающими нулями
    bits = [ zeros([ 1, bitcount - length(bits) ]), bits(1:length(bits)) ];

    % Высоты
    heights = zeros([1, bitcount]);
    for i = 1:bitcount
        % Ну понятно: если bits[i] == 1 => 1 * bar_hi + (1 - 1) * bar_lo, иначе 0 * bar_hi + (1 - 0) * bar_lo
        heights(i) = bits(i) * bar_hi + (1 - bits(i)) * bar_lo;
    end

    bars = heights;
end
