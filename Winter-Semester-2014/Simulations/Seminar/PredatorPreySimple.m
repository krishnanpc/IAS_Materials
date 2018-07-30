function [preySurvivalTimeTotal, totalPreyNumber]=PredatorPreySimple(WidthOfMatrix,NumberOfIterations)
Predators=(rand(WidthOfMatrix)>0.99); 
Preys=(rand(WidthOfMatrix)>0.99);

northIndices = [WidthOfMatrix 1:WidthOfMatrix-1];
eastIndices = [2:WidthOfMatrix 1];
westIndices = [2:WidthOfMatrix 1];
southIndices = [WidthOfMatrix 1:WidthOfMatrix-1];


totalPreyNumber=length(find(Preys));
preySurvivalTimeTotal=0;

NumberOfPredators=zeros([NumberOfIterations 1]);
NumberOfPreys=zeros([NumberOfIterations 1]);

counter=1;
while counter<=NumberOfIterations
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
                    Predators(i,j)=Predators(i,j)-1;
                    Predators(IndexToProcessMatrix(1),IndexToProcessMatrix(2))=Predators(IndexToProcessMatrix(1),IndexToProcessMatrix(2))+1;                    
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
    
    Predators = Predators|(Preys & (PredatorsIndecies>=1) & (rand(WidthOfMatrix)>0.2)); 
    Preys = Preys - ((Predators & Preys));                 
    preySurvivalTimeTotal=preySurvivalTimeTotal+length(find(Preys));
    TempX2=length(find(Preys));
    Predators = Predators-(Predators & (PreysIndecies==0)&(rand(WidthOfMatrix)>0.75));  
    Preys = (Preys==1)|((Preys==0) & (rand(WidthOfMatrix)>0.995));
    totalPreyNumber=totalPreyNumber+(length(find(Preys))-TempX2);
    
    NumberOfPredators(counter)=sum(sum(Predators));
    NumberOfPreys(counter)=sum(sum(Preys));
    counter=counter+1;
end