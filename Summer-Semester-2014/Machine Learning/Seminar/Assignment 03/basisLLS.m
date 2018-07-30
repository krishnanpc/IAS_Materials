clear;clc;
load('dataRidge.mat');
x_basis=x_train;
for i=2:15
    x_basis=[x_basis power(x_train,i)];
end
W=LLS(x_basis,y_train);
xx=-1.5:0.01:2.5;
xx=xx';
x_basis1=xx;
for i=2:15
    x_basis1=[x_basis1 power(xx,i)];
end
plot(x_basis);
hold on;
plot(x_basis1);
YDash_test=x_basis1*W;
plot(YDash_test,'b+');


