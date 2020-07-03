function [xstates] = getFitzHughNagumo(x, I, eps)
  if nargin < 2
    I      = 1;
  end
  if nargin < 3
    eps    = 0.1;
  end

  U = x(1);
  W = x(2);
  dU = U - U^3/3 - W + I;
  dW = eps*(U - 0.5 * W + 1);

  xstates = [dU; dW];
