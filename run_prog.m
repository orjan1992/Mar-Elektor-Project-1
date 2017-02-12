clear
init;
CB = [0 0 0 0 1 0];
BT = 1;
Z_l = load_impedance(par, CB, BT);
[V_t Z_t] = thevenin_eq(par, CB, BT);
V_n = NVA(par, CB, BT, Z_l, V_t, Z_t);
load_parameters = load_params(par, CB, BT, V_n, Z_l);
print_phasor('V_n', V_n, 'V rms');
print_phasor('V_t', V_t, 'V rms');