function xdot = WongWang(t,x,params)

    % get variables
    sl = x(1) ; % NMDA of left population
    sr = x(2) ; % NMDA of right population

    % get stimuli to systems
    I_mot_l = params.J_ext * (t<=params.stimtime)*(t>=0)*params.mu_0 * (1 + params.c *1. / 100) ; % left stimulus  
    I_mot_r = params.J_ext * (t<=params.stimtime)*(t>=0)*params.mu_0 * (1 - params.c *1. / 100) ; % right stimulus

    % calculate currents to each system
    I_l = params.Jll * sl - params.Jlr*sr + I_mot_l + params.I_0 ; 
    I_r = params.Jrr * sr - params.Jrl*sl + I_mot_r + params.I_0 ; 
    
    % calculate ODEs
    s1dot = -sl*1./ params.tau_s + (1 - sl) * params.gamma * params.r(I_l)  ; 
    s2dot = -sr*1./ params.tau_s + (1 - sr) * params.gamma * params.r(I_r) ; 

    xdot = [s1dot ; s2dot] ; 
end

