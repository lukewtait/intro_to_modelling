
% step 1 - implement and plot FitzHugh-Nagumo system
time = 0:0.1:200;
x_0 = [0 0];
x_sim = EulerODE(time, x_0, @(x) getFitzHughNagumo(x, 0.7));

subplot(211)
plot(time, x_sim(1,:))
ylabel('u')
subplot(212)
plot(time, x_sim(2,:))
ylabel('w')
xlabel('time')

% step 2 - interpretation of the phase plane plot
plotPhasePlane('getFitzHughNagumo')

% step 3 - finding bifurcation points
Ivec = -1:0.1:2;
e1vec = zeros(length(Ivec),1);
e2vec = zeros(length(Ivec),1);
for i = 1:length(Ivec)
    [ufp, wfp] = getFixedPointFHN(Ivec(i));
    J = getJacobianFHN(ufp, wfp, 0.1);

    ev = eig(J);
    e1vec(i) = real(ev(1));
    e2vec(i) = real(ev(2));
end

close all;
hold on
plot(Ivec, e1vec)
plot(Ivec, e2vec)
line(Ivec,[0,0])
hold off


% step 4 - observing system behaviour near bifurcation point
time = 0:0.1:200;
x_0 = [0 0];
x_sim1 = EulerODE(time, x_0, @(x) getFitzHughNagumo(x, 0.5));
x_sim2 = EulerODE(time, x_0, @(x) getFitzHughNagumo(x, 1));

hold on
subplot(221)
plot(time, x_sim1(1,:), 'm')
ylabel('u')
subplot(223)
plot(time, x_sim1(2,:), 'm')
ylabel('w')
xlabel('time')
subplot(222)
plot(time, x_sim2(1,:), 'r')
ylabel('u')
subplot(224)
plot(time, x_sim2(2,:), 'r')
ylabel('w')
xlabel('time')
hold off
