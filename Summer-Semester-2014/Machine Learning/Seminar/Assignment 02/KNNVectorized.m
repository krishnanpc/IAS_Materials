function Ydash=KNNVectorized(TrainingSet,TrainingResponse,TestingSet,K)
%initialization of The output dataset
Ydash=zeros(1,size(TestingSet,1));
YVector=zeros([1 size(TestingSet,2) size(TestingSet,1)]); %#ok<NASGU>
YVector(1,:,:)=TestingSet';
YMatrix=repmat(YVector,[size(TrainingSet,1) 1 1]);
TrainingSetMatrix=repmat(TrainingSet,[1 1 size(TestingSet,1)]);
Distances=sqrt(sum((TrainingSetMatrix-YMatrix).^2,2));
TrainingResponse=repmat(TrainingResponse,[1 1 size(Distances,3)]);
AllResponses=[Distances TrainingResponse];

for i=1:size(TestingSet,1)
    Responses=AllResponses(:,:,i);
    SortedResponses=sortrows(Responses,1);
    Ydash(i)=mode(SortedResponses(1:K,2));
end
end