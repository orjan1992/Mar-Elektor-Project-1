function [ output_args ] = gen_params(  par, CB, BT, V_n, Z_ )
%GEN_PARAMS Summary of this function goes here
%   Detailed explanation goes here

%Check if Bus-tie Breaker is open
if BT == 0
    %Open
    
    %% PORT BUS
    % V_n == 0 if open => I == 0
    I_G1 = V_n(:, 1)./par.genset1.Z_a;  
    genParameters.I_neutral(1) = ones(1, 3)*(1/par.genset1.Z_a)*V_n(:, 1);
    
    %% Starboard BUS
    I_G2 = V_n(:, 2)./par.genset2.Z_a;
    I_G3 = V_n(:, 2)./par.genset3.Z_a;
end
end

