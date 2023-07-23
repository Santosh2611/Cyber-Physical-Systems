% The command below loads the following variables:
% y: vector of output data
% t: vector of corresponding times
% yss: steady-state output
load variables.mat
% Estimate the parameters of the underdamped, second-order system:

% Step 1: Calculate the damping ratio (zeta) using the overshoot obtained from stepinfo
step_info = stepinfo(y, t, yss);
zeta = -log(step_info.Overshoot / 100) / sqrt(pi^2 + log(step_info.Overshoot / 100)^2);

% Step 2: Calculate the damped natural frequency (wd) using the peak time obtained from stepinfo
wd = pi / step_info.PeakTime;

% Step 3: Calculate the natural frequency (wn) using the damping ratio (zeta)
wn = wd / sqrt(1 - zeta^2);

% Step 4: Calculate the gain (K) based on the relationship K = wn * 2.5
K = wn * 2.5;

% Display the estimated parameters
fprintf('Damping ratio (zeta): %.4f\n', zeta);
fprintf('Natural frequency (wn): %.4f rad/sec\n', wn);
fprintf('Gain (K): %.4f\n', K);