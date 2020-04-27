clear, close all % clear workspace

h = 1 ; % time step (default 1ms)
t = 0:h:100 ; % time axis (default 100 ms)
x0 = 0.9 ; % initial condition

% stimulus to the system
P = 0.5 ; 

% simulate
disp('Simulating...')
tic
x = EulerODE(t,x0,@FiringRateModel,P) ; 
toc

% calculate exact solution
texact = 0:1e-3:t(end) ; 
tau = 3.2 ; k = 4 ; th = 1 ; 
xexact = (x0-1./(1+exp(-k*(P-th))))*exp(-texact/tau) + 1./(1+exp(-k*(P-th))) ; % exact solution

% plot
figure(1), hold on
plot(t,x,'k')
plot(texact,xexact,'r--')
grid on
xlabel('time')
ylabel('Population (x)')
legend({'Euler','Exact'})

% calculate root mean square error (RMSE)
RMSError = sqrt(mean((x- ((x0-1./(1+exp(-k*(P-th))))*exp(-t/tau) + 1./(1+exp(-k*(P-th)))) ).^2)) 