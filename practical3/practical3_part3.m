clear, clc, close all

% Choose the value of the stimulus to simulate
stimulus = 30 ; % strength of stimulus (in Hz); default 30
nmda_ratio = 1 ; % =1 means control, <1 means degeneration/blockade of NMDA; default 1

% get parameters for the Wong-Wang model, using small amount of noise
params = WongWang_params('mu_0',stimulus,'nmdaratio',nmda_ratio,'stimtime',2000) ; 

% make time axis
h = 0.1 ; % time step for Euler solver (default 0.1ms)
t = -500:h:params.simtime ; % time axis (default -500 to 5000 ms)
x0 = [0.1027;0.1027;0;0] ; % initial condition, steady state in absence of stimulus

% simulate
disp('Simulating...')
tic
X = EulerSDE(t, x0, @(t,x) WongWang(t,x,params) , params.sigma_noise/sqrt(params.tau_noise)) ; 
toc

% get synaptic currents
s1 = X(1,:) ; 
s2 = X(2,:) ; 

% calculate firing rates
rescale_to_frequency = @(s) s*1./ ((1 - s) * params.gamma * params.tau_s) ; 
fr1 = rescale_to_frequency(s1) ; 
fr2 = rescale_to_frequency(s2) ; 
frSS = rescale_to_frequency(x0(1)) ; 

% figure 1, plot simulation
figure(1)
subplot(2,1,1)
hold on
l(1) = plot(t, fr1 , 'r-') ; 
l(2) = plot(t, fr2 , 'b-') ;
ylim([0,35]) ; 
xlabel("time [ms]")
grid on
l = legend(l,{'Population 1','Population 2'},'Location','best') ; 
ylabel('Firing rate [Hz]')
xlim([t(1),t(end)])

% plot stimulus
subplot(2,1,2)
plot(t,stimulus*((t>=0)&(t<=params.stimtime)),'k')
xlabel("time [ms]")
ylabel('Stimulus [Hz]')
ylim([-0.1*stimulus , 1.1*stimulus])
xlim([t(1),t(end)])