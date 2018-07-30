function [MeanPredator, MeanPrey]=PredatorPreyNiche(WidthOfMatrix,NumberOfIterations,MinNiche,MaxNiche,SavingPath)
Predators=(rand(WidthOfMatrix)>0.99); % Räuber werden stochastisch erzeugt -predators are generated stochastically
Preys=(rand(WidthOfMatrix)>0.99); % Beutetiere werden stochastisch erzeugt-prey are generated stochastically

n = [WidthOfMatrix 1:WidthOfMatrix-1];               % Vektoren für Moore-Umgebung
e = [2:WidthOfMatrix 1];
v = [2:WidthOfMatrix 1];
w = [WidthOfMatrix 1:WidthOfMatrix-1];

Predators(MinNiche:MaxNiche,MinNiche:MaxNiche)=0;

NumberOfPredators=zeros([NumberOfIterations 1]);
NumberOfPreys=zeros([NumberOfIterations 1]);
save([SavingPath '\Data0.mat'],'Predators','Preys','NumberOfPredators','NumberOfPreys');
counter=1;
while counter<=NumberOfIterations
    breaking =0;
    PredatorsTempHolder=Predators; % Kopieren in die Hilfsmatrix PredatorsTempHolder, damit kein Einfluss =    durch Veränderung von Predators!
    PreysTempHolder=Preys; % Kopieren in die Hilfsmatrix PreysTempHolder, damit kein Einfluss =durch Veränderung von Preys!   =20
    for i=1:WidthOfMatrix
        for j=1:WidthOfMatrix           %=20
            if PredatorsTempHolder(i,j)>=1    % Räuber an Stelle(i,j)der Hilfsmatrix =PredatorsTempHolder
                RandomMatrix=round(2*rand(2)-1);
                IndexToProcessMatrix(1)=i+RandomMatrix(1,1);
                if IndexToProcessMatrix(1)==0
                    IndexToProcessMatrix(1)=WidthOfMatrix;
                end     % Period. Umgebung, =links
                if IndexToProcessMatrix(1)==(WidthOfMatrix+1)
                    IndexToProcessMatrix(1)=1;
                end % Period. Umgebung, =rechts
                IndexToProcessMatrix(2)=j+RandomMatrix(1,2);
                if IndexToProcessMatrix(2)==0
                    IndexToProcessMatrix(2)=WidthOfMatrix;
                end     % Period. Umgebung, =oben
                if IndexToProcessMatrix(2)==(WidthOfMatrix+1)
                    IndexToProcessMatrix(2)=1;
                end % Period. Umgebung, =unten
                if Predators(IndexToProcessMatrix(1),IndexToProcessMatrix(2))==0        % Verschieben eines =Räubers
                    if(IndexToProcessMatrix(1)>=MinNiche && IndexToProcessMatrix(1)<=MaxNiche)
                        if(IndexToProcessMatrix(2)>=MinNiche && IndexToProcessMatrix(2)<=MaxNiche)
                            breaking=1;
                        end
                    end
                    if( breaking ==0)
                        Predators(i,j)=Predators(i,j)-1;
                        Predators(IndexToProcessMatrix(1),IndexToProcessMatrix(2))=Predators(IndexToProcessMatrix(1),IndexToProcessMatrix(2))+1;
                        % Schreiben in Predators hat keinen Einfluss auf PredatorsTempHolder!!
                    end
                end
            end            %=20
            if PreysTempHolder(i,j)>=1  % Beutetier an Stelle (i,j)der Hilfsmatrix = PreysTempHolder
                RandomMatrix=round(2*rand(2)-1);
                IndexToProcessMatrix(1)=i+RandomMatrix(1,1);
                if IndexToProcessMatrix(1)==0
                    IndexToProcessMatrix(1)=WidthOfMatrix;
                end     % Period. Umgebung, =                links
                if IndexToProcessMatrix(1)==(WidthOfMatrix+1)
                    IndexToProcessMatrix(1)=1;
                end % Period. Umgebung, =                rechts
                IndexToProcessMatrix(2)=j+RandomMatrix(1,2);
                if IndexToProcessMatrix(2)==0
                    IndexToProcessMatrix(2)=WidthOfMatrix;
                end     % Period. Umgebung, =                oben
                if IndexToProcessMatrix(2)==(WidthOfMatrix+1)
                    IndexToProcessMatrix(2)=1;
                end % Period. Umgebung, =                unten
                if Preys(IndexToProcessMatrix(1),IndexToProcessMatrix(2))==0     % Verschieben eines =                    Beutetieres
                    Preys(i,j)=Preys(i,j)-1;
                    Preys(IndexToProcessMatrix(1),IndexToProcessMatrix(2))=Preys(IndexToProcessMatrix(1),IndexToProcessMatrix(2))+1;
                    % Schreiben in Predators hat keinen Einfluss auf PreysTempHolder!!
                end
            end
            %            =20
        end
    end
    
    PredatorsIndecies = Predators(n,:) + Predators(v,:) + Predators(:,e) + Predators(:,w) + ... % R =        Moore-Umgebung
        Predators(n,e) + Predators(n,w) + Predators(v,e) + Predators(v,w);
    PreysIndecies = Preys(n,:) + Preys(v,:) + Preys(:,e) + Preys(:,w) + ... % B =        Moore-Umgebung
        Preys(n,e) + Preys(n,w) + Preys(v,e) + Preys(v,w);
    %=20
    
    TempMat1=rand(WidthOfMatrix)>0.2;
    TempMat1(MinNiche:MaxNiche,MinNiche:MaxNiche)=0;
    
    TempMat2=rand(WidthOfMatrix)>0.75;
    TempMat2(MinNiche:MaxNiche,MinNiche:MaxNiche)=0;
    
    TempMat3=rand(WidthOfMatrix)>0.995;
    
    Predators = Predators|(Preys & (PredatorsIndecies>=1) & (TempMat1));  % Räuber vermehren =    sich
    Preys = Preys - ((Predators & Preys));                   % auf Kosten der Beute
    Predators = Predators-(Predators & (PreysIndecies==0)&(TempMat2));   % sonst sterben =    Räuber
    Preys = (Preys==1)|((Preys==0) & (TempMat3));% Beute vermehrt =    sich    =20
    
    NumberOfPredators(counter)=sum(sum(Predators));
    NumberOfPreys(counter)=sum(sum(Preys));
    save([SavingPath '\Data' num2str(counter) '.mat'],'Predators','Preys','NumberOfPredators','NumberOfPreys');
    counter=counter+1;
end

MeanPredator=mean(NumberOfPredators);
MeanPrey=mean(NumberOfPreys);

end