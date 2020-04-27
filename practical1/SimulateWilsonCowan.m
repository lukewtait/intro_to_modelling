clear, close all % clear workspace

h = 1e-2 ; % time step [ms]
t = -1000:h:2000 ; % time axis, 2 seconds worth of data + 1 second that we will cut
x0 = rand(2,1) ; % random initial conditions

% choose input current
P = 0 ; 

% simulate
disp('Simulating...')
tic
x = EulerODE(t,x0,@WilsonCowan,P) ;
% --- Leave this lines commented out until task 8 --- 
% stdEnoise = 0*0.01 ; % standard deviation of noise to excitatory population
% stdInoise = 0 ; % standard deviation of noise to inhibitory population
% x = EulerSDE(t,x0,@WilsonCowan,P,[stdEnoise/3.2 ; stdInoise/3.2]) ; % we divide by 3.2 as these are the time constants
% ---------------------------------------------------
x = x(:,t>=0) ; t = t(t>=0) ; % get rid of the first 1 second as it will contain transients
toc

% plot
figure(1), clf, hold on
plot(t,x(1,:),'k')
plot(t,x(2,:),'r')
xlabel('time [ms]')
ylabel('Firing rate')
legend({'E','I'})
ylim([0 1])
grid on


% --- UNCOMMENT THESE TO CALCULATE POWER SPECTRUM FOR SDEs --- 
% xdm = x'-mean(x') ; % demean x
% [pow,f] = pwelch(xdm,[],[],[],1000/h) ; % use Welch's method for spectrum
% figure(2), hold on
% plot(f,pow(:,1),'k') ;
% plot(f,pow(:,2),'r') ;
% legend({'E','I'})
% xlim([0 100])
% xlabel('Frequency [Hz]')
% ylabel('Power')
% grid on
% -------------------------------------------------------------
