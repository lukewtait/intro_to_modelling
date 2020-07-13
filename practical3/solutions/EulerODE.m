function x = EulerODE(t,x0,f)

    % get dimensionality and number of time points
    N = length(x0) % dimensionality
    T = length(t)  % number of time points
    
    % initialize an array with size [N,T]
    x = zeros(N,T) ;
    
    % input initial conditions into x
    x(:,1) = x0 ; 
    
    % Solve using Euler method
    for i = 1:(T-1)
        
        h = t(i+1)-t(i) ; % time step
        x(:,i+1)=x(:,i)+h*f(x(:,i)) ; % calculate next step
        
    end
end
    