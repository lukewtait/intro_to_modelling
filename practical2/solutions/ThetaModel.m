function theta_dot = ThetaModel(theta,I)

theta_dot = (1-cos(theta))+(1+cos(theta))*I; 
