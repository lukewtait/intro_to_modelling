function xdot = WilsonCowan(x,P)

% Set parameters
% Excitatory    % Inhibitory
tauE = 3.2;     tauI = 3.2 ; 
cEE = 2.4 ;     cIE = 2 ; 
cEI = 2 ;       cII = 0 ; 
kE = 4 ;        kI = 4 ; 
thE = 1 ;       thI = 1 ; 

% Extract firing rates of E and I populations
E = x(1) ; 
I = x(2) ; 

% Make sigmoid functions
SE = 1./(1+exp(-kE*(P+cEE*E-cIE*I-thE))) ; 
SI = 1./(1+exp(-kI*(cEI*E-cII*I-thI))) ; 

% Calculate Edot and Idot
Edot = (1/tauE)*(-E + SE) ; 
Idot = (1/tauI)*(-I + SI) ; 

% pack up to xdot
xdot = [Edot ; Idot] ; 

end
