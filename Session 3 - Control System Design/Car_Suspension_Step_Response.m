m = 200; % kg
b = 800; % N-s/m
k = 800; % N/m
s = tf('s');
% Use the above variables to define G, then use step() to solve for x and t:
G = (b * s + k) / (m * s^2 + b * s + k); % Transfer function for the suspension system
p1 = pole(G); % Compute poles of the transfer function
[x, t] = step(G); % Compute step response of the system

% Plotting code below:
plot(t, x, 'LineWidth', 2)
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 16) % x-axis label
ylabel('$x$', 'Interpreter', 'latex', 'FontSize', 16) % y-axis label
title('Step response of a mass-spring-damper system', 'FontSize', 16) % Title of the plot
