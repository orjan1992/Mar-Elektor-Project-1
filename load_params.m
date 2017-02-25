function loadParameters = load_params( par, CB, BT, V_n, Z_l )
%LOAD_PARAMS Summary of this function goes here
%   Detailed explanation goes here

%Check if Bus-tie Breaker is open
if BT == 1
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
    
    %setting currents to zero if closed
    if CB(5) == 0
        I_M2 = [0; 0; 0];
    end
    if CB(6) == 0
        I_T1 = [0; 0; 0];
    end
        
    
    %% phi and V_m
    phi_M1 = angle(V_n(1, 1)) - angle(I_M1(1));
    phi_M2 = angle(V_n(1, 2)) - angle(I_M2(1));
    phi_T1 = angle(V_n(1, 2)) - angle(I_T1(1));
    
    %V_m
    V_m_M1 = abs(V_n(1, 1));
    V_m_M2 = abs(V_n(1, 2));
    V_m_T1 = V_m_M2;
    
else
    %% BUS OPEN
    %calculating currents
    I_M1 = V_n./par.motor1.Z_m;
    I_M2 = V_n./par.motor2.Z_m;
    I_T1 = V_n./par.utility.Z_La_prime;
    loadParameters.I_neutral = ones(1, 3)*(1/Z_l)*V_n;
    
    %Check CB4
    if CB(4) == 0
        %CB4 closed
        I_M1 = [0; 0; 0];
    end
    
    %Check CB5
    if CB(5) == 0
        %CB5 Closed
        I_M2 = [0; 0; 0];
    end
    
    %Check CB6
    if CB(6) == 0
        %CB6 Closed
        I_T1 = [0; 0; 0];
    end
    
    %% phi and V_m
    phi_M1 = angle(V_n(1)) - angle(I_M1(1));
    phi_M2 = angle(V_n(1)) - angle(I_M2(1));
    phi_T1 = angle(V_n(1)) - angle(I_T1(1));
    
    %V_m
    V_m_M1 = abs(V_n(1));
    V_m_M2 = abs(V_n(1));
    V_m_T1 = V_m_M2;
end


    %% Power calculations
    %Power factor
    PF_M1 = cos(phi_M1);
    PF_M2 = cos(phi_M2);
    PF_T1 = cos(phi_T1);
    
    %I_m
    I_m_M1 = abs(I_M1(1));
    I_m_M2 = abs(I_M2(1));
    I_m_T1 = abs(I_T1(1));
    
    %Active power
    P_M1 = 3*V_m_M1*I_m_M1*PF_M1;
    P_M2 = 3*V_m_M2*I_m_M2*PF_M2;
    P_T1 = 3*V_m_T1*I_m_T1*PF_T1;
    
    %Reactive power
    Q_M1 = 3*V_m_M1*I_m_M1*sin(phi_M1);
    Q_M2 = 3*V_m_M2*I_m_M2*sin(phi_M2);
    Q_T1 = 3*V_m_T1*I_m_T1*sin(phi_T1);
    
    %% Feeding into output
    loadParameters.motor1.I = I_M1;
    loadParameters.motor1.P = P_M1;
    loadParameters.motor1.Q = Q_M1;
    loadParameters.motor1.PF = PF_M1;
      
    loadParameters.motor2.I = I_M2;
    loadParameters.motor2.P = P_M2;
    loadParameters.motor2.Q = Q_M2;
    loadParameters.motor2.PF = PF_M2;
    
    loadParameters.transformer.I = I_T1;
    loadParameters.transformer.P = P_T1;
    loadParameters.transformer.Q = Q_T1;
    loadParameters.transformer.PF = PF_T1;
end