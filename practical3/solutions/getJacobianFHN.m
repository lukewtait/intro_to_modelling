function [J] = getJacobianFHN(ufp, wfp, eps)

J = [-ufp^2+1  -1;
     eps -eps/2];