clear;clc;
load('20Newsgroup.mat');
n = 40;
%% training selector
trIdx6 = find(y_train==6);
rand_train_6 = randperm(length(trIdx6));

trIdx8 = find(y_train==8);
rand_train_8 = randperm(length(trIdx8));

trList = [trIdx6(rand_train_6(1:n)) ; trIdx8(rand_train_8(1:n))];
x_train_6_8 = x_train(trList,:);
y_train_6_8 = y_train(trList);
 x_train_6_8=full(x_train_6_8);

%% testing selector
x_test_cropped = x_test(:,1:size(x_train,2));
x_test=x_test_cropped;
tsIdx6 = find(y_test==6);
rand_test_6 = randperm(length(tsIdx6));

tsIdx8 = find(y_test==8);
rand_test_8 = randperm(length(tsIdx8));

tsList = [tsIdx6(rand_test_6(1:n)) ; tsIdx8(rand_test_8(1:n))];
x_test_6_8 = x_test(tsList,:);
y_test_6_8 = y_test(tsList);
x_test_6_8=full(x_test_6_8);
%% classification
k_values=[1, 3, 5, 7, 9];
errTrain=zeros(1,length(k_values));
errTest=zeros(1,length(k_values));

for i = 1:length(k_values)
    YDashTrain=KNNVectorized(x_train_6_8,y_train_6_8,x_train_6_8,k_values(i));
    errTrain(i)=empiricalRisk(y_train_6_8,YDashTrain');
    
    YDashTest=KNN(x_train_6_8,y_test_6_8,x_test_6_8,k_values(i));
    errTest(i)=empiricalRisk(y_test_6_8,YDashTest');
end
%% plot data

figure;hold on;
plot(k_values,errTrain,'r*:');
plot(k_values,errTest, 'b.-');
hold off;