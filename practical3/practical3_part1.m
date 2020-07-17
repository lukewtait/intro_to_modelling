clear, clc, close all

% Some parameters to change
coherence = 0 ; % coherence of stimulus, -100 (all dots left) to 100 (all
                  % dots right). 0 is random motion.
        
% make parameters
params = WongWang_params('c',coherence) ; 

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

% plot firing rates against time
figure(1) ; 
% plot time domain
subplot(1,2,1)
hold on
plot(t, fr1 , 'r-')
plot(t, fr2 , 'b-')
xlabel("time [ms]")
grid on
ylabel('Firing rate [Hz]')
xlim([-500 2000])
yl = ylim ; 
ylim([0 yl(2)])
plot([t(1),t(end)],repmat(params.decisionbound,1,2),'k--')
l = legend({'Population 1 (right, +coherence)','Population 2 (left, -coherence)'},'Location','best') ; 
axis square

% plot phase plane
subplot(1,2,2)
plotPhasePlane(@(x) WongWang_deterministic(0,x,params)) ;
hold on
plot(s1(t>=0), s2(t>=0), 'k','LineWidth',1)
text(s1(t==0),s2(t==0),'t=0\rightarrow','horizontalalignment','right','fontsize',8)
xlabel('S_1','color','r')
set(gca,'xcolor','r')
ylabel('S_2','color','b')  
set(gca,'ycolor','b')
title('Phase space')
ylim([0 1])
xlim([0 1])
grid on
axis square
