clear;clc;
i=1;
for sigma =[0.01 0.1 0.4 0.9 1];    
    [X_train,Y_train] = genLinData(50,sigma);
    [X_test,Y_test] = genLinData(30,sigma);
    X_train = [X_train;10];
    Y_train = [Y_train;10];
    X_train=[X_train ones(length(X_train),1)];
    W=LLS(X_train,Y_train);
    X_test=[X_test ones(length(X_test),1)];
    YDash_test=X_test*W';
%     hold on ;
%     plot(YDash_test,'r*');
    err(i)=lossL2(Y_test,YDash_test);
    i=i+1;
end
mean(err)