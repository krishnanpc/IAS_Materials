clear;clc;

A1=[-1 -1;-.5 -1;-2 -1];
b1=[-4;-2;-4];
c1=[1;1];

cvx_begin
    variable x(2)
    minimize( (c1')*x);
    subject to
        A1*x<=b1;
cvx_end        


A2=[-1 -1;-1 -1;-.5 -1;-2 -1];
b2=[-2;-4;-2;-4];
c2=[1;1];

cvx_begin
    variable x(2)
    minimize( (c2')*x);
    subject to
        A2*x<=b2;
cvx_end        