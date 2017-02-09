function [] = print_phasor( name, val, unit )
%PRINT_PHASOR Summary of this function goes here
%   Detailed explanation goes here
fprintf(strcat(name, ' = ', num2str(abs(val)), ' [', unit, ']/_', num2str(angle(val)*180/pi), char(176), '\n'));

end

