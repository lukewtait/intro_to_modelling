clear; close all; clc;  % clear workspace

dt = 0.01; % time step 
time = 0:dt:100; % time axis 
N = 5; % number of nodes in the network (i.e. oscillators) % Task 9: try N = 10
A = ones(N)-eye(N); % fully-connected network without self-loops
% A = rand(N)<0.5; % Task 10: uncomment to check random network
% A = A - diag(diag(A)); % Task 10: uncomment to check random network

K = 10; % global scaling coupling % Task 8: try K = 1, 10, 20
theta_0 = zeros(N,1); % initial condition 
stdnoise = 0.1; % standard deviation of the noise term

% Input current: 
I = -1; % Task 10: use I = -1.2

% Simulate:
disp('Simulating...')
tic 
theta=EulerSDE(time,theta_0,@(theta) ThetaModel_N(theta,I,K,A),stdnoise);
toc

output=1-cos(theta);

% Plot: 
plot_signals(output,1/dt);
xlabel('time','FontSize',20)
ylabel('output(\theta)','FontSize',20)
title(['K = ',num2str(K),', N = ',num2str(N)],'FontSize',20)
