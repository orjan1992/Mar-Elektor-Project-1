function [V_n] = NVA(par, CB, BT, Z_l, V_t, Z_t)
%NVA Nodal voltage analysis Script 3
%   Detailed explanation goes here
if BT == 1
    %Bus is closed
    %Port
    V_n(:, 1) = (eye(3)*(1/Z_l(1) + 1/Z_t(1)))\V_t(:, 1);
    %Starboard
    V_n(:, 2) = (eye(3)*(1/Z_l(2) + 1/Z_t(2)))\V_t(:, 2);
else
    %Bus is open
    V_n = (eye(3)*(1/Z_l + 1/Z_t))\V_t;
end
end

