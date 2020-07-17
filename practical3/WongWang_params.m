function params = WongWang_params(varargin)

    % convert input into structure format
    params_in = varargin2struct(varargin) ; 

    % make default parameters
    params = struct ; 
    params.a = 270 ; 
    params.b = 108 ; 
    params.d = 0.154 ; 
    params.gamma = 0.641 / 1000 ; 
    params.tau_s = 100 ; % ms
    params.tau_noise = 2 ; % ms
    params.nmdaratio = 1 ; 
    params.Jll = 0.2609 ; % 0.1561
    params.Jrr = 0.2609 ; % 0.1561
    params.Jlr = 0.0497 ; % 0.0264
    params.Jrl = 0.0497 ; % 0.0264
    params.J_ext = 0.00052 ;  % 0.2243e-3
    params.I_0 = 0.3255 ; 
    params.sigma_noise = 0.007*sqrt(0.1) ; %  
    params.mu_0 = 30 ; 
    params.c = 0 ; 
    params.stimtime = inf ; 
    params.simtime = 5000 ; 
    params.decisionbound = 15 ; 

    % add custom parameters to the params structure
    vars = fieldnames(params_in);  
    for i = 1:length(vars)
        params.(vars{i}) = params_in.(vars{i}) ; 
    end

    % add the sigmoid curve
    params.r = @(I_i) (params.a*I_i - params.b)/(1 - exp(-params.d*(params.a*I_i - params.b))) ; 
    
    % update all nmda synapses
    params.Jll = params.nmdaratio*params.Jll ; 
    params.Jrr = params.nmdaratio*params.Jrr ; 
    params.Jlr = params.nmdaratio*params.Jlr ; 
    params.Jrl = params.nmdaratio*params.Jrl ; 
    params.I_0 = ((params.nmdaratio*0.000165 + 0.0005)/(0.000165+0.0005))*params.I_0 ; 


    function input = varargin2struct(input_in)
            errormsg = 'inputs must be specified as a structure or in name-value pairs' ; 
            % make input structure
            if isempty(input_in)
                input = struct ; 
            elseif isstruct(input_in)
                input = input_in ; 
            elseif iscell(input_in)
                if length(input_in)==1
                    if isstruct(input_in{1})
                        input = input_in{1} ; 
                    else
                        error(errormsg)
                    end
                elseif length(input_in)/2==floor(length(input_in)/2) ; % check even number of pairs
                    input_in = input_in(:) ; 
                    input_in = reshape(input_in,2,length(input_in)/2) ; 
                    input = struct ; 
                    for i = 1:size(input_in,2)
                        input.(input_in{1,i}) = input_in{2,i} ; 
                    end
                else
                    error(errormsg)
                end
            else
                error(errormsg)
            end
    end

end