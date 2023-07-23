% Create a noisy, exponentially decaying signal
% With a random amplitude and frequency.
% The creation of the signal has been done here and locked for editing
A = randi([1 5]);    % Amplitude bewteen 1 and 5
f = randi([50 79]);  % frequency between 50 and 79 Hz
Fs = 500;            % Sampling frequency in Hz
dt = 1/Fs;           % Sampling period
L = 512;             % Aquire 512 points
t = (0:L-1)*dt;      % Time vector
S = A*cos(2*pi*f*t) + randn(size(t));   % Signal with noise
% Plot the signal and show the frequency and amplitude
figure; plot(t,S)
title([num2str(f), ' Hz signal with amplitude = ', num2str(A)])
xlabel('Time (s)')
ylabel('Amplitude (A.U.)')

% Take the FFT and find the frequency of the peak
freq = linspace(0,(Fs/2),(L/2+1)); % Create a vector freq to map the magnitude of the FFT to. Remember that freq should start at 0 and end at Fs/2.

Y = fft(S);  % Take the Fourier Transform                   
P2 = abs(Y/L); % Calculate the magnitude                 
P1 = P2(1:L/2+1); % Take only the first half of the magnitude vector
               
P1(2:end-1) = 2*P1(2:end-1); % Double the amplitude of the single-sided spectrum (except DC component)   
[~, idx] = max(P1); % Find the index of the maximum value in the magnitude vector  
fftFrequency = freq(idx); % Find the corresponding frequency value