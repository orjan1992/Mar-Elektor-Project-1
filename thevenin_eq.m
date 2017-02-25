function [V_t Z_t] = thevenin_eq(par, CB, BT)
%THEVENIN_EQ Script 2
%   Detailed explanation goes here

%Calculatin E_a
par.genset1.E_a = par.genset1.E_tilde*cos(par.genset1.theta) + par.genset1.E_tilde*sin(par.genset1.theta)*1i;
par.genset2.E_a = par.genset2.E_tilde*cos(par.genset2.theta) + par.genset2.E_tilde*sin(par.genset2.theta)*1i;
par.genset3.E_a = par.genset3.E_tilde*cos(par.genset3.theta) + par.genset3.E_tilde*sin(par.genset3.theta)*1i;
par.genset1.E = [1; (1i)^(-4/3); (1i)^(4/3)]*par.genset1.E_a;
par.genset2.E = [1; (1i)^(-4/3); (1i)^(4/3)]*par.genset2.E_a;
par.genset3.E = [1; (1i)^(-4/3); (1i)^(4/3)]*par.genset3.E_a;
%Check if Bus is connected
if BT == 1
    %Bus is Closed
    %PORT
    if CB(1) == 0
        %CB1 is closed
        V_t(:, 1) = [0; 0; 0];
        Z_t(1) = Inf;
    else
        %CB1 is open
        V_t(:, 1) = par.genset1.E;
        Z_t(1) = par.genset1.Z_a;
    end
    
    %STARBOARD
    
    if (CB(2) == 0) && (CB(3) == 0)
        %CB2 and CB3 is closed
        V_t(:, 2) = [0; 0; 0];
        Z_t(2) = Inf;
    end
    
    if (CB(2) == 1) && (CB(3) == 0)
        %CB2 is open and CB3 is closed
        V_t(:, 2) = par.genset2.E;
        Z_t(2) = par.genset2.Z_a;
    end
    
    if (CB(2) == 0) && (CB(3) == 1)
        %CB2 is closed and CB3 is open
        V_t(:, 2) = par.genset3.E;
        Z_t(2) = par.genset3.Z_a;
    end
    
    if (CB(2) == 1) && (CB(3) == 1)
        %CB2 is open and CB3 is open
        temp_Z = (1/par.genset2.Z_a + 1/par.genset3.Z_a)^-1;
        temp_V = (par.genset2.E/par.genset2.Z_a + par.genset3.E/par.genset3.Z_a)*temp_Z;
        V_t(:, 2) = temp_V;
        Z_t(2) = temp_Z;
    end
    
    %Phase shifting
    %V_t = V_t.*[1 1; -2*pi*1i/3 -2*pi*1i/3; 2*pi*1i/3 2*pi*1i/3];
    
else
    %Bus is closed
    
    if (CB(1) == 0) && (CB(2) == 0) && (CB(3) == 0)
        %All Closed
        V_t = [0; 0; 0];
        Z_t = Inf;
    end
    
    if (CB(1) == 1) && (CB(2) == 0) && (CB(3) == 0)
        %CB1 open, CB2 and CB3 closed
        V_t = par.genset1.E;
        Z_t = par.genset1.Z_a;
    end
    
    if (CB(1) == 0) && (CB(2) == 1) && (CB(3) == 0)
        %CB1 closed, CB2 open, CB3 closed
        V_t = par.genset2.E;
        Z_t = par.genset2.Z_a;
    end
    
    if (CB(1) == 0) && (CB(2) == 0) && (CB(3) == 1)
        %CB1 closed, CB2 closed, CB3 open
        V_t = par.genset3.E;
        Z_t = par.genset3.Z_a;
    end
    
    if (CB(1) == 1) && (CB(2) == 1) && (CB(3) == 0)
        %CB1 open, CB2 open, CB3 closed
        temp_Z = (1/par.genset1.Z_a + 1/par.genset2.Z_a)^-1;
        temp_V = (par.genset1.E/par.genset1.Z_a + par.genset2.E/par.genset2.Z_a)*temp_Z;
        V_t = temp_V;
        Z_t = temp_Z;
    end
    
    if (CB(1) == 1) && (CB(2) == 0) && (CB(3) == 1)
        %CB1 open, CB2 closed, CB3 open
        temp_Z = (1/par.genset1.Z_a + 1/par.genset3.Z_a)^-1;
        temp_V = (par.genset1.E/par.genset1.Z_a + par.genset3.E/par.genset3.Z_a)*temp_Z;
        V_t = temp_V;
        Z_t = temp_Z;
    end
    
    if (CB(1) == 0) && (CB(2) == 1) && (CB(3) == 1)
        %CB1 closed, CB2 open, CB3 open
        temp_Z = (1/par.genset2.Z_a + 1/par.genset3.Z_a)^-1;
        temp_V = (par.genset2.E/par.genset2.Z_a + par.genset3.E/par.genset3.Z_a)*temp_Z;
        V_t = temp_V;
        Z_t = temp_Z;
    end
    
    if (CB(1) == 1) && (CB(2) == 1) && (CB(3) == 1)
        %All open
        temp_Z = (1/par.genset1.Z_a + 1/par.genset2.Z_a + 1/par.genset3.Z_a)^-1;
        temp_V = (par.genset1.E/par.genset1.Z_a + par.genset2.E/par.genset2.Z_a + par.genset3.E/par.genset3.Z_a)*temp_Z;
        V_t = temp_V;
        Z_t = temp_Z;
    end
    
end

