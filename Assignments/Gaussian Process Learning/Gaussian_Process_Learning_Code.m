% Gaussian Process Learning for Regression

%% Data Generation
n = 50; % Number of data points
x = linspace(-5, 5, n)'; % Input features
y_true = sin(x) + 0.2*randn(n, 1); % True function values with noise

%% Define the kernel function (RBF kernel)
kernel = @(x1, x2, theta) exp(-0.5*(x1 - x2)'*(x1 - x2)/(theta^2));

%% Hyperparameters
theta = 1.0; % Length-scale parameter
sigma_n = 0.1; % Observation noise

%% Compute covariance matrices (Gram matrix)
K = zeros(n, n);
for i = 1:n
    for j = i:n % taking advantage of symmetry
        K(i, j) = kernel(x(i), x(j), theta);
        K(j, i) = K(i,j); % taking advantage of symmetry
    end
end

%% Add observation noise to the covariance matrix
K = K + sigma_n^2*eye(n);

%% Generate test points
n_test = 100;
x_test = linspace(-6, 6, n_test)'; % Test input features

%% Compute the predictive distribution
K_test = zeros(n_test, n);
for i = 1:n_test
    for j = 1:n % This loop can also be vectorized like above, but it doesn't affect performance much as n is small.
        K_test(i, j) = kernel(x_test(i), x(j), theta);
    end
end

K_test_test = zeros(n_test, n_test);
for i = 1:n_test
    for j = i:n_test % taking advantage of symmetry
        K_test_test(i, j) = kernel(x_test(i), x_test(j), theta);
        K_test_test(j, i) = K_test_test(i,j); % taking advantage of symmetry
    end
end

y_pred_mean = K_test*(K\y_true); % Mean prediction
y_pred_cov = K_test_test - K_test*(K\K_test'); % Covariance prediction

%% Plot the results
figure;
hold on;
plot(x, y_true, 'ko','MarkerSize', 5, 'DisplayName', 'True Function');
plot(x_test, y_pred_mean, 'r-', 'LineWidth', 2, 'DisplayName', 'Predicted Mean');
fill([x_test; flipud(x_test)], [y_pred_mean-2*sqrt(diag(y_pred_cov)); flipud(y_pred_mean+2*sqrt(diag(y_pred_cov)))], 'r', 'FaceAlpha', 0.3, 'EdgeAlpha', 0);
legend('Location', 'best');
xlabel('x');
ylabel('y');
title('Gaussian Process Regression');
hold off;
