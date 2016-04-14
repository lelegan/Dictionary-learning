% script to test if lars is doing ok

n=5000;
m=200;

X=0;
Y=0;

for i=1:1:n
    for j=1:1:m
        X(i,j)=normrnd(0,1);
    end
    Y(i)=rand()*15+20;
end
Y=Y';

Y=10*X(:,1)-70*X(:,2)+20*X(:,3)+25*X(:,4)+normrnd(0,200);

X=Normalize(X);
Y=zero_mean_y(Y);

%var(X)
%mean(X)
%mean(Y)

t= 100;

[beta, A, mu, gamma]=lars(X,Y,t);
[p,q]=size(beta);
sparcity=0;
for i=1:1:q
    if beta(p,i)~=0
        sparcity=sparcity+1;
    end
end

%beta
%sparcity
%norm(mu-Y)
%norm(Y)
%norm(mu-Y)/norm(Y)

for i=1:1:p
    Error(i)=norm(X*beta(i,:)'-Y);
    PercentError(i)=Error(i)/norm(Y);
end

subplot(3,1,1)
plot(beta)
subplot(3,1,2)
plot(  Error  )
subplot(3,1,3)
plot(  PercentError  )

norm(mu-X*(beta(5,:))')/norm(Y)
norm(Y-X*beta(5,:)')/norm(Y)


