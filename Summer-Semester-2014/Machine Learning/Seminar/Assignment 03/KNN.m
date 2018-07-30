function Ydash=KNN(TrainingSet,TrainingResponse,TestingSet,K)
%initialization of The output dataset
Ydash=zeros(1,size(TestingSet,1));

for i=1:size(TestingSet,1)    
    YVector=TestingSet(i,:);
    YMatrix=repmat(YVector,size(TrainingSet,1),1);
    Distances=sqrt(sum((TrainingSet-YMatrix).^2,2));
    Responses=[Distances TrainingResponse];
    SortedResponses=sortrows(Responses,1);
    Ydash(i)=mean(SortedResponses(1:K,2));    
end
end