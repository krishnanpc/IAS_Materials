function [V D]=PCA(Data)
mu=mean(Data,1);
mu=repmat(mu,size(Data,1),1);
Data=Data-mu;
C=Data'*Data;
[V,D] = eig(C);
end