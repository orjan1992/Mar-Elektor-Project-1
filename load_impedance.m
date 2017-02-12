function [Z_l] = load_impedance(par, CB, BT)
%LOAD_IMPEDANCE Script 1
%   Detailed explanation goes here
%Check if Bus-tie Breaker is closed(1)
if BT == 1
    %Closed
    
    %PORT BUS
    
    %Check if CB4 is connected
    if CB(4) == 0
        %CB4 Open
        %Calculating load impedance
        Z_l(1) = par.motor1.Z_m;
    else
        %CB4 Closed => load impedance = infinite
        Z_l(1) = Inf;
    end
    
    %STARBOARD BUS
    Z_l(2) = 0;
    if CB(5) == 0
        %CB5 Open
        Z_l(2) = 1/par.motor2.Z_m;
    end
    
    if CB(6) == 0
        %CB6 Open
         Z_l(2) = Z_l(2) + 1/par.utility.Z_La_prime;
    end
    
    %Invert to get parallell impedance, both closed => 0^-1 = Inf
    Z_l(2) = Z_l(2)^-1;
    
else
    %BUS OPEN
    %BT1 Open
    Z_l = 0;
    
    %Check CB4
    if CB(4) == 0
        %CB4 Open
        Z_l = 1/par.motor1.Z_m;
    end
    
    %Check CB5
    if CB(5) == 0
        %CB5 Open
        Z_l = Z_l + 1/par.motor2.Z_m;
    end
    
    %Check CB6
    if CB(6) == 0
        %CB6 Open
        Z_l = Z_l + 1/par.utility.Z_La_prime;
    end
    
    %Invert to get parallell impedance, 0^-1 = Inf
    Z_l = Z_l^-1;
end
end

