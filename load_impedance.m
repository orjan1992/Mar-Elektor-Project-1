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
        Z_la(1) = par.motor1.Z_m;
        Z_lb(1) = par.motor1.Z_m;
        Z_lc(1) = par.motor1.Z_m;
    else
        %CB4 Closed => load impedance = infinite
        Z_la(1) = Inf;
        Z_lb(1) = Inf;
        Z_lc(1) = Inf;
    end
    
    %STARBOARD BUS
    Z_la(2) = 0;
    Z_lb(2) = 0;
    Z_lc(2) = 0;
    
    if CB(5) == 0
        %CB5 Open
        Z_la(2) = par.motor2.Z_m;
        Z_lb(2) = par.motor2.Z_m;
        Z_lc(2) = par.motor2.Z_m;
    end
    
    if CB(6) == 0
        %CB6 Open
        Z_la(2) = Z_la(2) + par.utility.Z_La_prime;
        Z_lb(2) = Z_lb(2) + par.utility.Z_Lb_prime;
        Z_lc(2) = Z_lc(2) + par.utility.Z_Lc_prime;
    end
   
    %Check if there are no loads connected and if so impendance is infinite
    if (Z_la(2)==0)||(Z_lb(2)==0)||(Z_lc(2)==0)
        Z_la(2) = Inf;
        Z_lb(2) = Inf;
        Z_lc(2) = Inf;
    end
else
    %BT1 Open
    Z_la = 0;
    Z_lb = 0;
    Z_lc = 0;
    
    %Check CB4
    if CB(4) == 0
        %CB4 Open
        Z_la = par.motor1.Z_m;
        Z_lb = par.motor1.Z_m;
        Z_lc = par.motor1.Z_m;
    end
    
    %Check CB5
    if CB(5) == 0
        %CB5 Open
        Z_la = Z_la + par.motor2.Z_m;
        Z_lb = Z_lb + par.motor2.Z_m;
        Z_lc = Z_lc + par.motor2.Z_m;
    end
    
    %Check CB6
    if CB(6) == 0
        %CB6 Open
        Z_la = Z_la + par.utility.Z_La_prime;
        Z_lb = Z_lb + par.utility.Z_Lb_prime;
        Z_lc = Z_lc + par.utility.Z_Lc_prime;
    end
    
     %Check if there are no loads connected and if so impendance is infinite
    if (Z_la==0)||(Z_lb==0)||(Z_lc==0)
        Z_la = Inf;
        Z_lb = Inf;
        Z_lc = Inf;
    end
end

Z_l = [ Z_la; Z_lb; Z_lc ];
end

