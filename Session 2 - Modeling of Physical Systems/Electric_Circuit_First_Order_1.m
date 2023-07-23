% Enter the numerator and denominator coefficients as vectors here.
% IMPORTANT: DO NOT CHANGE VARIABLE NAMES
%coefficients of the numerator assigned as a vector to variable num 
R=1000;
C=1000e-6;
num=1;
%coefficients of the denominator assigned as a vector to variable den
den=[R*C 1];
% Transfer function calculated using the numerator and denominator and assigned to the variable sys
sys=tf(num, den)
