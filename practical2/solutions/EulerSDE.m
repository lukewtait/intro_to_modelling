function x=EulerSDE(t,x0,f,stdnoise)

T = numel(t);
N = numel(x0);
x = zeros(N,T);
x(:,1)=x0;

for i = 1:T-1
    h=t(i+1)-t(i);
    %x(:,i+1)=x(:,i)+h*f(x(:,i));
    x(:,i+1)=x(:,i)+h*f(x(:,i))+sqrt(h)*stdnoise.*randn(N,1);
end