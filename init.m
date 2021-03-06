par.frequency = 60; %[Hz]
par.omega = 2*pi*par.frequency; %[radians/s]
%% Genset 1
par.genset1.S_n = 1125e3;   %[kVA](rated apparent loading)
par.genset1.Ra_1 = 0.0001;  %[Ohm]
par.genset1.Xs_1 = 0.5095;  %[Ohm]
par.genset1.PF = 0.8;
par.genset1.P_n = par.genset1.S_n*par.genset1.PF;
par.genset1.Q_n = par.genset1.S_n*sin(acos(par.genset1.PF));
par.genset1.Z_a = par.genset1.Ra_1 + par.genset1.Xs_1*1i;
par.genset1.E_a = par.genset1.E_tilde*cos(par.genset1.theta) + par.genset1.E_tilde*sin(par.genset1.theta)*1i;
par.genset1.E = [1; (1i)^(-4/3); (1i)^(4/3)]*par.genset1.E_a;

%% Genset 2
par.genset2.S_n = 1125e3;   %[kVA](rated apparent loading)
par.genset2.Ra_1 = 0.0001;  %[Ohm]
par.genset2.Xs_1 = 0.5095;  %[Ohm]
par.genset2.PF = 0.8;
par.genset2.P_n = par.genset2.S_n*par.genset2.PF;
par.genset2.Q_n = par.genset2.S_n*sin(acos(par.genset2.PF));
par.genset2.Z_a = par.genset2.Ra_1 + par.genset2.Xs_1*1i;
par.genset2.E_a = par.genset2.E_tilde*cos(par.genset2.theta) + par.genset2.E_tilde*sin(par.genset2.theta)*1i;
par.genset2.E = [1; (1i)^(-4/3); (1i)^(4/3)]*par.genset2.E_a;

%% Genset 3
par.genset3.S_n = 538e3;    %[kVA](rated apparent loading)
par.genset3.Ra_1 = 0.0004;  %[Ohm]
par.genset3.Xs_1 = 1.0665;  %[Ohm]
par.genset3.PF = 0.8;
par.genset3.P_n = par.genset3.S_n*par.genset3.PF;
par.genset3.Q_n = par.genset3.S_n*sin(acos(par.genset3.PF));
par.genset3.Z_a = par.genset3.Ra_1 + par.genset3.Xs_1*1i;
par.genset3.E_a = par.genset3.E_tilde*cos(par.genset3.theta) + par.genset3.E_tilde*sin(par.genset3.theta)*1i;
par.genset3.E = [1; (1i)^(-4/3); (1i)^(4/3)]*par.genset3.E_a;

%% Motor 1
par.motor1.Slip = 0.02;     %[Ohm]
par.motor1.Rsm = 0.4169;    %[Ohm]
par.motor1.Xsm = 0.2429;    %[Ohm]
par.motor1.Xm = 0.0065;     %[Ohm]
par.motor1.Rc = 290;        %[Ohm]
par.motor1.R_2 = 0.023;     %[Ohm]
par.motor1.X_2 = 0.264;     %[Ohm]
par.motor1.Z_m = par.motor1.Rsm + 1i*par.motor1.Xsm + (1/par.motor1.Rc + 1/(par.motor1.Xm*1i) +1/(par.motor1.X_2*1i + par.motor1.R_2/par.motor1.Slip))^-1;

%% Motor 2
par.motor2.Slip = 0.025;     %[Ohm]
par.motor2.Rsm = 0.5854;    %[Ohm]
par.motor2.Xsm = 0.7255;    %[Ohm]
par.motor2.Xm = 0.0140;     %[Ohm]
par.motor2.Rc = 325;        %[Ohm]
par.motor2.R_2 = 0.026;     %[Ohm]
par.motor2.X_2 = 0.295;     %[Ohm]
par.motor2.Z_m = par.motor2.Rsm + 1i*par.motor2.Xsm + (1/par.motor2.Rc + 1/(par.motor2.Xm*1i) +1/(par.motor2.X_2*1i + par.motor2.R_2/par.motor2.Slip))^-1;

%% Transformer
par.transformer.N = 1/sqrt(3);

%% Utility Load
par.utility.Z_La = 0.2984 + 0.2250i;
par.utility.Z_La_prime = par.utility.Z_La/par.transformer.N^2;
par.utility.Z_Lb = par.utility.Z_La;
par.utility.Z_Lb_prime = par.utility.Z_La_prime;
par.utility.Z_Lc = par.utility.Z_La;
par.utility.Z_Lc_prime = par.utility.Z_La_prime;