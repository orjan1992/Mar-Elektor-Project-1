function [S_consumed S_supplied] = totalPower( BT, genParameters, loadParameters )
%TOTALPOWER Summary of this function goes here
%   Detailed explanation goes here
if BT == 0
    %open
    %% Port
%     S_consumed = loadParameters.motor1.S;
%     S_supplied = genParameters.genset1.S;
%     fprintf('Total consumed power: %d + %di\n', real(S_consumed), imag(S_consumed));
%     fprintf('Total supplied power: %d %di\n', real(S_supplied), imag(S_supplied));
%     fprintf('I_gen: %d +%di\nI_M: %d+%di\n', real(genParameters.genset1.I(1)), imag(genParameters.genset1.I(1)), real(loadParameters.motor1.I(1)), imag(loadParameters.motor1.I(1)));
    
    S_consumed = [loadParameters.motor1.S, (loadParameters.motor2.S + loadParameters.transformer.S)];
    S_supplied = [genParameters.genset1.S, (genParameters.genset2.S + genParameters.genset3.S)];
    fprintf('Total consumed power Port: %d + %di\n', real(S_consumed(1)), imag(S_consumed(1)));
    fprintf('Total supplied power Port: %d + %di\n', real(S_supplied(1)), imag(S_supplied(1)));
    fprintf('Total consumed power Starboard: %d + %di\n', real(S_consumed(2)), imag(S_consumed(2)));
    fprintf('Total supplied power Starboard: %d + %di\n', real(S_supplied(2)), imag(S_supplied(2)));
    fprintf('I_gen Port: %d +%di\nI_M Port: %d+%di\n', real(genParameters.genset1.I(1)), imag(genParameters.genset1.I(1)), real(loadParameters.motor1.I(1)), imag(loadParameters.motor1.I(1)));
    fprintf('I_gen Star: %d +%di\nI_M Star: %d+%di\n', real(genParameters.genset2.I(1)+genParameters.genset3.I(1)), imag(genParameters.genset2.I(1)+genParameters.genset3.I(1)), real(loadParameters.motor2.I(1)+loadParameters.transformer.I(1)), imag(loadParameters.motor2.I(1)+loadParameters.transformer.I(1)));
else
    S_consumed = loadParameters.motor1.S + loadParameters.motor2.S+loadParameters.transformer.S;
    S_supplied = genParameters.genset1.S+genParameters.genset2.S+genParameters.genset3.S;
    fprintf('Total consumed power: %d + %di\n', real(S_consumed), imag(S_consumed));
    fprintf('Total supplied power: %d %di\n', real(S_supplied), imag(S_supplied));
end

