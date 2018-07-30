clear;clc;
n=2000;
d=3;
Sigma=[2 0 0;0 1 0;0 0 4];
mu=[0,0,0];
S1 = chol(Sigma); X = repmat(mu,n,1) + randn(n,d)*S1;
X2=mvnrnd(mu,S1,n);
plot3(X(:,1),X(:,2),X(:,3),'*');
figure;plot3(X2(:,1),X2(:,2),X2(:,3),'r+');
%%
[V D]=eig(Sigma);

%%
D1=[3 0;0 1];
V1=(sqrt(2)/2)*[1 1;-1 1];
n2=400;
Sigma2=V1*D1*V1';
mu2=[0 0];
d2=2;
S1 = chol(Sigma2); X = repmat(mu2,n2,1) + randn(n2,d2)*S1;
plot(X(:,1),X(:,2),'*');
hold all;
plot([min(X(:,1)) max(X(:,1))],V1(:,1),'r');
plot([min(X(:,1)) max(X(:,1))],V1(:,2),'y');