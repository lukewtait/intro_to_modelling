function theta_exact = exact_solution_theta(time,theta_0,I)

theta_exact = real(1 - cos( 2*atan( sqrt(I)*tan(sqrt(I)*time + atan((1/sqrt(I))*tan(theta_0/2)))) )) ; 