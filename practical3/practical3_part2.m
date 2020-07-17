clear, clc, close all

% Choose the value of the stimulus to simulate
stimulus = 30 ; 

% get parameters for the Wong-Wang model, using small amount of noise
params = WongWang_params('mu_0',stimulus) ; 

% make time axis
h = 0.1 ; % time step (default 0.1ms)
t = 0:h:params.simtime ; % time axis

% Find the 'undecided'/symmetric steady state, and calculate its eigenvalues 
% Here we use the 'fsolve' function, which finds where a set of equations
% equal zero. Since steady states are given by xdot=0, we can use this to
% find the steady states. fsolve also estimates the Jacobian matrix as the
% 5th output, so we can get the eigenvalues from this using the 'eig'
% function.
options = optimset('Display','off','TolFun',1e-12) ; % options for solver
[x0,~,~,~,J] = fsolve(@(x) WongWang_deterministic(0,x,params),[0.1;0.1],options) ; % solve initial conditions
lambda = eig(J) ; % get eigenvalues of Jacobian

% simulate
fprintf('Simulating, stimulus = %d Hz...',stimulus)
tic
X = EulerSDE(t, [x0;0;0] , @(t,x) WongWang(t,x,params) , params.sigma_noise/sqrt(params.tau_noise)) ; 
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
hold on
l(1) = plot(t, fr1 , 'r-') ; 
l(2) = plot(t, fr2 , 'b-') ;
l(3) = plot(t,repmat(frSS,1,length(t)),'k') ; 
ylim([0,35]) ; 
xlabel("time [ms]")
grid on
l = legend(l,{'Population 1','Population 2','Symmetric steady state'},'Location','best') ; 
ylabel('Firing rate [Hz]')
xlim([0 5000])

% output eigenvalues
disp('Symmetric steady state eigenvalues (i.e. gradient in each "direction"): ')
fprintf('   lambda1 = %.4f\n',lambda(1))
fprintf('   lambda2 = %.4f\n',lambda(2))

% ------ Leave commented until question 3 ---------------------------------
% stim_vec = 0:30 ; 
% x0 = [0.1;0.1] ; 
% clear lambda
% for i = 1:length(stim_vec)
%     
%     % get parameters for the Wong-Wang model
%     params = WongWang_params('mu_0',stim_vec(i)) ; 
% 
%     % find steady state and Jacobian
%     [x0,~,~,~,J] = fsolve(@(x) WongWang_deterministic(0,x,params),x0,options) ; 
%     
%     % find eigenvalues of Jacobian
%     lambda(i,:) = sort(eig(J)) ; 
% end
% 
% figure(2)
% plot(stim_vec,lambda)
% hold on
% plot([stim_vec(1),stim_vec(end)],[0,0],'k--')
% legend({'\lambda_1','\lambda_2'})
% ylabel('\lambda')
% xlabel('stimulus [Hz]')
% -------------------------------------------------------------------------