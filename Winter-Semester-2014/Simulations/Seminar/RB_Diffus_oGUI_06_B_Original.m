clear all              % Lösche alle Parameter
%close all              % Schließe alle Fenster
clc                    % Lösche alles im Kommando-Fenster

m = 101;           % Zahl der Zellen-Number of cells
nd=50000;            % Zahl der Durchläufe-Number of runs
nz=0;              % Zählvariable-Counter variable
X1 = sparse(m,m);  % Ebene der Räuber-Level of predators
X2 = sparse(m,m);  % Ebene der Beutetiere-Level of prey
X1H= sparse(m,m);  % Hilfsmatrix für X1 - Auxilarry matrix for X1
X2H= sparse(m,m);  % Hilfsmatrix für X2 - Auxilarry matrix for X2

X1=(rand(m)>0.99); % Räuber werden stochastisch erzeugt -predators are generated stochastically
X2=(rand(m)>0.99); % Beutetiere werden stochastisch erzeugt-prey are generated stochastically

[i,j] = find(X1);    % Finde Zellen mit Räubern, besetzt?-Find Occupied predators cells
[s,t] = find(X2);    % Finde Zellen mit Beutetieren, besetzt?-Find occupied prey cells

figure(gcf);         % Für die Darstellung
hold on              % Schreib in dieses Fenster

plothandle1 = plot(i,j,'.', ...    % Räuber rot, Darstellung - Predators are red
    'Color','red', ...
    'MarkerSize',12);
axis([0 m+1 0 m+1]);

plothandle2 = plot(s,t,'.', ...    % Beute blau, Darstellung - prey are blue
    'Color','blue', ...
    'MarkerSize',12);
axis([0 m+1 0 m+1]);
hold off
totalPrey=length(find(X2));
totalPredator=length(find(X1));
timePrey=0;
timePredator=0;
n = [m 1:m-1];               % Vektoren für Moore-Umgebung
e = [2:m 1];
v = [2:m 1];
w = [m 1:m-1];
%saveas(gcf, 'D:\Study\IAS\Winter 2014\Simulations\Seminar\latex-presentation\figures\Simple Movie 1\IMG00', 'png');
while nz<=nd
    % pause
    X1H=X1; % Kopieren in die Hilfsmatrix X1H, damit kein Einfluss =    durch Veränderung von X1!
    X2H=X2; % Kopieren in die Hilfsmatrix X2H, damit kein Einfluss =durch Veränderung von X2!   =20
    nz=nz+1;
    for i=1:m
        for j=1:m           %=20
            if X1H(i,j)>=1    % Räuber an Stelle(i,j)der Hilfsmatrix =X1H
                dn=round(2*rand(2)-1);
                prn(1)=i+dn(1,1);
                if prn(1)==0
                    prn(1)=m;
                end     % Period. Umgebung, =links
                if prn(1)==(m+1)
                    prn(1)=1;
                end % Period. Umgebung, =rechts
                prn(2)=j+dn(1,2);
                if prn(2)==0
                    prn(2)=m;
                end     % Period. Umgebung, =oben
                if prn(2)==(m+1)
                    prn(2)=1;
                end % Period. Umgebung, =unten
                if X1(prn(1),prn(2))==0        % Verschieben eines =Räubers
                    X1(i,j)=X1(i,j)-1;
                    X1(prn(1),prn(2))=X1(prn(1),prn(2))+1;
                    % Schreiben in X1 hat keinen Einfluss auf X1H!!
                end
            end            %=20
            if X2H(i,j)>=1  % Beutetier an Stelle (i,j)der Hilfsmatrix = X2H
                dn=round(2*rand(2)-1);
                prn(1)=i+dn(1,1);
                if prn(1)==0
                    prn(1)=m;
                end     % Period. Umgebung, =                links
                if prn(1)==(m+1)
                    prn(1)=1;
                end % Period. Umgebung, =                rechts
                prn(2)=j+dn(1,2);
                if prn(2)==0
                    prn(2)=m;
                end     % Period. Umgebung, =                oben
                if prn(2)==(m+1)
                    prn(2)=1;
                end % Period. Umgebung, =                unten
                if X2(prn(1),prn(2))==0     % Verschieben eines =                    Beutetieres
                    X2(i,j)=X2(i,j)-1;
                    X2(prn(1),prn(2))=X2(prn(1),prn(2))+1;
                    % Schreiben in X1 hat keinen Einfluss auf X2H!!
                end
            end
            %            =20
        end
    end
    
    N1 = X1(n,:) + X1(v,:) + X1(:,e) + X1(:,w) + ... % R =        Moore-Umgebung
        X1(n,e) + X1(n,w) + X1(v,e) + X1(v,w);
    N2 = X2(n,:) + X2(v,:) + X2(:,e) + X2(:,w) + ... % B =        Moore-Umgebung
        X2(n,e) + X2(n,w) + X2(v,e) + X2(v,w);
    %=20
   % TempX1= length(find(X1));
    X1 = X1|(X2 & (N1>=1) & (rand(m)>0.2));  % Räuber vermehren =    sich
    X2 = X2 - ((X1 & X2));                   % auf Kosten der Beute
    timePrey=timePrey+length(find(X2));
    TempX2=length(find(X2));
    X1 = X1-(X1 & (N2==0)&(rand(m)>0.75));   % sonst sterben =    Räuber
    X2 = (X2==1)|((X2==0) & (rand(m)>0.995));% Beute vermehrt =    sich    =20
    totalPrey=totalPrey+(length(find(X2))-TempX2);
    Erg1(nz)=sum(sum(X1));
    Erg2(nz)=sum(sum(X2));   % =20
    % Neudarstellung
    [i,j] = find(X1);    % Finde Räuber, rot                       =20
    [s,t] = find(X2);    % Finde Beute, blau    =20
    set(plothandle1,'xdata',i,'ydata',j) % Setze alte Plot-Parameter
    set(plothandle2,'xdata',s,'ydata',t) %   =20
    drawnow                              % Zeichne sofort
    %saveas(gcf,['D:\Study\IAS\Winter 2014\Simulations\Seminar\latex-presentation\figures\Simple Movie 1\IMG' num2str(nz)], 'png');
    %=20
end

figure                   % Abbildung der Summe
plot(Erg1,'-r')          % Räuber rot
hold on                  % in die gleiche Abbildung
plot(Erg2,'-b')          % Beute blau
grid on                  % Gitter für Abbildung
legend('Predators','Preys')
saveas(gcf,'D:\Study\IAS\Winter 2014\Simulations\Seminar\latex-presentation\figures\simpleImage', 'png');