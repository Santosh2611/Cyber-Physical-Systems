% Define the grid world environment
% 0 represents safe states, and 1 represents unsafe states
environment = [0, 0, 0, 0, 0;
               0, 1, 1, 0, 0;
               0, 0, 1, 0, 0;
               0, 0, 0, 0, 0];

% Define the rewards for each state
rewards = ones(size(environment)) * -0.1;
rewards(end, end) = 10; % reaching the goal state has higher reward

% Set the parameters
num_episodes = 1000; % number of training episodes
max_steps = 100; % maximum number of steps per episode
learning_rate = 0.1; % learning rate
discount_factor = 0.9; % discount factor

epsilon_initial = 1.0; % initial exploration rate
epsilon_decay = 0.99; % decay rate for exploration rate
epsilon_min = 0.05; % minimum exploration rate

max_velocity = 2; % maximum allowed velocity in each direction

% Initialize the Q-table with zeros
Q = zeros(size(environment,1), size(environment,2), 4);

% Precompute the index of the action with maximum Q-value for each state
[~, max_action] = max(Q,[],3);

% Define a logical matrix to represent safe states
safe_states = environment == 0;

% Start the training loop
for episode = 1:num_episodes
    % Reset the robot's position to the starting state
    current_state = [size(environment,1), 1];
    
    % Decay the exploration rate
    epsilon = max(epsilon_initial * epsilon_decay^episode, epsilon_min);
    
    % Loop through each step of the episode
    for step = 1:max_steps
        % Choose an action based on epsilon-greedy policy
        if rand < epsilon
            % Exploration: choose a random action
            action = randi(4);
        else
            % Exploitation: choose the action with the maximum Q-value
            action = max_action(current_state(1), current_state(2));
        end
        
        % Take the chosen action and observe the next state and reward
        next_state = perform_action(current_state, action);
        
        % Wrap around indices that go out of bounds
        next_state = mod(next_state-1,size(environment))+1;
        
        % Assign negative reward to non-safe states
        reward = -1;
        if ~safe_states(next_state(1),next_state(2))
            % If next_state is non-safe, move back to the current state
            next_state = current_state;
        else
            % If next_state is safe, assign the corresponding reward
            reward = rewards(next_state(1), next_state(2));
        end
        
        % Update the Q-value of the current state-action pair
        Q(current_state(1), current_state(2), action) = ...
            (1 - learning_rate) * Q(current_state(1), current_state(2), action) ...
            + learning_rate * (reward + discount_factor * max(Q(next_state(1), next_state(2), :)));
        
        % Update the index of the action with maximum Q-value for the new state
        [~, max_action(next_state(1), next_state(2))] = max(Q(next_state(1), next_state(2), :));
        
        % Move to the next state
        current_state = next_state;
        
        % Check if the goal state is reached
        if reward == 10
            disp('Goal reached!');
            break;
        end
    end
end

% Plot the learned Q-values for each state-action pair
figure;
for action = 1:4
    subplot(2,2,action);
    surf(squeeze(Q(:,:,action)));
    title(['Action ' num2str(action)]);
    xlabel('X');
    ylabel('Y');
end

% Compute the optimal policy as a 2D matrix of x- and y-components
optimal_policy = zeros(size(environment,1), size(environment,2), 2);
for i = 1:size(environment,1)
    for j = 1:size(environment,2)
        if environment(i,j) == 0 % Only consider safe states
            [~,idx] = max(Q(i,j,:));
            if idx == 1 % Up
                optimal_policy(i,j,:) = [-1, 0];
            elseif idx == 2 % Down
                optimal_policy(i,j,:) = [1, 0];
            elseif idx == 3 % Left
                optimal_policy(i,j,:) = [0, -2];
            else % Right
                optimal_policy(i,j,:) = [0, 2];
            end
        end
    end
end

% Plot the optimal policy as a vector field
figure;
[X,Y] = meshgrid(1:size(environment,2),1:size(environment,1));
quiver(X,Y,optimal_policy(:,:,2),optimal_policy(:,:,1),'r');
title('Optimal Policy');
xlabel('X');
ylabel('Y');
xlim([0 size(environment,2)+1]);
ylim([0 size(environment,1)+1]);

% Function to perform an action and return the next state
function next_state = perform_action(current_state, action)
    % Define the possible actions: 1 = up, 2 = down, 3 = left, 4 = right
    % Update the state based on the chosen action
    if action == 1
        next_state = [current_state(1)-1, current_state(2)];
    elseif action == 2
        next_state = [current_state(1)+1, current_state(2)];
    elseif action == 3
        next_state = [current_state(1), current_state(2)-1];
    else
        next_state = [current_state(1), current_state(2)+1];
    end
end
