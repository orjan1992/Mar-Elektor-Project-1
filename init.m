par.frequency = 60; %[Hz]
par.omega = 2*pi*par.frequency; %[radians/s]
% Genset 1 and 2
par.genset1.S_n = 1125e3;   %[kVA](rated apparent loading)
par.genset1.Ra_1 = 0.0001;  %[Ohm]
par.genset1.Xs_1 = 0.5095;  %[Ohm]
par.genset1.Z_a = par.genset1.Ra_1 + par.genset1.Xs_1*1i;
par.genset2 = par.genset1;

%Genset 3
par.genset3.S_n = 538e3;    %[kVA](rated apparent loading)
par.genset3.Ra_1 = 0.0004;  %[Ohm]
par.genset3.Xs_1 = 1.0665;  %[Ohm]
par.genset3.Z_a = par.genset3.Ra_1 + par.genset3.Xs_1*1i;

%Motor 1
par.motor1.Slip = 0.02;     %[Ohm]
par.motor1.Rsm = 0.4169;    %[Ohm]
par.motor1.Xsm = 0.2429;    %[Ohm]
par.motor1.Xm = 0.0065;     %[Ohm]
par.motor1.Rc = 290;        %[Ohm]
par.motor1.R_2 = 0.023;     %[Ohm]
par.motor1.X_2 = 0.264;     %[Ohm]
par.motor1.Z_m = par.motor1.Rsm + 1i*par.motor1.Xsm + (1/par.motor1.Rc + 1/(par.motor1.Xm*1i) +1/(par.motor1.X_2*1i + par.motor1.R_2/par.motor1.Slip))^-1;

%Motor 2
par.motor2.Slip = 0.025;     %[Ohm]
par.motor2.Rsm = 0.5854;    %[Ohm]
par.motor2.Xsm = 0.7255;    %[Ohm]
par.motor2.Xm = 0.0140;     %[Ohm]
par.motor2.Rc = 325;        %[Ohm]
par.motor2.R_2 = 0.026;     %[Ohm]
par.motor2.X_2 = 0.295;     %[Ohm]
par.motor2.Z_m = par.motor2.Rsm + i*par.motor2.Xsm + (1/par.motor2.Rc + 1/(par.motor2.Xm*i) +1/(par.motor2.X_2*i + par.motor2.R_2/par.motor2.Slip))^-1;

%Transformer
par.transformer.N = 1/sqrt(3);

%Utility Load
par.utility.Z_La = 0.2984 + 0.2250i;
par.utility.Z_La_prime = par.utility.Z_La/par.transformer.N^2;
par.utility.Z_Lb = par.utility.Z_La;
par.utility.Z_Lb_prime = par.utility.Z_La_prime;
par.utility.Z_Lc = par.utility.Z_La;
par.utility.Z_Lc_prime = par.utility.Z_La_prime;
