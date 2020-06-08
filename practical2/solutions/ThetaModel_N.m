function theta_dot = ThetaModel_N(theta,I,K,A)
N = length(theta);
A = A - diag(diag(A));
theta_dot = (1-cos(theta))+(1+cos(theta))*I + (K/N)*A*(1-cos(theta)); 