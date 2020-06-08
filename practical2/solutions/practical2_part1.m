clear; close all; clc;  % clear workspace

dt = 1; % time step % Task 3: change dt. For example, dt = 1
time = 0:dt:20; % time axis 
theta_0 = 1; % initial condition % Task 4: change theta_0. For example, use 1 and 0

% Input current: 
I = 1; 
% Task 2: replace the value of I by -0.5; and by 0.1; and by 0.5; run for
% each case
% Task 4: replace the value of I by -0.1

% Simulate:
disp('Simulating...')
tic
theta=EulerODE(time,theta_0,@(theta) ThetaModel(theta,I));
toc

output=1-cos(theta);

% Plot: 
figure(1)
plot(time,output)
xlabel('time','FontSize',20)
ylabel('output(\theta)','FontSize',20)
title(['I = ',num2str(I)],'FontSize',20)


% calculate and plot exact solution
time_exact = 0:1e-3:time(end) ; 
theta_exact = exact_solution_theta(time_exact,theta_0,I) ; 
figure(1), hold on
plot(time_exact,theta_exact,'r--')
grid on
legend({'Euler','Exact (ODE)'})