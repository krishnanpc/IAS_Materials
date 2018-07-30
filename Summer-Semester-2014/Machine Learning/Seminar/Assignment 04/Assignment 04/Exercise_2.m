                                                 % Assignment NO.4 Ex.2

% A///Use ClassificationDiscriminant.fit to train a LDA classifclassier for digit 2 versus 9.
%%
clear;clc;
load('usps_test.mat');  % LOADING TEST DATA
load('usps_train.mat'); % LOADING TRAIN DATA 
train_data=double(train_data);
trList = find(train_label==2 | train_label==9);  % TO FIND EVERY TRAIN LABEL THAT ==2 AND ==9 
x_train = train_data(trList,:); %TAKING ONLY IN X_TRIAN 2 AND 9 LABELES 
y_train = train_label(trList);  % AS Y_TRIAN TAKE ONLY 2 AND 9 LABELES
cls = ClassificationDiscriminant.fit(x_train,y_train);  % DEFINE THE CLASSIFER FUNCTION AS THE PREPERATION
dig2 = reshape(cls.Coeffs(2,1).Linear,16,16);           
imagesc(dig2); % PLOTING THE LEARNED WEIGHTS IN 16*16 SHAPE.
%%
%Use your learned weights(.Linear) and the constant weight(.Const) to predict labels of the test data for digits 2 and 9
%Report the 0-1 loss of your prediction and compare it with the performance of the kNN classier for k = 5.
%%
test_data =double(test_data);
tsList = find(test_label==2 | test_label==9); % ALSO DO LIKE TRIAN DATA FOR TEST DATA 
x_test = test_data(tsList,:);
y_test = test_label(tsList);
YDashLDA=x_test*cls.Coeffs(1,2).Linear + cls.Coeffs(1,2).Const;   % DEFINE THE PREDICTION FUNCTION
YDashLDA=sign(YDashLDA); % RETURN -1 AND 1 
indx2=find(YDashLDA==1); % INDEX2 TO FIND ALL 1 IN YDASHLDA
indx9=find(YDashLDA==-1);% SAME FOR INDEX9
YDashLDA(indx2)=2;
YDashLDA(indx9)=9;
lossLDA=loss01(YDashLDA,y_test); % LOSS OF THE PREDICTION FUNCTION FOR LDA
YDashKNN=knnClassify(x_train,y_train,x_test,5);  % DEFINE THE PREDICTION FUNCTION FOR KNN CLASSIFER  
lossKNN=loss01(YDashKNN,y_test); % LOSS OF THE PREDICTION FUNCTION FOR KNN
%%
% RESULT THE LOSS OF KNN IS LEAST THAN THE LOSS OF LDN.
