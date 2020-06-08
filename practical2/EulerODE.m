function x=EulerODE(t,x0,f)

T = numel(t);
N = numel(x0);
x = zeros(N,T);
x(:,1)=x0;

for i = 1:T-1
    h=t(i+1)-t(i);
    x(:,i+1)=x(:,i)+h*f(x(:,i));
end