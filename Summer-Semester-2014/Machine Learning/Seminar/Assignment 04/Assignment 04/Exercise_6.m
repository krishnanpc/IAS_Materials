clear;clc;
load('dataRidge.mat');
K=10;
testsize=length(x_train)/K;
foldsIndecies=randperm(length(x_train));
train_flods={};
y_flods={};
for i=0:(K-1)
    train_fold=x_train(foldsIndecies((i*testsize)+1:((i+1)*testsize)));
    y_fold=y_train(foldsIndecies((i*testsize)+1:((i+1)*testsize)));    
    train_flods{i+1}=train_fold;
    y_flods{i+1}=y_fold;
end
lambda=2.^(-1.*(-15:8));
for index= 1:length(lambda)
    for i=1:K
        y_train=[];
        train_data=[];
        for j=1:K
            if(i==j)
               continue;
            end
              train_data=[train_data;train_flods{j}];
              y_train=[y_train;y_flods{j}];              
        end
        w = RidgeLLS(train_data,y_train,lambda(index));
        YDash= (w'*train_flods{i});
        error(index,i)=sum((y_flods{i}-YDash).^2,1);
    end
end

 minimum=min(error(:));
 indx=find(error==minimum);
 indx=indx(1);
 [x, y]=ind2sub(size(error),indx);
 display(lambda(x));