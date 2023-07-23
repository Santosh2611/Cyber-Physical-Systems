% Enter the numerator and denominator coefficients as vectors here.
% IMPORTANT: DO NOT CHANGE VARIABLE NAMES
%coefficients of the numerator assigned as a vector to variable num 
% Model parameters
m = 10;   % mass in kg
b = 0.2;  % friction coefficient
num = [1]; 
%coefficients of the denominator assigned as a vector to variable den
den = [m b];
% Transfer function calculated using the numerator and denominator and assigned to the variable sys
sys = tf(num, den);