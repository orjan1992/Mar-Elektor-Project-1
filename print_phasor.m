function [] = print_phasor( name, val, unit )
%PRINT_PHASOR Summary of this function goes here
%   Detailed explanation goes here
[n m] = size(val);
abc = 97:(97+n); 
if(n + m == 2)
    %fprintf(strcat(name, ' = ', num2str(abs(val)), ' [', unit, ']<', num2str(angle(val)*180/pi), char(176), '\n'));
    fprintf('%s = %6.2f [%s] /_ %6.2f%s \n', name, abs(val), unit, angle(val)*180/pi, 176);
else
    if(m == 1)
        for i = 1:n
            %fprintf(strcat(name, char(abc(i)), ' = ', num2str(abs(val(i))), ' [', unit, ']<', num2str(angle(val(i))*180/pi), char(176), '\n'));
            fprintf('%s%s = %6.2f [%s] /_ %6.2f%s \n', name, abc(i), abs(val(i)), unit, angle(val(i))*180/pi, 176);
        end
    else
        for i = 1:n
            for j = 1:m
                %fprintf(strcat(name, char(abc(i)), '(', num2str(j), ') = ', num2str(abs(val(i, j))), ' [', unit, ']<', num2str(angle(val(i, j))*180/pi), char(176), '\t\t\t'));
                fprintf('%s%s(%i) = %6.2f [%s] /_ %6.2f%s \t\t\t', name, abc(i),j, abs(val(i, j)), unit, angle(val(i, j))*180/pi, 176);
            end
            fprintf('\n');
        end
    end
end
end


