clear;clc;
load('dataRidge.mat');
x_train_modified = [ones(size(x_train))  x_train];
x_test_modified = [ones(size(x_test))  x_test];
W=LLS(x_train_modified,y_train);
YdashTrain=W*x_train_modified';
YdashTest=W*x_test_modified';
figure;
plot(x_train,y_train,'o');
hold all;
plot(x_train,YdashTrain,'g');
plot(x_test,y_test,'x');
plot(x_test,YdashTest,'y');

%%%%%%%%%%%%%%%%%%%%%55
x_basis=[];
x_basistest=[];
xx = (-1.5:0.01:2.5)';
for i=0:15
    x_basis=[x_basis power(x_train,i)];
end
for i=0:15
    x_basistest=[x_basistest power(xx,i)];
end
W=LLS(x_basis,y_train);
YdashBasisTest=W*x_basistest';
plot(xx,YdashBasisTest,'r');

lambda = [0.0001 0.1 10];
figure; hold all;
for i = 1 : length(lambda)
    w = RidgeLLS(x_basis, y_train, lambda(i));
    y_predicted_test = (W*x_basistest')';
    plot(xx,y_predicted_test);
end
legend('Train Data', 'Predicted line', 'Test Data', 'Predicted Test Data','lambda = 0', 'lambda = 0.0001', 'lambda = 0.1', 'lambda = 10');
