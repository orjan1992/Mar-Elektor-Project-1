function [ genParameters ] = gen_params(  par, CB, BT, V_n, Z_t )
%GEN_PARAMS Summary of this function goes here
%   Detailed explanation goes here

%Check if Bus-tie Breaker is open
if BT == 0
    %Open
    
    %% PORT BUS
    % V_n == 0 if open => I == 0
    I_G1 = V_n(:, 1)./par.genset1.Z_a;  
    genParameters.I_neutral(1) = ones(1, 3)*(1/Z_t(1))*V_n(:, 1);
    
    %% Starboard BUS
    I_G2 = 0;
    I_G3 = 0;
    if CB(2) == 1
        %closed
        I_G2 = V_n(:, 2)./par.genset2.Z_a;
    end
    if CB(3) == 1
        %closed
        I_G3 = V_n(:, 2)./par.genset3.Z_a;
    end
    genParameters.I_neutral(2) = ones(1, 3)*(1/Z_t(2))*V_n(:, 2);
    
    %% Power calculations
    S_1 = 3*V_n(1,1)*conj(I_G1(1));
    S_2 = 3*V_n(1, 2)*conj(I_G2(1));
    S_3 = 3*V_n(1, 2)*conj(I_G3(1));
else
    %bus closed
    %all open
    I_G1 = 0;
    I_G2 = 0;
    I_G3 = 0;
    if CB(1) == 1
        %closed
        I_G1 = V_n./par.genset1.Z_a;
    end
    if CB(2) == 1
        %closed
        I_G2 = V_n./par.genset2.Z_a;
    end
    if CB(3) == 1
        %closed
        I_G3 = V_n./par.genset3.Z_a;
    end
    genParameters.I_neutral = ones(1, 3)*(1/Z_t)*V_n;
    %% Power calculations
    S_1 = 3*V_n(1)*conj(I_G1(1));
    S_2 = V_n'*conj(I_G2);
    S_3 = V_n'*conj(I_G3);
        
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

