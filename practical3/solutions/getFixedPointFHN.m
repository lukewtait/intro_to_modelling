function [u_fp, w_fp] = getFixedPointFHN(I)

c = [-1/3, 0, -1, (I - 2)];

pr = roots(c);

u_fp = real(pr(imag(pr)==0));
w_fp = 2. * u_fp + 2;