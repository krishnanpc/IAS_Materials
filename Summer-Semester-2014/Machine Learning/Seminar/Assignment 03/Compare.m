clear;clc;
load('dataRidge.mat');
tic;
x_train=[x_train ones(length(x_train),1)];
W=LLS(x_train,y_train);
x_test=[x_test ones(length(x_test),1)];
YDash_test=x_test*W;
display(toc)

clear;
tic;
load('dataRidge.mat');
ydash=KNN(x_train,y_train,x_test,5);
display(toc)