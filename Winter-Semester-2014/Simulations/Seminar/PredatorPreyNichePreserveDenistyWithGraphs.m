function [MeanPredator, MeanPrey]=PredatorPreyNichePreserveDenistyWithGraphs(WidthOfMatrix,NumberOfIterations,MinNiche,MaxNiche)
Predators=(rand(WidthOfMatrix)>0.99);
Preys=(rand(WidthOfMatrix)>0.99);

n = [WidthOfMatrix 1:WidthOfMatrix-1];               
e = [2:WidthOfMatrix 1];
v = [2:WidthOfMatrix 1];
w = [WidthOfMatrix 1:WidthOfMatrix-1];

Predators(MinNiche:MaxNiche,MinNiche:MaxNiche)=0;

NumberOfPredators=zeros([NumberOfIterations 1]);
NumberOfPreys=zeros([NumberOfIterations 1]);

[i,j] = find(Predators);    % Finde Zellen mit Räubern, besetzt?-Find Occupied predators cells
[s,t] = find(Preys);    % Finde Zellen mit Beutetieren, besetzt?-Find occupied prey cells

figure;         % Für die Darstellung
hold on              % Schreib in dieses Fenster

plothandle1 = plot(i,j,'.', ...    % Räuber rot, Darstellung - Predators are red
    'Color','red', ...
    'MarkerSize',12);
axis([0 WidthOfMatrix+1 0 WidthOfMatrix+1]);

plothandle2 = plot(s,t,'.', ...    % Beute blau, Darstellung - prey are blue
    'Color','blue', ...
    'MarkerSize',12);
axis([0 WidthOfMatrix+1 0 WidthOfMatrix+1]);

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
    
    Preys(MinNiche:MaxNiche,MinNiche:MaxNiche)=DensityPreserver(Preys(MinNiche:MaxNiche,MinNiche:MaxNiche),0.8,0.2);
    
    NumberOfPredators(counter)=sum(sum(Predators));
    NumberOfPreys(counter)=sum(sum(Preys));
    % Neudarstellung
    [i,j] = find(Predators);    % Finde Zellen mit Räubern, besetzt?-Find Occupied predators cells
    [s,t] = find(Preys);    % Finde Zellen mit Beutetieren, besetzt?-Find occupied prey cells
    set(plothandle1,'xdata',i,'ydata',j) % Setze alte Plot-Parameter
    set(plothandle2,'xdata',s,'ydata',t) %   =20
    drawnow                              % Zeichne sofort
    %=20
    counter=counter+1;
end


figure                   % Abbildung der Summe
plot(NumberOfPredators,'-r')          % Räuber rot
hold on                  % in die gleiche Abbildung
plot(NumberOfPreys,'-b')          % Beute blau
grid on                  % Gitter für Abbildung

MeanPredator=mean(NumberOfPredators);
MeanPrey=mean(NumberOfPreys);

end

function NewInhabitantsArea=DensityPreserver(InhabitantsArea,MaxDenesity,DecreasingPercentage)
Inhabitants=find(InhabitantsArea);
AllowedInhabitedCells=floor((size(InhabitantsArea,1)*size(InhabitantsArea,2))*MaxDenesity);
if length(Inhabitants)>=AllowedInhabitedCells
    ToKillLength=floor(Inhabitants*DecreasingPercentage);
    ToKillInd=randperm(length(Inhabitants),ToKillLength);
    InhabitantsArea(ToKillInd)=0;
end
NewInhabitantsArea=InhabitantsArea;
end