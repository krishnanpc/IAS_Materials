clear;clc;
[X, Y] = mixGaussian2d(100,0.4,0.6);
class1=X(Y==1,:);
class2=X(Y==2,:);
mu1=mean(class1)';
mu2=mean(class2)';
sigma1=var(class1);
sigma2=var(class2);
cov1=cov(class1);
cov2=cov(class2);
Pw1=length(find(Y==1))/length(Y);
Pw2=length(find(Y==2))/length(Y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
W1=-.5*inv(cov1);
w1=inv(cov1)*mu1;
w10=(-.5*mu1'*inv(cov1)*mu1)-(.5*log(norm(cov1)))+log(Pw1);
g1x= X*W1*X'+w1'*X+w10;