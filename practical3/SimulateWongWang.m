clear, clc, close all

% ---------- SECTION TO EDIT FOR WORKSHEET ----------
% select which part to run
worksheet_part = 2 ; 

switch worksheet_part
    case 2 % PARAMETERS TO CHANGE FOR QUESTION 1
     
        coherence = 0 ; % coherence of stimulus (-100 to 100)
        stimulus = 0 ; % strength of stimulus (in Hz)
        
    case 3 % PARAMETERS TO CHANGE FOR QUESTION 2
        
        stimulus = 30 ; % strength of stimulus (in Hz); default 30
        nmda_ratio = 1 ; % =1 means control, <1 means degeneration/blockade of NMDA; default 1
        stimulus_time = 2000 ; % amount of time stimulus is displayed; default 2000
        simulation_time = 5000 ; % amount of time to simulate brain activity for; default 5000
        decision_boundary = 15 ; % firing rate to make a decision (in Hz); default 15
        
end

% ----------------------------------------------------

%% RUN AND PLOT SIMULATION - Do not edit beyond this point

% make parameters
switch worksheet_part 
    case 2
        params = WongWang_params('c',coherence,'mu_0',stimulus) ; 
    case 3
        params = struct ; 
        params.mu_0 = stimulus ; 
        params.nmdaratio = nmda_ratio ;
        params.stimtime = stimulus_time ; 
        params.simtime = simulation_time ; 
        params.decisionbound = decision_boundary ; 
        params = WongWang_params(params) ; 
end

% make time axis
h = 0.1 ; % time step (default 0.1ms)
t = -500:h:params.simtime ; % time axis (default -500 to 5000 ms)
x0 = [0.125;0.125;0;0] ; % initial condition, steady state in absence of stimulus

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
switch worksheet_part
    case 2
        % plot time domain
        subplot(1,2,1)
        hold on
        plot(t, fr1 , 'r-')
        plot(t, fr2 , 'b-')
        xlabel("time [ms]")
        grid on
        l = legend({'s1','s2'},'Location','best') ; 
        ylabel('Firing rate [Hz]')
        xlim([-500 2000])
        yl = ylim ; 
        ylim([0 yl(2)])
        plot([t(1),t(end)],repmat(params.decisionbound,1,2),'k--')
        axis square

        % plot phase plane
        subplot(1,2,2)
        ff = @(x) WongWang(0,[x;0;0],params) ; 
        plotPhasePlane(ff,1,0.01) ;
        hold on
        plot(s1, s2, 'k','LineWidth',1)
        xlabel('s1')
        ylabel('s2')  
        title('Phase space')
        ylim([0 1])
        xlim([0 1])
        grid on
        axis square
    case 3
        subplot(2,1,1)
        hold on
        plot(t, fr1 , 'r-')
        plot(t, fr2 , 'b-')
        xlabel("time [ms]")
        grid on
        l = legend({'s1','s2'},'Location','best') ; 
        ylabel('Firing rate [Hz]')
        xlim([-500 params.simtime])
        yl = ylim ; 
        ylim([0 yl(2)])
        plot([t(1),t(end)],repmat(params.decisionbound,1,2),'k--')

        subplot(2,1,2)
        hold on
        plot(t, params.mu_0*(t>=0).*(t<=params.stimtime),'k')
        xlabel("time [ms]")
        grid on
        ylabel('Stimulus [Hz]')
        xlim([-500 params.simtime])
        ylim([-1 params.mu_0+1])
end

