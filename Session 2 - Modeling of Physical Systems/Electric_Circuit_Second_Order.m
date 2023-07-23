% Given the parameters:
L=2;
R=1000;
C=1000*1e-6;
% Calculate the transfer function:
num = R/L;
den = [1 R/L];
sys = tf(num, den);