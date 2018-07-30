                                                              %Exercise_3 
%Implement the One vs. One strategy for LDA classier to classify digits 1, 2, 3 and 4 from USPS.data Report the test error.
%%
clear;clc;
load('usps_test_complete.mat');
load('usps_train_complete.mat');

tsList = find(test_label==1 | test_label==2 | test_label==3 | test_label==4);
test_data = test_data(tsList,:);
test_label = test_label(tsList);
classifiers={};
k=1;
for i=1:3
    for j=i+1:4
        trList = find(train_label==i | train_label==j);
        x_train = train_data(trList,:);
        y_train= train_label(trList);
        classifiers{k}=ClassificationDiscriminant.fit(x_train,y_train);
        k=k+1;
    end
end

YDashLDA=[];
for i=1:(k-1)
    YDash=sign(test_data*classifiers{i}.Coeffs(2,1).Linear + classifiers{i}.Coeffs(2,1).Const);    
    YDash(YDash==1)= classifiers{i}.ClassNames(2);
    YDash(YDash==-1)= classifiers{i}.ClassNames(1);
    YDashLDA=[YDashLDA YDash];
end

YDash=mode(YDashLDA,2);
lossLDA=loss01(YDash,test_label);
