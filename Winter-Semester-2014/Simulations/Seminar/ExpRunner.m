clear all              % Lösche alle Parameter
close all              % Schließe alle Fenster
clc                    % Lösche alles im Kommando-Fenster
SavingPath='D:\Study\IAS\Winter 2014\Simulations\Seminar\';
SimplePath='Simple\';
NichePath='Niche\';
% AllMeanPredatorSimple=zeros([1000 1]);
% AllMeanPreySimple=zeros([1000 1]);
% AllMeanPredatorNiche=zeros([1000 1]);
% AllMeanPreyNiche=zeros([1000 1]);
for IteratorNumber=1:70
%     tic;
%     mkdir([SavingPath SimplePath num2str(IteratorNumber)]);
%     mkdir([SavingPath NichePath num2str(IteratorNumber)]);
    
    [TimePrey2Level, TotelPrey2Level]=PredatorPreySimple(150,500,50);
%     [TimePreyNiche, TotelPreyNiche]=PredatorPreyNichePreserveDenistyVaringRatesWithGraphs(150,500,50,100);
    
    AllTimePrey2Level(IteratorNumber)=TimePrey2Level;
    AllTotelPrey2Level(IteratorNumber)=TotelPrey2Level;
%     AllTimePreyNiche(IteratorNumber)=TimePreyNiche;
%     AllTotelPreyNiche(IteratorNumber)=TotelPreyNiche;
    
end
save('Exp.mat');

% figure                   % Abbildung der Summe
% plot(AllMeanPredatorSimple,'-r')          % Räuber rot
% hold on                  % in die gleiche Abbildung
% plot(AllMeanPreySimple,'-b')          % Beute blau
% plot(AllMeanPredatorNiche,'-g') 
% plot(AllMeanPreyNiche,'-y') 
% grid on                  % Gitter für Abbildung
