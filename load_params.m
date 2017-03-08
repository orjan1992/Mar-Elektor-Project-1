function loadParameters = load_params( par, CB, BT, V_n, Z_l )
%LOAD_PARAMS Summary of this function goes here
%   Detailed explanation goes here

%Check if Bus-tie Breaker is open
if BT == 0
    %Open
    
    %% PORT BUS
    
    %Breaker status on CB4 is already taken care of. Closed gives inf
    %impedance->0  current
    I_M1 = V_n(:, 1)./Z_l(1);
    loadParameters.I_neutral(1) = ones(1, 3)*(1/Z_l(1))*V_n(:, 1);
    
    %% STARBOARD BUS
    %calculating currents
    I_M2 = V_n(:, 2)./par.motor2.Z_m;
    I_T1 = V_n(:, 2)./par.utility.Z_La_prime;
    loadParameters.I_neutral(2) = ones(1, 3)*(1/Z_l(2))*V_n(:, 2);
%     
%     %setting currents to zero if Open
%     if CB(5) == 0
%         I_M2 = [0; 0; 0];
%     end
%     if CB(6) == 0
%         I_T1 = [0; 0; 0];
%     end
        
    
    %% phi and V_m
    PF_M1 = cos(angle(V_n(1, 1)) - angle(I_M1(1)));
    PF_M2 = cos(angle(V_n(1, 2)) - angle(I_M2(1)));
    PF_T1 = cos(angle(V_n(1, 2)) - angle(I_T1(1)));
    
    %% S
    S_M1 = V_n(1, 1)*conj(I_M1);
    S_M2 = V_n(1, 2)*conj(I_M2);
    S_T1 = V_n(1, 2)*conj(I_T1);
else
    %% BUS Closed
    %calculating currents
    I_M1 = V_n./par.motor1.Z_m;
    I_M2 = V_n./par.motor2.Z_m;
    I_T1 = V_n./par.utility.Z_La_prime;
    loadParameters.I_neutral = ones(1, 3)*(1/Z_l)*V_n;
%     
%     %Check CB4
%     if CB(4) == 0
%         %CB4 Open
%         I_M1 = [0; 0; 0];
%     end
%     
%     %Check CB5
%     if CB(5) == 0
%         %CB5 Open
%         I_M2 = [0; 0; 0];
%     end
%     
%     %Check CB6
%     if CB(6) == 0
%         %CB6 Open
%         I_T1 = [0; 0; 0];
%     end
    
    %% phi
    PF_M1 = cos(angle(V_n(1)) - angle(I_M1(1)));
    PF_M2 = cos(angle(V_n(1)) - angle(I_M2(1)));
    PF_T1 = cos(angle(V_n(1)) - angle(I_T1(1)));
    
    %% S
    S_M1 = V_n(1)*conj(I_M1);
    S_M2 = V_n(1)*conj(I_M2);
    S_T1 = V_n(1)*conj(I_T1);
end

    %% Feeding into output
    loadParameters.motor1.I = I_M1;
    loadParameters.motor1.S = S_M1;
    loadParameters.motor1.P = real(S_M1);
    loadParameters.motor1.Q = imag(S_M1);
    loadParameters.motor1.PF = PF_M1;
      
    loadParameters.motor2.I = I_M2;
    loadParameters.motor2.S = S_M2;
    loadParameters.motor2.P = real(S_M2);
    loadParameters.motor2.Q = imag(S_M2);
    loadParameters.motor2.PF = PF_M2;
    
    loadParameters.transformer.I = I_T1;
    loadParameters.transformer.S = S_T1;
    loadParameters.transformer.P = real(S_T1);
    loadParameters.transformer.Q = imag(S_T1);
    loadParameters.transformer.PF = PF_T1;
    loadParameters.S = S_M1 + S_M2 + S_T1;
end
