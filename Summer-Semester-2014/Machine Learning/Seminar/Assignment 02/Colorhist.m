clear;clc;
%% Generate Data
n=1000;
%[X,Y] = mixGaussian1d(n,0.5,0.5,0,6,1,2);
[X,Y] = mixGaussian1d(1000,0.1,0.6,0,6,1,2);
plot(X,Y,'*');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
figure ; clf; hold all;
[countC,binsX] = hist(X,30);
PX = countC/size(X,1);
plot(binsX,PX,'.-');
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
X1=X(find(Y==1));
X2=X(find(Y==2));
[nb,xb]=hist(X1);
bh=bar(xb,nb);
set(bh,'facecolor',[0 0 1]);
hold on 
[nb1,xb1]=hist(X2);
bh1=bar(xb1,nb1);
set(bh1,'facecolor',[1 0 0]);
XT=[0; 1; 2; 2.5; 3; 4; 5];
Yt=zeros(length(XT),1);
plot(XT,Yt,'y*');
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
length(X1)/n
length(X2)/n

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Y={1,1,2,2,2,2,2}
%Y={1,2,2,2,2,2,2}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%