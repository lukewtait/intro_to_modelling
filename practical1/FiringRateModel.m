function xdot = FiringRateModel(x,P)

% Set parameters
tau = 3.2 ; % time constant
k = 4 ; % slope of sigmoid
th = 1 ; % threshold 

% Make sigmoid functions
S = 1./(1+exp(-k*(P-th))) ; 

% Calculate xdot
xdot = (1/tau)*(-x + S) ; 

end