clear;clc;
load('usps_test_complete.mat');
load('usps_train_complete.mat');
trList = find(train_label==2 | train_label==9);
x_train = train_data(trList,:);
y_train = train_label(trList);

tsList = find(test_label==2 | test_label==9);
x_test = test_data(tsList,:);
y_test = test_label(tsList);


cls = ClassificationDiscriminant.fit(x_train,y_train);
dig2 = reshape(cls.Coeffs(2,1).Linear,16,16);
imagesc(dig2);

YDashLDA=x_test*cls.Coeffs(1,2).Linear + cls.Coeffs(1,2).Const;

YDashLDA=sign(YDashLDA);
indx2=find(YDashLDA==1);
indx9=find(YDashLDA==-1);
YDashLDA(indx2)=2;
YDashLDA(indx9)=9;

lossLDA=loss01(YDashLDA,y_test);
YDashKNN=knnClassify(x_train,y_train,x_test,5);
lossKNN=loss01(YDashKNN,y_test);
