function [ genParameters ] = gen_params(par, CB, BT, V_n, V_t,Z_t, Z_l)
%GEN_PARAMS Summary of this function goes here
%   Detailed explanation goes here

%Check if Bus-tie Breaker is open
if BT == 0
    %Open
    
    %% PORT BUS
    % V_n == 0 if open => I == 0
%     I_G1 = par.genset1.E/(par.genset1.Z_a+Z_l(1));
%     V_G1 = par.genset1.E - par.genset1.Z_a*I_G1;

    I_aa =V_t(:, 1)/(Z_l(1) + Z_t(1));
    V_temp = par.genset1.E - I_aa*par.genset1.Z_a;
    V_G1 = par.genset1.E - par.genset1.Z_a*I_aa;
    I_G1 = (par.genset1.E-V_temp)/par.genset1.Z_a;
    %genParameters.I_neutral(1) = ones(1, 3)*(1/Z_t(1))*V_n(:, 1);
    
    %% Starboard BUS
    I_aa =V_t(:, 2)/(Z_l(2) + Z_t(2));
    V_temp = (1/par.genset2.Z_a + 1/par.genset3.Z_a)^-1*(par.genset2.E/par.genset2.Z_a + par.genset3.E/par.genset3.Z_a - I_aa);
    V_G2 = par.genset2.E-V_temp;%par.genset2.Z_a*I_aa;
    V_G3 = par.genset3.E-V_temp;%par.genset3.Z_a*I_aa;
    I_G2 = (par.genset2.E-V_temp)/par.genset2.Z_a;
    I_G3 = (par.genset3.E-V_temp)/par.genset3.Z_a;
    
%     disp(par.genset2.E/par.genset2.Z_a + par.genset3.E/par.genset3.Z_a - I_aa);
    if CB(2) == 0
        %open
        I_G2 = 0;
    end
    if CB(3) == 0
        %open
        I_G3 = 0;
    end
    %genParameters.I_neutral(2) = ones(1, 3)*(1/Z_t(2))*V_n(:, 2);
    
    %% Power calculations
    S_1 = 3*V_G1(1)*conj(I_G1(1));
    S_2 = 3*V_G2(1)*conj(I_G2(1));
    S_3 = 3*V_G3(1)*conj(I_G3(1));
else
    %bus closed
    %all open
    I_G1 = par.genset1.E/(par.genset1.Z_a+Z_l);
    I_G2 = par.genset2.E/(par.genset2.Z_a+Z_l);
    I_G3 = par.genset3.E/(par.genset3.Z_a+Z_l);
    I_an = V_n/(Z_l+Z_t)
    V_G1 = par.genset1.E_a - par.genset1.Z_a*I_an;
    V_G2 = par.genset2.E_a - par.genset2.Z_a*I_an;
    V_G3 = par.genset3.E_a - par.genset3.Z_a*I_an;
%     I_G1 = V_G1/par.genset1.Z_a;
%     I_G2 = V_G2/par.genset2.Z_a;
%     I_G3 = V_G3/par.genset3.Z_a;
    
    if CB(1) == 0
        %open
        I_G1 = 0;
    end
    if CB(2) == 0
        %open
        I_G2 = 0;
    end
    if CB(3) == 0
        %open
        I_G3 = 0;
    end
%     genParameters.I_neutral = ones(1, 3)*(1/Z_t)*V_n;
    %% Power calculations
%     S_1 = 3*(par.genset1.E_a - V_n(1))*conj(I_G1(1));
%     S_2 = 3*(par.genset2.E_a - V_n(1))*conj(I_G2(1));
%     S_3 = 3*(par.genset3.E_a - V_n(1))*conj(I_G3(1));
    S_1 = 3*V_G1(1)*conj(I_an(1));
    S_2 = 3*V_G2(1)*conj(I_an(1));
    S_3 = 3*V_G3(1)*conj(I_an(1));
        
end
genParameters.genset1.S = S_1;
genParameters.genset1.P = real(S_1);
genParameters.genset1.Q = imag(S_1);
genParameters.genset1.P_percentage = genParameters.genset1.P/par.genset1.P_n;
genParameters.genset1.Q_percentage = genParameters.genset1.Q/par.genset1.Q_n;
genParameters.genset1.I = I_G1;

genParameters.genset2.S = S_2;
genParameters.genset2.P = real(S_2);
genParameters.genset2.Q = imag(S_2);
genParameters.genset2.P_percentage = genParameters.genset2.P/par.genset2.P_n;
genParameters.genset2.Q_percentage = genParameters.genset2.Q/par.genset2.Q_n;
genParameters.genset2.I = I_G2;

genParameters.genset3.S = S_3;
genParameters.genset3.P = real(S_3);
genParameters.genset3.Q = imag(S_3);
genParameters.genset3.P_percentage = genParameters.genset3.P/par.genset3.P_n;
genParameters.genset3.Q_percentage = genParameters.genset3.Q/par.genset3.Q_n;
genParameters.genset3.I = I_G3;
end

