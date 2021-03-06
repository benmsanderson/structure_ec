rng=[0,4;0,4;10,20;100,1000];
rng1=[0,4;0,0;10,20;100,100];
n_m=25;
lh=lhsdesign(n_m,4);
a=lh*diag(range(rng'))+repmat(rng(:,1),1,n_m)'
a1=lh*diag(range(rng1'))+repmat(rng1(:,1),1,n_m)'


for i=1:n_m
  ts(i,:)=t_rsp(a(i,:),ones(1,10000)');
  tr(i,:)=t_rsp(a(i,:),randn(1,10000)');
  tt(i,:)=t_rsp(a(i,:),3.5*linspace(0,1,140)'+randn(1,140)');
  tt1(i,:)=t_rsp(a1(i,:),3.5*linspace(0,1,140)'+randn(1,140)');
  ts1(i,:)=t_rsp(a1(i,:),ones(1,10000)');
  tr1(i,:)=t_rsp(a1(i,:),randn(1,10000)');
  ec_sd(i)=std(detrend(tr(i,:),1));
  ec_sd1(i)=std(detrend(tr1(i,:),1));
  ac1(i,:)=autocorr(detrend(tt1(i,:)),'NumLags',30);
  ec_l1(i)=ac1(i,2);
  ac(i,:)=autocorr(detrend(tt(i,:)),'NumLags',30);
  ec_l(i)=ac(i,2);

  ec_cox(i)=ec_sd(i)/sqrt(-log(ec_l(i)));
  ec_cox1(i)=ec_sd1(i)/sqrt(-log(ec_l1(i)));
end



figure(1)
clf
subplot(3,1,1)
mno=2;
sdo=.25;
nmo1=randn(1000,1)*sdo+mno;
prp=prctile(nmo1,[10,90]);
r=rectangle('position',[prp(1),0,prp(2)-prp(1),25],'edgecolor','none','facecolor',[0.9,0.9,0.9])

hold on
plot([mno,mno],[0,25],'-','color',[0.5,0.5,0.5])
p1=plot(tt1(:,50),tt1(:,end),'.','markersize',10,'color',[0.9,0.3,0.3])

nmb=bootstrp(1000,@regress,tt1(:,end),[tt1(:,50),ones(n_m,1)])';
vr=std(tt1(:,end)-[tt1(:,50),ones(n_m,1)]*mean(nmb,2));
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

p2=plot(tt(:,50),tt(:,end),'.','markersize',10,'color',[0.3,0.3,0.9])

nmb=bootstrp(1000,@regress,tt(:,end),[tt(:,50),ones(n_m,1)])';
vr=std(tt(:,end)-[tt(:,50),ones(n_m,1)]*mean(nmb,2));
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
title('(a) Type 1')
legend([p1,p2],'1 timescale model','2 timescale model','location','southeast')
axis([0,6,0,12])


subplot(3,1,3)
mno=0.5;
sdo=.05;
nmo1=randn(1000,1)*sdo+mno;
prp=prctile(nmo1,[10,90]);
r=rectangle('position',[prp(1),0,prp(2)-prp(1),8],'edgecolor','none','facecolor',[0.9,0.9,0.9])

hold on
plot([mno,mno],[0,8],'-','color',[0.5,0.5,0.5])
p1=plot(ec_sd1,ts1(:,end),'.','markersize',10,'color',[0.9,0.3,0.3])

nmb=bootstrp(1000,@regress,ts1(:,end),[ec_sd1',ones(n_m,1)])';
vr=std(ts1(:,end)-[ec_sd1',ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss1(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
rng=[0,1];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[1,0.5,0.5,.01])
 hold on
end

p2=plot(ec_sd,ts(:,end),'.','markersize',10,'color',[0.3,0.3,0.9])

nmb=bootstrp(1000,@regress,ts(:,end),[ec_sd',ones(n_m,1)])';
vr=std(ts(:,end)-[ec_sd',ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
prs=prctile(ss,[25,75]);
plot([0.05,0.05],prs,'-','color',[0.3,0.3,0.9],'linewidth',4)
prs=prctile(ss,[5,95]);
plot([0.05,0.05],prs,'-','color',[0.3,0.3,0.9],'linewidth',1)

prs=prctile(ss1,[25,75]);
plot([0.1,0.1],prs,'-','color',[0.9,0.3,0.3],'linewidth',4)
prs=prctile(ss1,[5,95]);
plot([0.1,0.1],prs,'-','color',[0.9,0.3,0.3],'linewidth',1)

rng=[0,1];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[0.5,0.5,1,.01])
 hold on
end



ylabel('Climate Sensitivity (K)')
xlabel('Detrended i/a variablity')
title('(c) Type 3')
axis([0,1,0,8])


subplot(3,1,2)

prd=a(:,1)+randn(n_m,1)/3;

mno=1.5;
sdo=0.25;
nmo1=randn(1000,1)*sdo+mno;
prp=prctile(nmo1,[10,90]);
r=rectangle('position',[prp(1),0,prp(2)-prp(1),8],'edgecolor','none','facecolor',[0.9,0.9,0.9])

hold on
plot([mno,mno],[0,8],'-','color',[0.5,0.5,0.5])
p1=plot(prd,ts1(:,end),'.','markersize',10,'color',[0.9,0.3,0.3])

nmb=bootstrp(1000,@regress,ts1(:,end),[prd,ones(n_m,1)])';
vr=std(ts1(:,end)-[prd,ones(n_m,1)]*mean(nmb,2));
nm2=randn(1000,1)*vr;

for kk=1:1000
    ss1(kk)=[nmo1(kk),1]*nmb(:,kk)+nm2(kk);
end
rng=[0,6];
for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[1,0.5,0.5,.01])
 hold on
end


p2=plot(prd,ts(:,end),'.','markersize',10,'color',[0.3,0.3,0.9])

nmb=bootstrp(1000,@regress,ts(:,end),[prd,ones(n_m,1)])';
vr=std(ts(:,end)-[prd,ones(n_m,1)]*mean(nmb,2));
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



ylabel('Climate Sensitivity (K)')
xlabel('Observed \lambda')
title('(b) Type 2')
axis([0,4,0,6])

set(gcf, 'PaperPosition', [0 0 4 10]);
set(gcf, 'PaperSize', [4 10]);

print(gcf,'-dpdf','-painters',['ebm.pdf'])
print(gcf,'-dpng','-painters',['ebm.png'])

