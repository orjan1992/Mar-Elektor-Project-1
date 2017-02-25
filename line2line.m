function [ V_ll ] = line2line( BT, V_n )
%LINE2LINE Computes line to line voltages
%   Detailed explanation goes here
if BT == 0
    %closed
    V_ll(1, 1) = V_n(1) - V_n(2);
    V_ll(2, 1) = V_n(2) - V_n(3);
    V_ll(3, 1) = V_n(3) - V_n(1);
else
    V_ll(1, 1) = V_n(1, 1) - V_n(2, 1);
    V_ll(2, 1) = V_n(2, 1) - V_n(3, 1);
    V_ll(3, 1) = V_n(3, 1) - V_n(1, 1);
    
    V_ll(1, 2) = V_n(1, 2) - V_n(2, 2);
    V_ll(2, 2) = V_n(2, 2) - V_n(3, 2);
    V_ll(3, 2) = V_n(3, 2) - V_n(1, 2);

end

