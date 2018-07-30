                                                                 %Exercise_3
% A///Implement the One vs. All strategy for LDA classier to classify digits 1, 2, 3 and 4 from USPS dataset. Report the test error.  
%%
clear;clc;
load('usps_test_complete.mat');  %LOADING OUR TEST DATA 
load('usps_train_complete.mat'); %LOADING THE TRAIN DATA
trList = find(train_label==1 | train_label==2 | train_label==3 | train_label==4); %TO FIND OUR TRAIN LABEL THAT =={1,2,3,4}
train_data = train_data(trList,:); %TAKING ONLY IN TRIAN DATA {1,2,3,4}
train_label = train_label(trList); %OUR TRIAN LABEL =={1,2,3,4}
tsList = find(test_label==1 | test_label==2 | test_label==3 | test_label==4); % DO THE SAME FOR THE TEST DATA
test_data = test_data(tsList,:);
test_label = test_label(tsList);
classifiers={};

for i=1:4         
x_train = train_data;
y_train = train_label;
y_train(y_train~=i)=-1; % IF OUR Y~=1 OR 2 OR 3 OR 4 GIVE ME IN OUTPUT -1
y_train(y_train==i)=i;  % if OUR Y=1 OR 2 OR 3 OR 4 GIVE ME IN OUTPUT 1

classifiers{i}=ClassificationDiscriminant.fit(x_train,y_train);  % RUN THE CLASSIFIER FOR EVERY i
end

YDashLDA1=test_data*classifiers{1}.Coeffs(2,1).Linear + classifiers{1}.Coeffs(2,1).Const;  % SAME AS EXERCISE 2 WE RUN OUR PREDICTION FUNCTION AND  
                                                                                            %WE HAVE ONE FOR EACH NUMBER
YDashLDA2=test_data*classifiers{2}.Coeffs(2,1).Linear + classifiers{2}.Coeffs(2,1).Const;
YDashLDA3=test_data*classifiers{3}.Coeffs(2,1).Linear + classifiers{3}.Coeffs(2,1).Const;
YDashLDA4=test_data*classifiers{4}.Coeffs(2,1).Linear + classifiers{4}.Coeffs(2,1).Const;
YDashLDA=[YDashLDA1 YDashLDA2 YDashLDA3 YDashLDA4]; % COLLECT ALL PREDICTION DATA IN ONE MATRIX
YDashLabels=ones(length(YDashLDA),1); % TO REDUCE OUR MEMORY SPACE

for i=1:length(YDashLDA) % MAKE ONE ROW COMPARING AND THEN FIND THE MAX. OF THE ROW AND CHECK THAT MAX BELONG TO WHICH CLASS AND PUT THAT NUMBER{1,2,3,4}
                         % IN OUR Y.     
    row=YDashLDA(i,:);
    maximum=max(row);
    indx=find(row==maximum);
    YDashLabels(i)=classifiers{indx}.Coeffs(2,1).Class1;
end

lossLDA=loss01(YDashLabels,test_label); % FIND THE LOSSLDA FOR OUR PREDICTION FUNCTION AND THE TEST LABEL   