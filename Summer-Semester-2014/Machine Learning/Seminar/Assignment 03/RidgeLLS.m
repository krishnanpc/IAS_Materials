function W=RidgeLLS(X,Y,lambda)
[n D]=size(X);
W=(X'*Y)\(X'*X+n*lambda*eye(D));