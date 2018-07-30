function err = loss01(y_pred,y)

err = length(find(y_pred~=y))/length(y);