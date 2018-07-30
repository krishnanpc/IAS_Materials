% Machine Learning Assignment 3 - Exercise 5
clear all; close all; clc;
load('dataRidge.mat');

% Part (a)
% Linear Regression
% Modifying the training and test data by concatenating 1 (for the constant
% b in the formula)
x_train_modified = [ones(size(x_train))  x_train];
x_test_modified = [ones(size(x_test))  x_test];
w = pinv(x_train_modified'*x_train_modified)*x_train_modified'*y_train;
y_predicted_train = (w'*x_train_modified')';
y_predicted_test = (w'*x_test_modified')';
figure(1); hold all;
plot(x_train,y_train,'o');
plot(x_train,y_predicted_train,'g');
plot(x_test,y_test,'x');
plot(x_test,y_predicted_test,'y');
legend('Train Data', 'Predicted line', 'Test Data', 'Predicted Test Data')

% Part (B)
% Constructing a polynomial basis
poly_basis_train = [];
%poly_basis_test = [];
poly_basis_test_xx = [];
xx = (-1.5:0.01:2.5)';
for i = 0 :15;
   poly_basis_train = [poly_basis_train x_train.^i];
   %poly_basis_test = [poly_basis_test x_test.^i];
   poly_basis_test_xx = [poly_basis_test_xx xx.^i];
end
w = pinv(poly_basis_train'*poly_basis_train)*poly_basis_train'*y_train;
y_predicted_test = (w'*poly_basis_test_xx')';
plot(xx,y_predicted_test);
%legend('Test Data', 'Predicted Test Data');

% Part (C)
% Ridge Regression
lambda = [0.0001 0.1 10];
for i = 1 : length(lambda)
    w = RidgeLLS(poly_basis_train, y_train, lambda(i));
    y_predicted_test = (w*poly_basis_test_xx')';
    plot(xx,y_predicted_test);
end
legend('Train Data', 'Predicted line', 'Test Data', 'Predicted Test Data','lambda = 0', 'lambda = 0.0001', 'lambda = 0.1', 'lambda = 10');

    