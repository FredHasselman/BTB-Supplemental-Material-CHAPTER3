%% Supplementary Material to "Beyond the Boundary - Chapter 3"
%
%%% Introduction
% This script can be used to recreate Figure 2 from the 3rd Chapter of Beyond the Boundary
%
% This is not a proper function or toolbox, it is not optimized for speed or functionality or aestetics! 
% Evaluate the code per Cell (using MATLAB's Cell Mode) and inspect the workspace to see what is going on.
%
% It is possible your monitor size will influence figure legibility.
%
%% Data / Toolboxes / Scripts, etc. that need to be on the MATLAB PATH
%
% * maximize.m - Bill Finger
% * export_fig - Oliver Woodfort (<http://sites.google.com/site/oliverwoodford/software/export_fig>)
% * keep.m - Minor adjustment by me to originals by Martin Barugel and Xiaoning Yang
%
% Scripts available at: https://github.com/FredHasselman/toolboxML
%
%% Author / Version
%
% Created by: <http://fredhasselman.com/?cat=9 *Fred Hasselman*> / January 2008 (1st version)
%
% Affiliations: <http://www.ru.nl/bsi _Behavioural Science Institute_> -
% <http://www.ru.nl _Radboud University Nijmegen_>
%
% Please cite if you use this code:
%
% |Hasselman, F., (2014). Beyond The Boundary - 3rd Chapter: Supplemental Materials. 
%  Retrieved from Open Science Framework, osf.io/g396c|
%
% Contact: me@fredhasselman.com

%% Safe workspace management
Now = int2str(round(now));
save([Now,'.mat'])
keep Now

%% -----------AVE----------

T = [-1 -1;1 1]';

Frq = [-1:0.1:1];
Amp = [-1:0.1:1];
FrqAmp(1,:) = Frq;
FrqAmp(2,:) = Amp;

runs=20;

net=newhop(T);
Ai = T;
[Y,Pf,Af] = sim(net,2,[],Ai);

f0=figure;
maximize(f0)

subplot(2,2,1)
hold on
count=0;
for i = 1:length(Frq)
    for k = 1:length(Amp)
        Ai = {[Frq(i) Amp(k)]'};
        [Yt,Pf,Af] = sim(net,{1 runs},{},Ai);
        count=count+1;
        eval(['Out',num2str(count),' = cell2mat(Yt);']);
        record=[cell2mat(Ai) cell2mat(Yt)];
        E(count,:) = 0.5*(sum(cell2mat(net.LW)*cell2mat(Yt)));
        Egrad(count,:) = gradient(E(count,:));
        plot(Frq(i),Amp(k),'.',record(1,:),record(2,:),'Color',[0.6 0.6 0.6],'MarkerSize',18,'MarkerEdgeColor',[0.3 0.3 0.3]);    
    end
end

plot(T(1,1),T(2,1),'sk','MarkerSize',8,'MarkerFaceColor','k'); 
hold on;
plot(T(1,2),T(2,2),'sk','MarkerSize',8,'MarkerFaceColor','k'); 
xlabel('F2 rate of frequency change (a.u.)');ylabel('F2 salience (a.u.)');
title('A.');
set(gca,'XTick',[-1 0 1]);
set(gca,'YTick',[-1 0 1]);
axis square


subplot(2,2,2);

z=[1:20];
plot(z,Egrad,'k');
xlabel('Network evaluation step');ylabel('Energy gradient');
set(gca,'YTick',[-0.2 -0.1 0 0.1 0.2]);
set(gca,'XLim',[1 20],'XTick',[1 10 20]);
title('B.');% Evolution of net energy gradient');

%% -----------DYS----------

T = [-1 -1;1 1;1 -1]';
Frq = [-1:0.1:1];
Amp = [-1:0.1:1];
FrqAmp(1,:) = Frq;
FrqAmp(2,:) = Amp;

runs=20;

net=newhop(T);
Ai = T;
[Y,Pf,Af] = sim(net,3,[],Ai);
subplot(2,2,3)
hold on
count=0;
for i = 1:length(Frq)
    for k = 1:length(Amp)
        Ai = {[Frq(i) Amp(k)]'};
        [Yt,Pf,Af] = sim(net,{1 runs},{},Ai);
        count=count+1;
        eval(['Out',num2str(count),' = cell2mat(Yt);']);
        record=[cell2mat(Ai) cell2mat(Yt)];
        E(count,:) = 0.5*(sum(cell2mat(net.LW)*cell2mat(Yt)));
        Egrad(count,:) = gradient(E(count,:));
        plot(Frq(i),Amp(k),'.',record(1,:),record(2,:),'Color',[0.6 0.6 0.6],'MarkerSize',18,'MarkerEdgeColor',[0.3 0.3 0.3]);    
    end
end

plot(T(1,1),T(2,1),'sk','MarkerSize',8,'MarkerFaceColor','k'); 
hold on;
plot(T(1,2),T(2,2),'sk','MarkerSize',8,'MarkerFaceColor','k'); 
hold on;
plot(T(1,3),T(2,3),'sk','MarkerSize',8,'MarkerFaceColor','k'); 
xlabel('F2 rate of frequency change (a.u.)');ylabel('F2 salience (a.u.)');
title('C.');% Hypothetical state space of /bAk/ and /dAk/');
set(gca,'XTick',[-1 0 1]);
set(gca,'YTick',[-1 0 1]);
axis square

subplot(2,2,4)

z=[1:20];
plot(z,Egrad,'k');
xlabel('Network evaluation step');ylabel('Energy gradient');
set(gca,'YTick',[-0.2 -0.1 0 0.1 0.2]);
set(gca,'XLim',[1 20],'XTick',[1 10 20]);

title('D.');% Evolution of net energy gradient');

%% Save the Figure to EPS for postprocessing in Adobe Illustrator
set(gcf, 'Color', 'w');
export_fig 'ch3_fig1' -eps -q101 -painters

%% Safe workspace management 
keep Now
load([Now,'.mat'])
delete([Now,'.mat'])
clear Now
