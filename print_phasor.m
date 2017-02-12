function [] = print_phasor( name, val, unit )
%PRINT_PHASOR Summary of this function goes here
%   Detailed explanation goes here
[n m] = size(val);
abc = 97:(97+n); 
if(n + m == 2)
    fprintf(strcat(name, ' = ', num2str(abs(val)), ' [', unit, ']<', num2str(angle(val)*180/pi), char(176), '\n'));
else
    if(m == 1)
        for i = 1:length(val)
            fprintf(strcat(name, char(abc(i)), ' = ', num2str(abs(val(i))), ' [', unit, ']<', num2str(angle(val(i))*180/pi), char(176), '\n'));
        end
    else
        for i = 1:n
            for j = 1:m
                fprintf(strcat(name, char(abc(i)), '(', num2str(j), ') = ', num2str(abs(val(i, j))), ' [', unit, ']<', num2str(angle(val(i, j))*180/pi), char(176), '\t\t\t'));
            end
            fprintf('\n');
        end
    end
end
end


