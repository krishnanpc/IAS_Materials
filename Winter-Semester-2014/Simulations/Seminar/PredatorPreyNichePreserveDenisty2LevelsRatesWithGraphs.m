function [timePrey, totalPrey]=PredatorPreyNichePreserveDenisty2LevelsRatesWithGraphs(WidthOfMatrix,NumberOfIterations,MinNiche,MaxNiche,Level2Min,Level2Max)
%PredatorPreyNichePreserveDenistyVaringRatesWithGraphs simulates the
%predator prey eco system evolution using cellular automotan with the
%addition of having a Niche where predators cannot get into and also an
%outer niceh is to be constructed with lower ability of predators to kill
%       WidthOfMatrix: width of the cellular environment 
%       NumberOfIterations: length of simulation in iterations
%       MinNiche-MaxNiche: size of the inner niche to be constructed
%       Level2Min-Level2Max:size of the outer niche to be constructed
% 
%         <-----------------------Width----------------------------->
%         ***********************************************************
%         ***********************************************************
%         *****XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*****
%         *****XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*****
%         *****XXXXXXXXXXXXX <-------Max:Min-------->XXXXXXXXXXX*****
%         *****XXXXXXXXXXXXX                         XXXXXXXXXXX*****
%         *****XXXXXXXXXXXXX    Inner Niche          XXXXXXXXXXX*****
%         *****XXXXXXXXXXXXX    Predators cannot     XXXXXXXXXXX*****
%         *****XXXXXXXXXXXXX    get Here             XXXXXXXXXXX*****
%         *****XXXXXXXXXXXXX                         XXXXXXXXXXX*****
%         *****XXXXXXXXXXXXX                         XXXXXXXXXXX*****
%         *****XXXXXXXXXXXXX                         XXXXXXXXXXX*****
%         *****XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*****
%         *****XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*****
%         ***********************************************************
%         ***********************************************************
% 
% 
% 
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if MaxNiche > WidthOfMatrix || MinNiche < 1 || Level2Max> WidthOfMatrix ||  Level2Min < 1
    error('Niche dimensions should be within the matrix diminsions');
end
Predators=(rand(WidthOfMatrix)>0.99);
Preys=(rand(WidthOfMatrix)>0.99);

n = [WidthOfMatrix 1:WidthOfMatrix-1];
e = [2:WidthOfMatrix 1];
v = [2:WidthOfMatrix 1];
w = [WidthOfMatrix 1:WidthOfMatrix-1];

Predators(MinNiche:MaxNiche,MinNiche:MaxNiche)=0;

totalPrey=length(find(Preys));
timePrey=0;

NumberOfPredators=zeros([NumberOfIterations 1]);
NumberOfPreys=zeros([NumberOfIterations 1]);

[i,j] = find(Predators);
[s,t] = find(Preys);

figure;
hold on

plothandle1 = plot(i,j,'.', ...    % Predators are red
    'Color','red', ...
    'MarkerSize',12);
axis([0 WidthOfMatrix+1 0 WidthOfMatrix+1]);

plothandle2 = plot(s,t,'.', ...    % preys are blue
    'Color','blue', ...
    'MarkerSize',12);
axis([0 WidthOfMatrix+1 0 WidthOfMatrix+1]);

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
    
    PredatorsIndecies = Predators(n,:) + Predators(v,:) + Predators(:,e) + Predators(:,w) + ...
        Predators(n,e) + Predators(n,w) + Predators(v,e) + Predators(v,w);
    PreysIndecies = Preys(n,:) + Preys(v,:) + Preys(:,e) + Preys(:,w) + ...
        Preys(n,e) + Preys(n,w) + Preys(v,e) + Preys(v,w);
    
    
    TempMat1=rand(WidthOfMatrix)>0.2;
    T=rand(WidthOfMatrix)>0.2;
    TempMat1(Level2Min:Level2Max,Level2Min:Level2Max)=T(Level2Min:Level2Max,Level2Min:Level2Max);
    TempMat1(MinNiche:MaxNiche,MinNiche:MaxNiche)=0;
    
    TempMat2=rand(WidthOfMatrix)>0.80;
    T=rand(WidthOfMatrix)>0.75;
    TempMat2(Level2Min:Level2Max,Level2Min:Level2Max)=T(Level2Min:Level2Max,Level2Min:Level2Max);
    TempMat2(MinNiche:MaxNiche,MinNiche:MaxNiche)=0;
    
    TempMat3=rand(WidthOfMatrix)>0.95;
    T=rand(WidthOfMatrix)>0.99;
    TempMat3(Level2Min:Level2Max,Level2Min:Level2Max)=T(Level2Min:Level2Max,Level2Min:Level2Max);
    T=rand(WidthOfMatrix)>0.995;
    TempMat3(MinNiche:MaxNiche,MinNiche:MaxNiche)=T(MinNiche:MaxNiche,MinNiche:MaxNiche);
    
    Predators = Predators|(Preys & (PredatorsIndecies>=1) & (TempMat1));
    Preys = Preys - ((Predators & Preys));
    timePrey=timePrey+length(find(Preys));
    TempX2=length(find(Preys));
    Predators = Predators-(Predators & (PreysIndecies==0)&(TempMat2));
    Preys = (Preys==1)|((Preys==0) & (TempMat3));
    
    Preys(MinNiche:MaxNiche,MinNiche:MaxNiche)=DensityPreserver(Preys(MinNiche:MaxNiche,MinNiche:MaxNiche),0.8,0.2);
    totalPrey=totalPrey+(length(find(Preys))-TempX2);
    NumberOfPredators(counter)=sum(sum(Predators));
    NumberOfPreys(counter)=sum(sum(Preys));
    
    [i,j] = find(Predators);
    [s,t] = find(Preys);
    set(plothandle1,'xdata',i,'ydata',j)
    set(plothandle2,'xdata',s,'ydata',t)
    drawnow
    counter=counter+1;
end


figure
plot(NumberOfPredators,'-r')
hold on
plot(NumberOfPreys,'-b')
grid on

legend('Predators','Preys')

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