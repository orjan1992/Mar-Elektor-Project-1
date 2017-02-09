function [V_t Z_t] = thevenin_eq(par, CB, BT, E_tilde, theta)
%THEVENIN_EQ Script 2
%   Detailed explanation goes here
E_a =
%Check if Bus is connected
if BT == 1
    %Bus is closed
    if CB(1) == 1;
        %CB1 is closed
        V_t(:, 1) = [Inf Inf Inf]';
    else
        %CB1 is open
        V_t(:, 1) = [par.genset1.E_a par.genset1.E_a par.genset1.E_a]';
    end
    
    if (CB(2) == 1) && (CB(3) == 1)
        %CB2 and CB3 is closed
        V_t(:, 2) = [Inf Inf Inf]';
else
    %Bus is open
    end
end

