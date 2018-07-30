function w = RidgeLLS(phiX,Y,lambda)
%INPUT:
%phiX ... design matrix
%Y ... observed values (as a column)
%lambda ... regularization parameter (>=0)
%
%OUTPUT
%w ... weight vector minimzing (1/n)*norm(Y-phiX*w)^2+lambda*norm(w)^2

n=size(phiX,1);
w=(phiX'*phiX+n*lambda*eye(size(phiX,2)))\(phiX'*Y);