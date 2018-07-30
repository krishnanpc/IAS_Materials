clear;clc;
load('cancer_data2014.mat');
[n d]=size(input_train);
target_train=diag(target_train);
C =[.01; 0.1; 0.5; 1; 5; 10; 50];

for i=1:length(C)
    cvx_begin
    variables w(d) b(1) epsi(n)
    minimize(.5*(w'*w)+(C(i)/n)*sum(epsi(:)));
    subject to
        target_train*(input_train*w+ ones(n,1)*b)>=ones(n,1)-epsi;
        epsi>=0;
    cvx_end;
    YDash=sign(input_test*w+b);
    error(i)=loss01(target_test,YDash);
end

plot(C,error);