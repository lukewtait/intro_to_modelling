clear; close all; clc;  % clear workspace

dt = 0.01; % time step 
time = 0:dt:20; % time axis 
theta_0 = 0; % initial condition 
stdnoise = 0.5; % standard deviation of the noise term 

% Input current: 
I = -0.5; % Task 6: change this value (e.g. -0.5, -0.1, 0.1, 0.5)

% Simulate:
disp('Simulating...')
tic 
theta=EulerSDE(time,theta_0,@(theta) ThetaModel(theta,I),stdnoise);
toc

output=1-cos(theta);

% Plot: 
figure(1)
plot(time,output)
xlabel('time','FontSize',20)
ylabel('output(\theta)','FontSize',20)
title(['I = ',num2str(I)],'FontSize',20)