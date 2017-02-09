function [V_t Z_t] = thevenin_eq(par, CB, BT)
%THEVENIN_EQ Script 2
%   Detailed explanation goes here

%Check if Bus is connected
if BT == 1
    %Bus is closed
    if CB(1) == 1;
        %CB1 is closed
        V_t(:, 1) = [0 0 0]';
        Z_t(:, 1) = [Inf Inf Inf]';
    else
        %CB1 is open
        V_t(:, 1) = [par.genset1.E_a par.genset1.E_a par.genset1.E_a]';
        Z_t(:, 1) = [par.genset1.Z_a par.genset1.Z_a par.genset1.Z_a]';
    end
    
    if (CB(2) == 1) && (CB(3) == 1)
        %CB2 and CB3 is closed
        V_t(:, 2) = [0 0 0]';
        Z_t(:, 2) = [Inf Inf Inf]';
    end
    
    if (CB(2) == 0) && (CB(3) == 1)
        %CB2 is open and CB3 is closed
        V_t(:, 2) = [par.genset2.E_a par.genset2.E_a par.genset2.E_a]';
        Z_t(:, 2) = [par.genset2.Z_a par.genset2.Z_a par.genset2.Z_a]';
    end
    
    if (CB(2) == 1) && (CB(3) == 0)
        %CB2 is closed and CB3 is open
        V_t(:, 2) = [par.genset3.E_a par.genset3.E_a par.genset3.E_a]';
        Z_t(:, 2) = [par.genset3.Z_a par.genset3.Z_a par.genset3.Z_a]';
    end
    
    if (CB(2) == 0) && (CB(3) == 0)
        %CB2 is open and CB3 is open
        temp_Z = (1/par.genset2.Z_a + 1/par.genset3.Z_a)^-1;
        temp_V = (par.genset2.E_a/par.genset2.Z_a + par.genset3.E_a/par.genset3.Z_a)*temp_Z;
        V_t(:, 2) = [temp_V temp_V temp_V]';
        Z_t(:, 2) = [temp_Z temp_Z temp_Z]';
    end
else
    %Bus is open
    
    if (CB(1) == 1) && (CB(2) == 1) && (CB(3) == 1)
        %All Closed
        V_t = [0 0 0]';
        Z_t = [Inf Inf Inf]';
    end
    
    if (CB(1) == 0) && (CB(2) == 1) && (CB(3) == 1)
        %CB1 open, CB2 and CB3 closed
        V_t = [par.genset1.E_a par.genset1.E_a par.genset1.E_a]';
        Z_t = [par.genset1.Z_a par.genset1.Z_a par.genset1.Z_a]';
    end
    
    if (CB(1) == 1) && (CB(2) == 0) && (CB(3) == 1)
        %CB1 closed, CB2 open, CB3 closed
        V_t = [par.genset2.E_a par.genset2.E_a par.genset2.E_a]';
        Z_t = [par.genset2.Z_a par.genset2.Z_a par.genset2.Z_a]';
    end
    
    if (CB(1) == 1) && (CB(2) == 1) && (CB(3) == 0)
        %CB1 closed, CB2 closed, CB3 open
        V_t = [par.genset3.E_a par.genset3.E_a par.genset3.E_a]';
        Z_t = [par.genset3.Z_a par.genset3.Z_a par.genset3.Z_a]';
    end
    
    if (CB(1) == 0) && (CB(2) == 0) && (CB(3) == 1)
        %CB1 open, CB2 open, CB3 closed
        temp_Z = (1/par.genset1.Z_a + 1/par.genset2.Z_a)^-1;
        temp_V = (par.genset1.E_a/par.genset1.Z_a + par.genset2.E_a/par.genset2.Z_a)*temp_Z;
        V_t = [temp_V temp_V temp_V]';
        Z_t = [temp_Z temp_Z temp_Z]';
    end
    
    if (CB(1) == 0) && (CB(2) == 1) && (CB(3) == 0)
        %CB1 open, CB2 closed, CB3 open
        temp_Z = (1/par.genset1.Z_a + 1/par.genset3.Z_a)^-1;
        temp_V = (par.genset1.E_a/par.genset1.Z_a + par.genset3.E_a/par.genset3.Z_a)*temp_Z;
        V_t = [temp_V temp_V temp_V]';
        Z_t = [temp_Z temp_Z temp_Z]';
    end
    
    if (CB(1) == 1) && (CB(2) == 0) && (CB(3) == 0)
        %CB1 closed, CB2 open, CB3 open
        temp_Z = (1/par.genset2.Z_a + 1/par.genset3.Z_a)^-1;
        temp_V = (par.genset2.E_a/par.genset2.Z_a + par.genset3.E_a/par.genset3.Z_a)*temp_Z;
        V_t = [temp_V temp_V temp_V]';
        Z_t = [temp_Z temp_Z temp_Z]';
    end
    
    if (CB(1) == 0) && (CB(2) == 0) && (CB(3) == 0)
        %All open
        temp_Z = (1/par.genset1.Z_a + 1/par.genset2.Z_a + 1/par.genset3.Z_a)^-1;
        temp_V = (par.genset1.E_a/par.genset1.Z_a + par.genset2.E_a/par.genset2.Z_a + par.genset3.E_a/par.genset3.Z_a)*temp_Z;
        V_t = [temp_V temp_V temp_V]';
        Z_t = [temp_Z temp_Z temp_Z]';
    end
end

