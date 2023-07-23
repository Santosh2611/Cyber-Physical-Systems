% Code to find the transfer function of the type G(s)=k/(Ts+1)
% do not change the variable names.
% The value of k is:
k=1;

% the value of T is:
T=1;
num = [T,1];
den = 1;

% The transfer function G is:
G=tf(k*num, den);