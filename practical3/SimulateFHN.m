clear, clc, close all

% ---------- SECTION 1 ----------

% parameters needed to run the model
time = 0:0.1:200;
x_0 = [0 0];
epsilon = 0.1;

I_0 = 0. ; %Input current
funcFHN = @(x) getFitzHughNagumo(x, I_0);

x_sim = EulerODE(time, x_0, @(x) funcFHN);

subplot(221)
plot(time, x_sim(1,:))
ylabel('u')
subplot(222)
plot(time, x_sim(2,:))
ylabel('w')
xlabel('time')
subplot(2,2,[3,4])
plotPhasePlane(funcFHN)

% --------------------------------

% ---------- SECTION 2 ----------

Ivec = -1:0.1:2;
e1vec = zeros(length(Ivec),1);
e2vec = zeros(length(Ivec),1);
for i = 1:length(Ivec)
    % this computes fixed points of FitzHugh-Nagumo model
    [ufp, wfp] = getFixedPointFHN(Ivec(i));
    % TODO implement getJacobianFHN function
    J = getJacobianFHN(ufp, wfp, epsilon);
    % TODO compute eigenvalues of the jacobian J    
    ev = ... ;
    e1vec(i) = real(ev(1));
    e2vec(i) = real(ev(2));
end

close all;
hold on
plot(Ivec, e1vec)
plot(Ivec, e2vec)
line(Ivec,[0,0])
hold off

% --------------------------------

% ---------- SECTION 3 -----------

I_0_below = ...;
I_0_above = ...;

funcFHN_bel = @(x) getFitzHughNagumo(x, I_0_below);
funcFHN_abv = @(x) getFitzHughNagumo(x, I_0_above);

x_sim_bel = EulerODE(time, x_0, funcFHN_bel);
x_sim_abv = EulerODE(time, x_0, funcFHN_abv);

hold on
subplot(221)
plot(time, x_sim_bel(1,:), 'm')
title('BELOW');
ylabel('u');
subplot(223)
plot(time, x_sim_bel(2,:), 'm')
ylabel('w');
xlabel('time');
subplot(222)
plot(time, x_sim_abv(1,:), 'r')
title('ABOVE');
ylabel('u');
subplot(224)
plot(time, x_sim_abv(2,:), 'r')
ylabel('w');
xlabel('time');
hold off

% --------------------------------