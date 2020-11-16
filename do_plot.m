
figure(1)
clf

subplot(4,2,1)
plot([1:280],3.5*[linspace(0,1,140)';ones(1,140)']+randn(1,280)','color',[0.5,0.5,0.5])
hold on
plot([1:280],3.5*[linspace(0,1,140)';ones(1,140)'],'--','color',[0.2,.2,.2])

xlabel('Time (years)')
ylabel('Forcing (Wm^{-2})')
xlim([0,280])
ylim([-2,8])
hold on
plot([70,70],[-2,8],'k:')


plot([140,140],[-2,8],'k--')
title('(a)')
set(gca','xtick',[0,70,140,210,280])

subplot(4,2,2)
p1=plot([1:280],tt1,'color',[0.9,0.3,0.3,0.5])
hold on
p2=plot([1:280],tt,'color',[0.3,0.3,0.9,0.5])
xlim([0,280])

plot([70,70],[-2,8],'k:')
plot([140,140],[-2,8],'k--')
ylim([-6,8])
set(gca','xtick',[0,70,140,210,280])
legend([p1(1),p2(1)],'1 timescale model','2 timescale model','location','south')

xlabel('Time (years)')
ylabel('Temperature (K)')

title('(b)')

subplot(4,2,2+1)
mno=1.8;
sdo=.05;
nmo1=randn(1000,1)*sdo+mno;
prp=prctile(nmo1,[10,90]);
r=rectangle('position',[prp(1),0,prp(2)-prp(1),25],'edgecolor','none','facecolor',[0.9,0.9,0.9])

hold on
plot([mno,mno],[0,25],'-','color',[0.5,0.5,0.5])
p1=plot(tt1(:,70),tt1(:,140),'.','markersize',10,'color',[0.9,0.3,0.3])

nmb=bootstrp(1000,@regress,tt1(:,280),[tt1(:,70),ones(n_m,1)])';
vr=std(tt1(:,140)-[tt1(:,70),ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
prs=prctile(ss,[25,75]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',4)
prs=prctile(ss,[5,95]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',1)

rng=[0,6];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[1,0.5,0.5,.01])
 hold on
end

p2=plot(tt(:,70),tt(:,140),'.','markersize',10,'color',[0.3,0.3,0.9])

nmb=bootstrp(1000,@regress,tt(:,140),[tt(:,70),ones(n_m,1)])';
vr=std(tt(:,140)-[tt(:,70),ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end

prs=prctile(ss,[25,75]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',4)
prs=prctile(ss,[5,95]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',1)


for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[0.5,0.5,1,.01])
 hold on
end


ylabel({'Transient Warming after','140 years (K)'})
xlabel({'Transient Warming after','70 years (K)'})
title('(c)')
axis([0,2,0,8])




subplot(4,2,2+2)



mno=1.8;
sdo=.05;
nmo1=randn(1000,1)*sdo+mno;
prp=prctile(nmo1,[10,90]);
r=rectangle('position',[prp(1),0,prp(2)-prp(1),25],'edgecolor','none','facecolor',[0.9,0.9,0.9])

hold on
plot([mno,mno],[0,25],'-','color',[0.5,0.5,0.5])
p1=plot(tt1(:,70),tt1(:,end),'.','markersize',10,'color',[0.9,0.3,0.3])

nmb=bootstrp(1000,@regress,tt1(:,280),[tt1(:,70),ones(n_m,1)])';
vr=std(tt1(:,end)-[tt1(:,70),ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
prs=prctile(ss,[25,75]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',4)
prs=prctile(ss,[5,95]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',1)

rng=[0,6];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[1,0.5,0.5,.01])
 hold on
end

p2=plot(tt(:,70),tt(:,end),'.','markersize',10,'color',[0.3,0.3,0.9])

nmb=bootstrp(1000,@regress,tt(:,end),[tt(:,70),ones(n_m,1)])';
vr=std(tt(:,end)-[tt(:,70),ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end

prs=prctile(ss,[25,75]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',4)
prs=prctile(ss,[5,95]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',1)


for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[0.5,0.5,1,.01])
 hold on
end


ylabel({'Transient Warming after','280 years (K)'})
xlabel({'Transient Warming after','70 years (K)'})
title('(d)')
%legend([p1,p2],'1 timescale model','2 timescale model','location','southeast')
axis([0,2,0,8])






subplot(4,2,2+3)

prd=ag1(:,1);%+randn(n_m,1)/3;

mno=1.5;
sdo=0.25;
nmo1=randn(1000,1)*sdo+mno;
prp=prctile(nmo1,[10,90]);
r=rectangle('position',[prp(1),0,prp(2)-prp(1),8],'edgecolor','none','facecolor',[0.9,0.9,0.9])

hold on
plot([mno,mno],[0,8],'-','color',[0.5,0.5,0.5])
p1=plot(prd,tt1(:,140),'.','markersize',10,'color',[0.9,0.3,0.3])

nmb=bootstrp(1000,@regress,tt1(:,140),[prd,ones(n_m,1)])';
vr=std(tt1(:,140)-[prd,ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss1(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
rng=[0,6];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[1,0.5,0.5,.01])
 hold on
end
prd=ag(:,1);%+randn(n_m,1)/3;


p2=plot(prd,tt(:,140),'.','markersize',10,'color',[0.3,0.3,0.9])

nmb=bootstrp(1000,@regress,tt(:,140),[prd,ones(n_m,1)])';
vr=std(tt(:,140)-[prd,ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
prs=prctile(ss,[25,75]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',4)
prs=prctile(ss,[5,95]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',1)

prs=prctile(ss1,[25,75]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',4)
prs=prctile(ss1,[5,95]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',1)

rng=[0,6];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[0.5,0.5,1,.01])
 hold on
end


ylabel({'Transient Warming after','140 years (K)'})
xlabel('Observed \lambda^{-1}')
title('(e)')
axis([0,4,0,8])


subplot(4,2,2+4)

prd=ag1(:,1);%+randn(n_m,1)/3;

mno=1.5;
sdo=0.25;
nmo1=randn(1000,1)*sdo+mno;
prp=prctile(nmo1,[10,90]);
r=rectangle('position',[prp(1),0,prp(2)-prp(1),8],'edgecolor','none','facecolor',[0.9,0.9,0.9])

hold on
plot([mno,mno],[0,8],'-','color',[0.5,0.5,0.5])
p1=plot(prd,tt1(:,end),'.','markersize',10,'color',[0.9,0.3,0.3])

nmb=bootstrp(1000,@regress,tt1(:,end),[prd,ones(n_m,1)])';
vr=std(tt1(:,end)-[prd,ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss1(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
rng=[0,6];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[1,0.5,0.5,.01])
 hold on
end
prd=ag(:,1);%+randn(n_m,1)/3;


p2=plot(prd,tt(:,end),'.','markersize',10,'color',[0.3,0.3,0.9])

nmb=bootstrp(1000,@regress,tt(:,end),[prd,ones(n_m,1)])';
vr=std(tt(:,end)-[prd,ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
prs=prctile(ss,[25,75]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',4)
prs=prctile(ss,[5,95]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',1)

prs=prctile(ss1,[25,75]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',4)
prs=prctile(ss1,[5,95]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',1)

rng=[0,6];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[0.5,0.5,1,.01])
 hold on
end


ylabel({'Transient Warming after','280 years (K)'})
xlabel('Observed \lambda^{-1}')
title('(f)')
axis([0,4,0,8])



subplot(4,2,2+5)
mno=3;
sdo=.5;
nmo1=randn(1000,1)*sdo+mno;
prp=prctile(nmo1,[10,90]);
r=rectangle('position',[prp(1),0,prp(2)-prp(1),10],'edgecolor','none','facecolor',[0.9,0.9,0.9])

hold on
plot([mno,mno],[0,10],'-','color',[0.5,0.5,0.5])
p1=plot(ec_cox1,tt1(:,140),'.','markersize',10,'color',[0.9,0.3,0.3])

nmb=bootstrp(1000,@regress,tt1(:,140),[ec_cox1',ones(n_m,1)])';
vr=std(tt1(:,140)-[ec_cox1',ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss1(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
rng=[0,5];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[1,0.5,0.5,.01])
 hold on
end

p2=plot(ec_cox,tt(:,140),'.','markersize',10,'color',[0.3,0.3,0.9])

nmb=bootstrp(1000,@regress,tt(:,140),[ec_cox',ones(n_m,1)])';
vr=std(tt(:,140)-[ec_cox',ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
prs=prctile(ss,[25,75]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',4)
prs=prctile(ss,[5,95]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',1)

prs=prctile(ss1,[25,75]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',4)
prs=prctile(ss1,[5,95]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',1)

rng=[0,5];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[0.5,0.5,1,.01])
 hold on
end


ylabel({'Transient Warming after','140 years (K)'})

xlabel('\psi variablity metric')
title('(g)')
axis([0,5,0,10])






subplot(4,2,2+6)
mno=3;
sdo=.5;
nmo1=randn(1000,1)*sdo+mno;
prp=prctile(nmo1,[10,90]);
r=rectangle('position',[prp(1),0,prp(2)-prp(1),10],'edgecolor','none','facecolor',[0.9,0.9,0.9])

hold on
plot([mno,mno],[0,10],'-','color',[0.5,0.5,0.5])
p1=plot(ec_cox1,tt1(:,end),'.','markersize',10,'color',[0.9,0.3,0.3])

nmb=bootstrp(1000,@regress,tt1(:,end),[ec_cox1',ones(n_m,1)])';
vr=std(tt1(:,end)-[ec_cox1',ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss1(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
rng=[0,5];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[1,0.5,0.5,.01])
 hold on
end

p2=plot(ec_cox,tt(:,end),'.','markersize',10,'color',[0.3,0.3,0.9])

nmb=bootstrp(1000,@regress,tt(:,end),[ec_cox',ones(n_m,1)])';
vr=std(tt(:,end)-[ec_cox',ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
prs=prctile(ss,[25,75]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',4)
prs=prctile(ss,[5,95]);
plot([0.25,0.25],prs,'-','color',[0.3,0.3,0.9],'linewidth',1)

prs=prctile(ss1,[25,75]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',4)
prs=prctile(ss1,[5,95]);
plot([0.5,0.5],prs,'-','color',[0.9,0.3,0.3],'linewidth',1)

rng=[0,5];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[0.5,0.5,1,.01])
 hold on
end


ylabel({'Transient Warming after','280 years (K)'})

xlabel('\psi variablity metric')
title('(h)')
axis([0,5,0,10])



set(gcf, 'PaperPosition', [0 0 6 9]);
print(gcf,'-dpng','-painters',['ebm.png'])