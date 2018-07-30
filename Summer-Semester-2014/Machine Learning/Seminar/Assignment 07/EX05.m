clear;clc;
load('usps_train_complete.mat');
indx=find(train_label==5);
image5=train_data(indx,:);
[V D]=PCA(image5);
Eigs=D(D>0);
Eigs=sort(Eigs,'descend');
%%
indx=find(D==Eigs(1));
[i j]=ind2sub(size(D),indx);
dig2 = reshape(V(:,j),16,16);
imagesc(dig2);

indx=find(D==Eigs(2));
[i j]=ind2sub(size(D),indx);
dig2 = reshape(V(:,j),16,16);
figure;
imagesc(dig2);

%%
mu=mean(image5);
V1=V(:,256);
r = randi(1000,3,1);
image5Projected=V1'*image5(r,:)';

Vl=V(:,255:256);
P=Vl*Vl';
Z=P*image5(r,:)'+repmat(mu',1,3);

for i=1:3
    figure;
    image1=reshape(image5(r(i),:),16,16);
    subplot(3,1,1);
    imagesc(image1);
    image2=image5Projected(i);
    subplot(3,1,2);
    imagesc(image2);
    image3=reshape(Z(:,i),16,16);
    subplot(3,1,3);
    imagesc(image3);
    
end