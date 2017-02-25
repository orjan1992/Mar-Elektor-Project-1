clear
init;

%% cases
sim =1;
switch sim
    case 1
        %Case 1.1
        par.genset1.E_tilde = 650;
        par.genset1.theta = 15*pi/180;

        par.genset2.E_tilde = par.genset1.E_tilde;
        par.genset2.theta = par.genset1.theta;

        par.genset3.E_tilde = par.genset1.E_tilde;
        par.genset3.theta = par.genset1.theta;

        CB = zeros(6, 1);
        BT = 0;
    
    case 2
        %Case 1.2
        par.genset1.E_tilde = 650;
        par.genset1.theta = 14*pi/180;

        par.genset2.E_tilde = par.genset1.E_tilde;
        par.genset2.theta = 154*pi/180;

        par.genset3.E_tilde = par.genset1.E_tilde;
        par.genset3.theta = 16.5*pi/180;

        CB = zeros(6, 1);
        BT = 0;
    
    case 3
        %Case 1.3
        par.genset1.E_tilde = 640;
        par.genset1.theta = 15*pi/180;

        par.genset2.E_tilde = 650;
        par.genset2.theta = par.genset1.theta;

        par.genset3.E_tilde = 675;
        par.genset3.theta = par.genset1.theta;  

        CB = ones(6, 1);
        BT = 1;
    case 4
        %Case 2.1
        par.genset1.E_tilde = 710;
        par.genset1.theta = 20*pi/180;

        par.genset2.E_tilde = 0;
        par.genset2.theta = par.genset1.theta;

        par.genset3.E_tilde = 696;
        par.genset3.theta = par.genset1.theta;  

        CB = [1 0 1 1 0 1];
        BT = 0;
    case 5
        %Case 2.2
        par.genset1.E_tilde = 705;
        par.genset1.theta = 20*pi/180;

        par.genset2.E_tilde = 0;
        par.genset2.theta = par.genset1.theta;

        par.genset3.E_tilde = 705;
        par.genset3.theta = par.genset1.theta;  

        CB = [1 0 1 1 0 1];
        BT = 1;
end

%% code
Z_l = load_impedance(par, CB, BT);
[V_t Z_t] = thevenin_eq(par, CB, BT);
V_n = NVA(par, CB, BT, Z_l, V_t, Z_t);
loadParameters = load_params(par, CB, BT, V_n, Z_l);
print_phasor('V_n', V_n, 'V rms');
print_phasor('V_t', V_t, 'V rms');

loadParameters.motor1.P + loadParameters.motor2.P + loadParameters.transformer.P