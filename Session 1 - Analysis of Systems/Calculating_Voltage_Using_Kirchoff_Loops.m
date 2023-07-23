% It is possible to organize the system of equations multiple ways and still arrive at the correct currents.
% A convention of positive voltages, order of coefficients, and order of loop equations
% has been prescribed in the problem statement to facilitate automated assessment.

% Voltages
V = [9; 1.5; 3]; % Volts (enter this as a column vector)

% Equation coefficients
R = [18 -2 0; -2 11 -8; 0 -8 22]; % Ohms

% Solve for current using R and V above
I = (inv(R))*V;

% calculate voltage drop across the 8 ohms resistor between nodes c and f 
Vcf = 8*(I(2)-I(3)); % units of Volts
