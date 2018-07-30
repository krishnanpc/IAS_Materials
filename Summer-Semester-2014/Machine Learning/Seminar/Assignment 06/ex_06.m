%%
X = [-3 3;-3 2;-2 3;-1 1;1 3;2 2;2 3;3 1];
Y = [-1 -1 -1 -1 1 1 1 1]';
d=2;
n=length(X);
C = 1;
cvx_begin
    variables w(d) b xi(n)
    dual variable lambda
    minimize 1/2*sum(w.*w) + C/n*sum(xi)
    lambda : Y.*(X*w + b) >= 1 - xi;
    xi >= 0;
cvx_end
%%
%lamda_i*(Yi * (wTX + b)  1 + ??i)
KKT=lambda'*(Y*(w'*X'+b)-1+repmat(xi,[1 8]));

%%
K = X*X';
cvx_begin
variables alpha1(n) %you don’t have anything with size d
maximize( sum(alpha1) - 0.5*quad_form(Y.*alpha1,K) )
    alpha1>=0;
    alpha1<=C/n;
    alpha1'*Y==0;
cvx_end

%%
w1=sum(alpha1'*Y*X);
b1=(1/Y-w1*X');