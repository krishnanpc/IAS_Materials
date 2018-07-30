function pred = knnClassify (train_data, train_label, test_data, k)

n1 = size(train_data,1);
n2 = size(test_data,1);

XX = sum(test_data.^2,2);
YY = sum(train_data.^2,2);
XY = test_data*train_data';

distances = XX*ones(1,n1) + ones(n2,1)*YY' - 2*XY;

[~,idx] = sort(distances, 2);
idx = idx(:,1:k);

pred = mode(train_label(idx),2);