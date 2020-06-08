clear; close all; clc;  % clear workspace

dt = 0.01; % time step 
time = 0:dt:20; % time axis 
theta_0 = 1; % initial condition 

% Input current: 
I = 1; 

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


% % calculate and plot exact solution
% time_exact = 0:1e-3:time(end) ; 
% theta_exact = exact_solution_theta(time_exact,theta_0,I) ; 
% figure(1), hold on
% plot(time_exact,theta_exact,'r--')
% grid on
% legend({'Euler','Exact (ODE)'})