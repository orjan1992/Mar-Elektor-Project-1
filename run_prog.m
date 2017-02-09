clear
init;
CB = [0 0 0 0 0 0];
BT = 0;
Z_l = load_impedance(par, CB, BT);
[V_t Z_t] = thevenin_eq(par, CB, BT);
V_n = NVA(par, CB, BT);
print_phasor('V_na', V_n(1)/sqrt(2), 'V rms');
print_phasor('V_t1', V_t(1)/sqrt(2), 'V rms');
print_phasor('V_t1', V_t(1), 'V');