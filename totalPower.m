function [S_consumed S_supplied] = totalPower( BT, genParameters, loadParameters )
%TOTALPOWER Summary of this function goes here
%   Detailed explanation goes here
if BT == 0
    %open
    %% Port
    fprintf('Total consumed power on Port bus: %d\n', loadParameters.motor1.S);
    fprintf('Total supplied power on Port bus: %d\n', genParameters.genset1.S);
    S_consumed = 5;
else
    S_consumed = loadParameters.motor1.S + loadParameters.motor2.S+loadParameters.transformer.S;
    S_supplied = genParameters.genset1.S+genParameters.genset2.S+genParameters.genset3.S;
    fprintf('Total consumed power: %d\n', (loadParameters.motor1.S + loadParameters.motor2.S+loadParameters.transformer.S));
    fprintf('Total supplied power: %d\n', (genParameters.genset1.S+genParameters.genset2.S+genParameters.genset3.S));
end

