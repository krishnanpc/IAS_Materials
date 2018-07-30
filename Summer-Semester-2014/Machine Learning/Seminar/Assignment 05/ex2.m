clear;clc;

A=[1 -1 0;3 0 -2;-2 0 5;1 1 -8];
b=[-1;-1;-4;10];
c=[1;-2;-4];

cvx_begin
    variable x(3)
    minimize( (c')*x);
    subject to
        A*x<=b;
        x<0;
cvx_end        