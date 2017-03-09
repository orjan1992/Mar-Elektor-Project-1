function [V_t Z_t] = thevenin_eq(par, CB, BT)
%THEVENIN_EQ Script 2
%   Detailed explanation goes here

%Check if Bus is connected
if BT == 0
    %Bus is Open
    %PORT
    if CB(1) == 0
        %CB1 is open
        V_t(:, 1) = [0; 0; 0];
        Z_t(1) = Inf;
    else
        %CB1 is closed
        V_t(:, 1) = par.genset1.E;
        Z_t(1) = par.genset1.Z_a;
    end
    
    %STARBOARD
    
    if (CB(2) == 0) && (CB(3) == 0)
        %CB2 and CB3 is open
        V_t(:, 2) = [0; 0; 0];
        Z_t(2) = Inf;
    end
    
    if (CB(2) == 1) && (CB(3) == 0)
        %CB2 is closed and CB3 is open
        V_t(:, 2) = par.genset2.E;
        Z_t(2) = par.genset2.Z_a;
    end
    
    if (CB(2) == 0) && (CB(3) == 1)
        %CB2 is open and CB3 is closed
        V_t(:, 2) = par.genset3.E;
        Z_t(2) = par.genset3.Z_a;
    end
    
    if (CB(2) == 1) && (CB(3) == 1)
        %CB2 is closed and CB3 is closed
        Z_t = (1/par.genset2.Z_a + 1/par.genset3.Z_a)^-1;
        V_t = (par.genset2.E/par.genset2.Z_a + par.genset3.E/par.genset3.Z_a)*Z_t;
        V_t(:, 2) = V_t;
        Z_t(2) = Z_t;
    end
else
    %Bus is closed
    
    %All Open
    V_t = [0; 0; 0];
    Z_t = Inf;
    
    if (CB(1) == 1) && (CB(2) == 0) && (CB(3) == 0)
        %CB1 closed, CB2 and CB3 open
        V_t = par.genset1.E;
        Z_t = par.genset1.Z_a;
    end
    
    if (CB(1) == 0) && (CB(2) == 1) && (CB(3) == 0)
        %CB1 open, CB2 closed, CB3 open
        V_t = par.genset2.E;
        Z_t = par.genset2.Z_a;
    end
    
    if (CB(1) == 0) && (CB(2) == 0) && (CB(3) == 1)
        %CB1 open, CB2 open, CB3 closed
        V_t = par.genset3.E;
        Z_t = par.genset3.Z_a;
    end
    
    if (CB(1) == 1) && (CB(2) == 1) && (CB(3) == 0)
        %CB1 closed, CB2 closed, CB3 open
        Z_t = (1/par.genset1.Z_a + 1/par.genset2.Z_a)^-1;
        V_t = (par.genset1.E/par.genset1.Z_a + par.genset2.E/par.genset2.Z_a)*Z_t;
    end
    
    if (CB(1) == 1) && (CB(2) == 0) && (CB(3) == 1)
        %CB1 closed, CB2 open, CB3 closed
        Z_t = (1/par.genset1.Z_a + 1/par.genset3.Z_a)^-1;
        V_t = (par.genset1.E/par.genset1.Z_a + par.genset3.E/par.genset3.Z_a)*Z_t;
    end
    
    if (CB(1) == 1) && (CB(2) == 0) && (CB(3) == 1)
        %CB1 closed, CB2 open, CB3 closed
        Z_t = (1/par.genset2.Z_a + 1/par.genset3.Z_a)^-1;
        V_t = (par.genset2.E/par.genset2.Z_a + par.genset3.E/par.genset3.Z_a)*Z_t;
    end
    
    if (CB(1) == 1) && (CB(2) == 1) && (CB(3) == 1)
        %All closed
        Z_t = (1/par.genset1.Z_a + 1/par.genset2.Z_a + 1/par.genset3.Z_a)^-1;
        V_t = (par.genset1.E/par.genset1.Z_a + par.genset2.E/par.genset2.Z_a + par.genset3.E/par.genset3.Z_a)*Z_t;
    end
    
end

