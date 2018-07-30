clear;clc;
load('dataRidge.mat');
x_basis=x_train;
for i=2:15
    x_basis=[x_basis power(x_train,i)];
end
x_basis1=x_test;
for i=2:15
    x_basis1=[x_basis1 power(x_test,i)];
end
i=1;
figure; hold on;
for lambda=[0.0001 0.1 10]
W=RidgeLLS(x_basis,y_train,lambda);
YDash_test=x_basis1*W;
plot(W);
end

for l=-25:1
lambda=power(2,l);
W=RidgeLLS(x_basis,y_train,lambda);
YDash_test=x_basis1*W;
err(i)=lossL2(y_test,YDash_test);
i=i+1;
end
figure;
plot(1:length(err),err);
% 

