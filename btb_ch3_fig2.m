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
%% Toolboxes / Scripts used
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
% Please quote if you use this code:
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

Frq = [-1:0.05:1];
Amp = [-1:0.05:1];
FrqAmp(1,:) = Frq;
FrqAmp(2,:) = Amp;

runs=5;
stop=runs-1;

net=newhop(T);
Ai = T;
[Y,Pf,Af] = sim(net,2,[],Ai);

count=0;
for i = 1:length(Frq)
    for k = 1:length(Amp)
        Ai = {[Frq(i) Amp(k)]'};
        [Yt,Pf,Af] = sim(net,{1 runs},{},Ai);
        count=count+1;
        E1(count,:) = 0.5*(sum(cell2mat(net.LW)*cell2mat(Yt)));
        EGrad1(count,:) = diff(E1(count,:));
    end
end

count = 0;
for k=1:length(Frq)
    for m=1:length(Amp)
        count=count+1;
        Emean = mean(E1(count,[1:stop]));
        E(k,m)=Emean;
        EGrad(k,m) = EGrad1(count,stop);
    end     
end


f0=figure;
maximize(f0)

subplot(2,2,1);
[C,p]=contourf(abs(EGrad),30);
hold on;
set(p,'EdgeColor','none');
set(gca,'XLim',[1 41],'XTick',[1 21 41],'XTickLabel',[-1 0 1],'YLim',[1 41],'YTick',[1 21 41],'YTickLabel',[-1 0 1]);
xlabel('F2 rate of frequency change (a.u.)');ylabel('F2 salience (a.u.)');
title('A.'); 
colormap gray;
cbar = colorbar;
ctick = get(cbar,'YLim');
set(cbar,'YTick',[0.005 max(ctick)-0.005],'YTickLabel',{'No E change' 'Large E change'});

%Sample points from Energy gradient values
ExtraPoints = 2;
SlowMan = 11;
AmpMan = 11;

FreqBakNorm = 5;
AmpBakNorm = 5;
FreqDakNorm = 36;
AmpDakNorm = 25;

FreqBakSlow = FreqBakNorm+SlowMan;
AmpBakSlow = AmpBakNorm;
FreqDakSlow = FreqDakNorm-SlowMan;
AmpDakSlow = AmpDakNorm;

FreqBakAmp = FreqBakNorm;
AmpBakAmp = AmpBakNorm;
FreqDakAmp = FreqDakNorm;
AmpDakAmp = AmpDakNorm+AmpMan;

FreqBakBoth = FreqBakNorm+SlowMan;
AmpBakBoth = AmpBakNorm;
FreqDakBoth = FreqDakNorm-SlowMan;
AmpDakBoth = AmpDakNorm+AmpMan;

rectangle('Position',[FreqBakNorm-(ExtraPoints+.5),AmpBakNorm-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle','-','EdgeColor',[0.6 0.6 0.6],'Linewidth',2) ;
rectangle('Position',[FreqDakNorm-(ExtraPoints+.5),AmpDakNorm-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle','-','EdgeColor',[0.6 0.6 0.6],'Linewidth',2);
rectangle('Position',[FreqBakSlow-(ExtraPoints+.5),AmpBakSlow-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle',':','EdgeColor',[0.3 0.3 0.3],'Linewidth',2) ;
rectangle('Position',[FreqDakSlow-(ExtraPoints+.5),AmpDakSlow-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle',':','EdgeColor',[0.3 0.3 0.3],'Linewidth',2);
rectangle('Position',[FreqBakAmp-(ExtraPoints+.1),AmpBakAmp-(ExtraPoints+.1),ExtraPoints*2.6,ExtraPoints*2.6],'LineStyle','--','EdgeColor',[0.5 0.5 0.5],'Linewidth',2) ;
rectangle('Position',[FreqDakAmp-(ExtraPoints+.5),AmpDakAmp-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle','--','EdgeColor',[0.5 0.5 0.5],'Linewidth',2);
rectangle('Position',[FreqBakBoth-(ExtraPoints+.1),AmpBakBoth-(ExtraPoints+.1),ExtraPoints*2.6,ExtraPoints*2.6],'LineStyle','-.','EdgeColor',[0.7 0.7 0.7],'Linewidth',2) ;
rectangle('Position',[FreqDakBoth-(ExtraPoints+.5),AmpDakBoth-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle','-.','EdgeColor',[0.7 0.7 0.7],'Linewidth',2);

p1=plot([FreqBakNorm-0.9],[AmpBakNorm+0.5]','o-','Color',[0.6 0.6 0.6],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.6 0.6 0.6]); %,'MarkerEdgeColor','k');
p2=plot([FreqBakSlow-0.9],[AmpBakSlow+0.5],'v:','Color',[0.3 0.3 0.3],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.3 0.3 0.3]); %,'MarkerEdgeColor','k');
p3=plot([FreqBakAmp+1.5],[AmpBakAmp+0.5],'^--','Color',[0.5 0.5 0.5],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.5 0.5 0.5]); %,'MarkerEdgeColor','k');
p4=plot([FreqBakBoth+1.5],[AmpBakBoth+0.5],'d-.','Color',[0.7 0.7 0.7],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.7 0.7 0.7]); %,'MarkerEdgeColor','k');
legend([p1,p2,p3,p4],'None','Slowed Down','Amplified','Both',2);
plot([FreqDakNorm+0.5],[AmpDakNorm+0.5]','o:','Color',[0.6 0.6 0.6],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.6 0.6 0.6]); %,'MarkerEdgeColor','k'); 
plot([FreqDakSlow+0.5],[AmpDakSlow+0.5],'v-','Color',[0.3 0.3 0.3],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.3 0.3 0.3]); %,'MarkerEdgeColor','k');
plot([FreqDakAmp+0.5],[AmpDakAmp+0.5],'^--','Color',[0.5 0.5 0.5],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.5 0.5 0.5]); %,'MarkerEdgeColor','k');
plot([FreqDakBoth+0.5],[AmpDakBoth+0.5],'d-.','Color',[0.7 0.7 0.7],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.7 0.7 0.7]); %,'MarkerEdgeColor','k');
axis square

subplot(2,2,2);

%Sums of squares of SD Data from experiment (see ch2_fratios.xls)
av = [90859.8 86758.57 5568.2 98789.3];
 
BakNorm = (abs(EGrad([FreqBakNorm-ExtraPoints : FreqBakNorm+ExtraPoints],[AmpBakNorm-ExtraPoints : AmpBakNorm+ExtraPoints])));
DakNorm = (abs(EGrad([FreqDakNorm-ExtraPoints : FreqDakNorm+ExtraPoints],[AmpDakNorm-ExtraPoints : AmpDakNorm+ExtraPoints])));
count =0;
for i = 1:length(BakNorm)
    for j= length(DakNorm)
        count = count+1;
        Tempb(count)=BakNorm(i,j);
        Tempd(count)=DakNorm(i,j);
    end
end
Normb = mean(Tempb);
Normd = mean(Tempd);
Norm = std([Normb Normd]);


BakSlow = (abs(EGrad([FreqBakSlow-ExtraPoints : FreqBakSlow+ExtraPoints],[AmpBakSlow-ExtraPoints : AmpBakSlow+ExtraPoints])));
DakSlow = (abs(EGrad([FreqDakSlow-ExtraPoints : FreqDakSlow+ExtraPoints],[AmpDakSlow-ExtraPoints : AmpDakSlow+ExtraPoints])));
count =0;
for i = 1:length(BakNorm)
    for j= length(DakNorm)
        count = count+1;
        Tempb(count)=BakSlow(i,j);
        Tempd(count)=DakSlow(i,j);
    end
end
Slowb = mean(Tempb);
Slowd = mean(Tempd);
Slow = std([Tempb Tempd]);

BakAmp = (abs(EGrad([FreqBakAmp-ExtraPoints : FreqBakAmp+ExtraPoints],[AmpBakAmp-ExtraPoints : AmpBakAmp+ExtraPoints])));
DakAmp = (abs(EGrad([FreqDakAmp-ExtraPoints : FreqDakAmp+ExtraPoints],[AmpDakAmp-ExtraPoints : AmpDakAmp+ExtraPoints])));
count =0;
for i = 1:length(BakNorm)
    for j= length(DakNorm)
        count = count+1;
        Tempb(count)=BakAmp(i,j);
        Tempd(count)=DakAmp(i,j);
    end
end
Ampb = mean(Tempb);
Ampd = mean(Tempd);
Amp = std([Tempb Tempd]);

BakBoth = (abs(EGrad([FreqBakBoth-ExtraPoints : FreqBakBoth+ExtraPoints],[AmpBakBoth-ExtraPoints : AmpBakBoth+ExtraPoints])));
DakBoth = (abs(EGrad([FreqDakBoth-ExtraPoints : FreqDakBoth+ExtraPoints],[AmpDakBoth-ExtraPoints : AmpDakBoth+ExtraPoints])));
count =0;
for i = 1:length(BakNorm)
    for j= length(DakNorm)
        count = count+1;
        Tempb(count)=BakBoth(i,j);
        Tempd(count)=DakBoth(i,j);
    end
end
Bothb = mean(Tempb);
Bothd = mean(Tempd);
Both = std([Bothb Bothd]);

Model = [Norm Slow Amp Both];
Model = Model - min(Model);
Model_unit = Model./max(Model);

Avunit = av-min(av);
Av_unit = Avunit./max(Avunit);

x=[1:1:length(av)];
plot(x,Av_unit,'-k',x,Model_unit,':k');
set(gca,'XLim',[0.8 4.2],'XTick',[1 2 3 4],'XTickLabel',{'None';'Slowed Down';'Amplified';'Both'});
set(gca,'YLim',[-0.2 1.2],'YTick',[0 0.5 1]);
legend('Average Readers','Network 2MEM',3);
hold on;
plot(x(1),Av_unit(1),'o:','Color',[0.6 0.6 0.6],'Linewidth',2,'MarkerSize',6);
plot(x(2),Av_unit(2),'v-','Color',[0.3 0.3 0.3],'Linewidth',2,'MarkerSize',6);
plot(x(3),Av_unit(3),'^--','Color',[0.5 0.5 0.5],'Linewidth',2,'MarkerSize',6);
plot(x(4),Av_unit(4),'d-.','Color',[0.7 0.7 0.7],'Linewidth',2,'MarkerSize',6);
hold on;
plot(x(1),Model_unit(1),'o:','Color',[0.6 0.6 0.6],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.6 0.6 0.6]); %,'MarkerEdgeColor','k');
plot(x(2),Model_unit(2),'v-','Color',[0.3 0.3 0.3],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.3 0.3 0.3]); %,'MarkerEdgeColor','k');
plot(x(3),Model_unit(3),'^--','Color',[0.5 0.5 0.5],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.5 0.5 0.5]); %,'MarkerEdgeColor','k');
plot(x(4),Model_unit(4),'d-.','Color',[0.7 0.7 0.7],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.7 0.7 0.7]); %,'MarkerEdgeColor','k');
title('B.'); 
ylabel('Experiment SD / Energy SD (unit scale)');
xlabel('Manipulation');

%%
keep Now 

%% -----------DYS----------

T = [-1 -1;1 1;1 -1]';

Frq = [-1:0.05:1];
Amp = [-1:0.05:1];
FrqAmp(1,:) = Frq;
FrqAmp(2,:) = Amp;

runs=10;
stop=runs-1;

net=newhop(T);
Ai = T;
[Y,Pf,Af] = sim(net,3,[],Ai);

count=0;
for i = 1:length(Frq)
    for k = 1:length(Amp)
        Ai = {[Frq(i) Amp(k)]'};
        [Yt,Pf,Af] = sim(net,{1 runs},{},Ai);
        count=count+1;
        E1(count,:) = 0.5*(sum(cell2mat(net.LW)*cell2mat(Yt)));
        EGrad1(count,:) = diff(E1(count,:));
    end
end

count = 0;
for k=1:length(Frq)
    for m=1:length(Amp)
        count=count+1;
        Emean = mean(E1(count,[1:stop]));
        E(k,m)=Emean;
        EGrad(k,m) = EGrad1(count,stop); 
    end     
end
subplot(2,2,3);
[C,p]=contourf((abs(EGrad)),30);
hold on;
set(p,'EdgeColor','none');
set(gca,'XLim',[1 41],'XTick',[1 21 41],'XTickLabel',[-1 0 1],'YLim',[1 41],'YTick',[1 21 41],'YTickLabel',[-1 0 1]);
xlabel('F2 rate of frequency change (a.u.)');ylabel('F2 salience (a.u.)');
title('C.'); 
colormap gray;
cbar = colorbar;
ctick = get(cbar,'YLim');
set(cbar,'YTick',[0.005 max(ctick)-0.005],'YTickLabel',{'No E change' 'Large E change'});

%Sample points from Energy gradient values
ExtraPoints = 2;
SlowMan = 11;
AmpMan = 11;

FreqBakNorm = 5;
AmpBakNorm = 5;
FreqDakNorm = 36;
AmpDakNorm = 25;

FreqBakSlow = FreqBakNorm+SlowMan;
AmpBakSlow = AmpBakNorm;
FreqDakSlow = FreqDakNorm-SlowMan;
AmpDakSlow = AmpDakNorm;

FreqBakAmp = FreqBakNorm;
AmpBakAmp = AmpBakNorm;
FreqDakAmp = FreqDakNorm;
AmpDakAmp = AmpDakNorm+AmpMan;

FreqBakBoth = FreqBakNorm+SlowMan;
AmpBakBoth = AmpBakNorm;
FreqDakBoth = FreqDakNorm-SlowMan;
AmpDakBoth = AmpDakNorm+AmpMan;

rectangle('Position',[FreqBakNorm-(ExtraPoints+.5),AmpBakNorm-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle','-','EdgeColor',[0.6 0.6 0.6],'Linewidth',2) ;
rectangle('Position',[FreqDakNorm-(ExtraPoints+.5),AmpDakNorm-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle','-','EdgeColor',[0.6 0.6 0.6],'Linewidth',2);
rectangle('Position',[FreqBakSlow-(ExtraPoints+.5),AmpBakSlow-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle',':','EdgeColor',[0.3 0.3 0.3],'Linewidth',2) ;
rectangle('Position',[FreqDakSlow-(ExtraPoints+.5),AmpDakSlow-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle',':','EdgeColor',[0.3 0.3 0.3],'Linewidth',2);
rectangle('Position',[FreqBakAmp-(ExtraPoints+.1),AmpBakAmp-(ExtraPoints+.1),ExtraPoints*2.6,ExtraPoints*2.6],'LineStyle','--','EdgeColor',[0.5 0.5 0.5],'Linewidth',2) ;
rectangle('Position',[FreqDakAmp-(ExtraPoints+.5),AmpDakAmp-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle','--','EdgeColor',[0.5 0.5 0.5],'Linewidth',2);
rectangle('Position',[FreqBakBoth-(ExtraPoints+.1),AmpBakBoth-(ExtraPoints+.1),ExtraPoints*2.6,ExtraPoints*2.6],'LineStyle','-.','EdgeColor',[0.7 0.7 0.7],'Linewidth',2) ;
rectangle('Position',[FreqDakBoth-(ExtraPoints+.5),AmpDakBoth-(ExtraPoints+.5),ExtraPoints*3,ExtraPoints*3],'LineStyle','-.','EdgeColor',[0.7 0.7 0.7],'Linewidth',2);

p1=plot([FreqBakNorm-0.9],[AmpBakNorm+0.5]','o-','Color',[0.6 0.6 0.6],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.6 0.6 0.6]); %,'MarkerEdgeColor','k');
p2=plot([FreqBakSlow-0.9],[AmpBakSlow+0.5],'v:','Color',[0.3 0.3 0.3],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.3 0.3 0.3]); %,'MarkerEdgeColor','k');
p3=plot([FreqBakAmp+1.5],[AmpBakAmp+0.5],'^--','Color',[0.5 0.5 0.5],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.5 0.5 0.5]); %,'MarkerEdgeColor','k');
p4=plot([FreqBakBoth+1.5],[AmpBakBoth+0.5],'d-.','Color',[0.7 0.7 0.7],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.7 0.7 0.7]); %,'MarkerEdgeColor','k');
legend([p1,p2,p3,p4],'None','Slowed Down','Amplified','Both',2);
plot([FreqDakNorm+0.5],[AmpDakNorm+0.5]','o:','Color',[0.6 0.6 0.6],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.6 0.6 0.6]); %,'MarkerEdgeColor','k'); 
plot([FreqDakSlow+0.5],[AmpDakSlow+0.5],'v-','Color',[0.3 0.3 0.3],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.3 0.3 0.3]); %,'MarkerEdgeColor','k');
plot([FreqDakAmp+0.5],[AmpDakAmp+0.5],'^--','Color',[0.5 0.5 0.5],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.5 0.5 0.5]); %,'MarkerEdgeColor','k');
plot([FreqDakBoth+0.5],[AmpDakBoth+0.5],'d-.','Color',[0.7 0.7 0.7],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.7 0.7 0.7]); %,'MarkerEdgeColor','k');
axis square

subplot(2,2,4);

%Sums of squares of SD Data from experiment (see ch2_fratios.xls)
risk = [134340.6 236046.4 181700.1 186645.9]; 

BakNorm = (abs(EGrad([FreqBakNorm-ExtraPoints : FreqBakNorm+ExtraPoints],[AmpBakNorm-ExtraPoints : AmpBakNorm+ExtraPoints])));
DakNorm = (abs(EGrad([FreqDakNorm-ExtraPoints : FreqDakNorm+ExtraPoints],[AmpDakNorm-ExtraPoints : AmpDakNorm+ExtraPoints])));
count =0;
for i = 1:length(BakNorm)
    for j= length(DakNorm)
        count = count+1;
        Tempb(count)=BakNorm(i,j);
        Tempd(count)=DakNorm(i,j);
    end
end
Normb = mean(Tempb);
Normd = mean(Tempd);
Norm = std([Normb Normd]);

BakSlow = (abs(EGrad([FreqBakSlow-ExtraPoints : FreqBakSlow+ExtraPoints],[AmpBakSlow-ExtraPoints : AmpBakSlow+ExtraPoints])));
DakSlow = (abs(EGrad([FreqDakSlow-ExtraPoints : FreqDakSlow+ExtraPoints],[AmpDakSlow-ExtraPoints : AmpDakSlow+ExtraPoints])));
count =0;
for i = 1:length(BakNorm)
    for j= length(DakNorm)
        count = count+1;
        Tempb(count)=BakSlow(i,j);
        Tempd(count)=DakSlow(i,j);
    end
end
Slowb = mean(Tempb);
Slowd = mean(Tempd);
Slow = std([Tempb Tempd]);

BakAmp = (abs(EGrad([FreqBakAmp-ExtraPoints : FreqBakAmp+ExtraPoints],[AmpBakAmp-ExtraPoints : AmpBakAmp+ExtraPoints])));
DakAmp = (abs(EGrad([FreqDakAmp-ExtraPoints : FreqDakAmp+ExtraPoints],[AmpDakAmp-ExtraPoints : AmpDakAmp+ExtraPoints])));
count =0;
for i = 1:length(BakNorm)
    for j= length(DakNorm)
        count = count+1;
        Tempb(count)=BakAmp(i,j);
        Tempd(count)=DakAmp(i,j);
    end
end
Ampb = mean(Tempb);
Ampd = mean(Tempd);
Amp = std([Tempb Tempd]);

BakBoth = (abs(EGrad([FreqBakBoth-ExtraPoints : FreqBakBoth+ExtraPoints],[AmpBakBoth-ExtraPoints : AmpBakBoth+ExtraPoints])));
DakBoth = (abs(EGrad([FreqDakBoth-ExtraPoints : FreqDakBoth+ExtraPoints],[AmpDakBoth-ExtraPoints : AmpDakBoth+ExtraPoints])));
count =0;
for i = 1:length(BakNorm)
    for j= length(DakNorm)
        count = count+1;
        Tempb(count)=BakBoth(i,j);
        Tempd(count)=DakBoth(i,j);
    end
end
Bothb = mean(Tempb);
Bothd = mean(Tempd);
Both = std([Bothb Bothd]);

%Convert to unit scale
Model = [Norm Slow Amp Both];
Model = Model - min(Model);
Model_unit = Model./max(Model);

Riskunit  = risk-min(risk);
Risk_unit = Riskunit./max(Riskunit);

%Plot
x=[1:1:length(risk)];
plot(x,Risk_unit,'-k',x,Model_unit,':k');
set(gca,'XLim',[0.8 4.2],'XTick',[1 2 3 4],'XTickLabel',{'None';'Slowed Down';'Amplified';'Both'});
set(gca,'YLim',[-0.2 1.2],'YTick',[0 0.5 1]);
legend('Dyslexic Readers','Network 3MEM',1);
hold on;
plot(x(1),Risk_unit(1),'o:','Color',[0.6 0.6 0.6],'Linewidth',2,'MarkerSize',6);
plot(x(2),Risk_unit(2),'v-','Color',[0.3 0.3 0.3],'Linewidth',2,'MarkerSize',6);
plot(x(3),Risk_unit(3),'^--','Color',[0.5 0.5 0.5],'Linewidth',2,'MarkerSize',6);
plot(x(4),Risk_unit(4),'d-.','Color',[0.7 0.7 0.7],'Linewidth',2,'MarkerSize',6);
hold on;
plot(x(1),Model_unit(1),'o:','Color',[0.6 0.6 0.6],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.6 0.6 0.6]); %,'MarkerEdgeColor','k');
plot(x(2),Model_unit(2),'v-','Color',[0.3 0.3 0.3],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.3 0.3 0.3]); %,'MarkerEdgeColor','k');
plot(x(3),Model_unit(3),'^--','Color',[0.5 0.5 0.5],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.5 0.5 0.5]); %,'MarkerEdgeColor','k');
plot(x(4),Model_unit(4),'d-.','Color',[0.7 0.7 0.7],'Linewidth',2,'MarkerSize',6,'MarkerFaceColor',[0.7 0.7 0.7]); %,'MarkerEdgeColor','k');
title('D.'); 
ylabel('Experiment SD / Energy SD (unit scale)');
xlabel('Manipulation');


%% Save the Figure to EPS for postprocessing in Adobe Illustrator
set(gcf, 'Color', 'w');
export_fig 'ch3_fig2' -eps -q101 -painters

%% Safe workspace management 
keep Now
load([Now,'.mat'])
delete([Now,'.mat'])
clear Now
