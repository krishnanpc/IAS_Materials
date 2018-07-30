function [MeanPredator, MeanPrey]=PredatorPreyNichePreserveDenisty(WidthOfMatrix,NumberOfIterations,MinNiche,MaxNiche)
Predators=(rand(WidthOfMatrix)>0.99);
Preys=(rand(WidthOfMatrix)>0.99);

northIndices = [WidthOfMatrix 1:WidthOfMatrix-1];
eastIndices = [2:WidthOfMatrix 1];
westIndices = [2:WidthOfMatrix 1];
southIndices = [WidthOfMatrix 1:WidthOfMatrix-1];

Predators(MinNiche:MaxNiche,MinNiche:MaxNiche)=0;

NumberOfPredators=zeros([NumberOfIterations 1]);
NumberOfPreys=zeros([NumberOfIterations 1]);

counter=1;
while counter<=NumberOfIterations
    breaking =0;
    PredatorsTempHolder=Predators;
    PreysTempHolder=Preys;
    for i=1:WidthOfMatrix
        for j=1:WidthOfMatrix         
            if PredatorsTempHolder(i,j)>=1
                RandomMatrix=round(2*rand(2)-1);
                IndexToProcessMatrix(1)=i+RandomMatrix(1,1);
                if IndexToProcessMatrix(1)==0
                    IndexToProcessMatrix(1)=WidthOfMatrix;
                end     
                if IndexToProcessMatrix(1)==(WidthOfMatrix+1)
                    IndexToProcessMatrix(1)=1;
                end 
                IndexToProcessMatrix(2)=j+RandomMatrix(1,2);
                if IndexToProcessMatrix(2)==0
                    IndexToProcessMatrix(2)=WidthOfMatrix;
                end 
                if IndexToProcessMatrix(2)==(WidthOfMatrix+1)
                    IndexToProcessMatrix(2)=1;
                end 
                if Predators(IndexToProcessMatrix(1),IndexToProcessMatrix(2))==0        
                    if(IndexToProcessMatrix(1)>=MinNiche && IndexToProcessMatrix(1)<=MaxNiche)
                        if(IndexToProcessMatrix(2)>=MinNiche && IndexToProcessMatrix(2)<=MaxNiche)
                            breaking=1;
                        end
                    end
                    if( breaking ==0)
                        Predators(i,j)=Predators(i,j)-1;
                        Predators(IndexToProcessMatrix(1),IndexToProcessMatrix(2))=Predators(IndexToProcessMatrix(1),IndexToProcessMatrix(2))+1;
                        
                    end
                end
            end         
            if PreysTempHolder(i,j)>=1  
                RandomMatrix=round(2*rand(2)-1);
                IndexToProcessMatrix(1)=i+RandomMatrix(1,1);
                if IndexToProcessMatrix(1)==0
                    IndexToProcessMatrix(1)=WidthOfMatrix;
                end     
                if IndexToProcessMatrix(1)==(WidthOfMatrix+1)
                    IndexToProcessMatrix(1)=1;
                end 
                IndexToProcessMatrix(2)=j+RandomMatrix(1,2);
                if IndexToProcessMatrix(2)==0
                    IndexToProcessMatrix(2)=WidthOfMatrix;
                end 
                if IndexToProcessMatrix(2)==(WidthOfMatrix+1)
                    IndexToProcessMatrix(2)=1;
                end 
                if Preys(IndexToProcessMatrix(1),IndexToProcessMatrix(2))==0
                    Preys(i,j)=Preys(i,j)-1;
                    Preys(IndexToProcessMatrix(1),IndexToProcessMatrix(2))=Preys(IndexToProcessMatrix(1),IndexToProcessMatrix(2))+1;
                    
                end
            end
            
        end
    end
    
    PredatorsIndecies = Predators(northIndices,:) + Predators(westIndices,:) + Predators(:,eastIndices) + Predators(:,southIndices) + ... 
        Predators(northIndices,eastIndices) + Predators(northIndices,southIndices) + Predators(westIndices,eastIndices) + Predators(westIndices,southIndices);
    PreysIndecies = Preys(northIndices,:) + Preys(westIndices,:) + Preys(:,eastIndices) + Preys(:,southIndices) + ... 
        Preys(northIndices,eastIndices) + Preys(northIndices,southIndices) + Preys(westIndices,eastIndices) + Preys(westIndices,southIndices);
    
    
    TempMat1=rand(WidthOfMatrix)>0.2;
    TempMat1(MinNiche:MaxNiche,MinNiche:MaxNiche)=0;
    
    TempMat2=rand(WidthOfMatrix)>0.75;
    TempMat2(MinNiche:MaxNiche,MinNiche:MaxNiche)=0;
    
    TempMat3=rand(WidthOfMatrix)>0.995;
    
    Predators = Predators|(Preys & (PredatorsIndecies>=1) & (TempMat1));
    Preys = Preys - ((Predators & Preys));                   
    Predators = Predators-(Predators & (PreysIndecies==0)&(TempMat2)); 
    Preys = (Preys==1)|((Preys==0) & (TempMat3));
    
    NumberOfPredators(counter)=sum(sum(Predators));
    NumberOfPreys(counter)=sum(sum(Preys));    
    counter=counter+1;
end

MeanPredator=mean(NumberOfPredators);
MeanPrey=mean(NumberOfPreys);

end

function NewInhabitantsArea=DensityPreserver(InhabitantsArea,MaxDenesity,DecreasingPercentage)
Inhabitants=find(InhabitantsArea);
AllowedInhabitedCells=(size(InhabitantsArea,1)*size(InhabitantsArea,2))*MaxDenesity;
if length(Inhabitants)>=AllowedInhabitedCells
   ToKillLength=floor(Inhabitants*DecreasingPercentage);
   ToKillInd=randperm(length(Inhabitants),ToKillLength);
   Inhabitants(ToKillInd)=0;
end
NewInhabitantsArea=Inhabitants;
end