clear;clc;
load('usps_test_complete.mat');
load('usps_train_complete.mat');

trList = find(train_label==1 | train_label==2 | train_label==3 | train_label==4);
train_data = train_data(trList,:);
train_label = train_label(trList);

tsList = find(test_label==1 | test_label==2 | test_label==3 | test_label==4);
test_data = test_data(tsList,:);
test_label = test_label(tsList);
classifiers={};

for i=1:4
x_train = train_data;
y_train = train_label;
y_train(y_train~=i)=-1;
y_train(y_train==i)=i;

classifiers{i}=ClassificationDiscriminant.fit(x_train,y_train);
end

YDashLDA1=test_data*classifiers{1}.Coeffs(2,1).Linear + classifiers{1}.Coeffs(2,1).Const;
YDashLDA2=test_data*classifiers{2}.Coeffs(2,1).Linear + classifiers{2}.Coeffs(2,1).Const;
YDashLDA3=test_data*classifiers{3}.Coeffs(2,1).Linear + classifiers{3}.Coeffs(2,1).Const;
YDashLDA4=test_data*classifiers{4}.Coeffs(2,1).Linear + classifiers{4}.Coeffs(2,1).Const;
YDashLDA=[YDashLDA1 YDashLDA2 YDashLDA3 YDashLDA4];
YDashLabels=ones(length(YDashLDA),1);

for i=1:length(YDashLDA)
    row=YDashLDA(i,:);
    maximum=max(row);
    indx=find(row==maximum);
    YDashLabels(i)=classifiers{indx}.Coeffs(2,1).Class1;
end

lossLDA=loss01(YDashLabels,test_label);