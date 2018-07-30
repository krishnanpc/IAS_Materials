clear all; clc;
load('usps_train.mat');
trList = find(train_label==2 | train_label==3);
x_train = double(train_data(trList,:));
y_train = double(train_label(trList));

load('usps_test.mat');
tsList = find(test_label==2 | test_label==3);
x_test = double(test_data(tsList,:));
y_test = double(test_label(tsList));

k_values=[1, 3, 5, 7, 10, 15, 20];
errTrain=zeros(1,length(k_values));
errTest=zeros(1,length(k_values));

for i = 1:length(k_values)
    YDashTrain=KNNVectorized(x_train,y_train,x_train,k_values(i));
    errTrain(i)=empiricalRisk(y_train,YDashTrain');
    
    YDashTest=KNNVectorized(x_train,y_train,x_test,k_values(i));
    errTest(i)=empiricalRisk(y_test,YDashTest');
end

figure;hold on;
plot(k_values,errTrain,'r*:');
plot(k_values,errTest, 'b.-');
hold off;
