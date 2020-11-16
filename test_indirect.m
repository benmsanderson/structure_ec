[duf tmp]=xlsread('ECs.xlsx');

obs=duf([2,1],1:end);
cnsrt=tmp(1,3:end);


mdlname=tmp(6:end,1);

ec_spin=duf(4:end,2:end);
mdlsens=duf(4:end,1);


%%Create 50 simulated EC sets

for i=1:50
ec_guess(:,:,i)=predinfill(ec_spin);
end

ec_bg=mean(ec_guess(:,:,:),3);

ec_mu=mean(ec_bg);
ec_std=std(ec_bg);

ec_in=(ec_bg-repmat(ec_mu,size(ec_bg,1),1))./repmat(ec_std,size(ec_bg,1),1);

[u s v]=svds(ec_in,10);


 [a b c d]=stepwisefit(u,mdlsens,'penter',0.09)
 
 usemd=find(d);

for i=1:numel(usemd)
 subplot(numel(usemd),1,i)
    barh(v(:,usemd(i)));
    set(gca,'ytick',1:numel(cnsrt),'yticklabel',cnsrt)
end


 figure(1)
clf
 plot(mdlsens,nanmean(mdlsens)+u(:,usemd)*regress(mdlsens,u(:,usemd)),'o')

 hold on
  plot([0,5],[0,5])

  
figure(2)
clf
subplot(3,2,1)
u_in=[ec_spin(:,9)+ec_spin(:,10),ones(size(ec_spin,1),1)];

nmb=bootstrp(1000,@regress,mdlsens,u_in)';
for i=1:1000
 plot([0.4,1],[0.4,1;1,1]*nmb(:,i),'-','color',[1,0.5,0.5])
 hold on
end


[b bint]=regress(mdlsens,u_in)

 plot([0.4,1],[0.4,1;1,1]*b,'r-')
 
plot(ec_spin(:,9)+ec_spin(:,10),mdlsens,'ko')
hold on

plot((obs(1,9+1)+obs(1,10+1))*[1,1],[0,6],'k--')
plot((obs(2,9+1)+obs(2,10+1))*[1,1],[0,6],'k--')

mno=mean([obs(1,9+1)+obs(1,10+1),obs(2,9+1)+obs(2,10+1)])
sdo=([obs(2,9+1)+obs(2,10+1)]-[obs(1,9+1)+obs(1,10+1)])/(1.282*2);

nmo1=randn(1000,1)*sdo+mno;

for i=1:1000
    ss(i)=[nmo1(i),1]*nmb(:,1);
end

    hs=hist(ss,[0:0.1:6]);
    plot(hs/max(hs)*0.1+0.4,[0:0.1:6],'k')
ylim([0,6])

xlabel('Sherwood 2015')
ylabel('Climate Sensitivity (K)')



subplot(3,2,2)
hold off
u_in=[ec_spin(:,16),ones(size(ec_spin,1),1)];

nmb=bootstrp(1000,@regress,mdlsens,u_in)';
for i=1:1000
 plot([0,.4],[0.,1;.4,1]*nmb(:,i),'-','color',[1,0.5,0.5])
 hold on
end


[b bint]=regress(mdlsens,u_in)

 plot([0,.4],[0,1;.4,1]*b,'r-')
 
plot(ec_spin(:,16),mdlsens,'ko')
hold on

plot((obs(1,16+1))*[1,1],[0,6],'k--')
plot((obs(2,16+1))*[1,1],[0,6],'k--')

mno=mean([obs(1,16+1),obs(2,16+1)])
sdo=([obs(2,16+1)]-[obs(1,16+1)])/(1.282*2);

nmo=randn(1000,1)*sdo+mno;

for i=1:1000
    ss(i)=[nmo(i),1]*nmb(:,1);
end

    hs=hist(ss,[0:0.1:6]);
    plot(hs/max(hs)*0.1+0.,[0:0.1:6],'k')
ylim([0,6])
xlabel('Cox 2018')
ylabel('Climate Sensitivity (K)')


subplot(3,2,3:6)
hold off
s=scatter(ec_spin(:,16),ec_spin(:,10)+ec_spin(:,9),30,mdlsens);
set(s,'markerfacecolor','flat')
hold on

[x y]=calculateEllipse(mean(obs(1:2,16+1)),mean(obs(1:2,9+1))+ ...
                       mean(obs(1:2,9+1)),obs(2,16+1)-obs(1,16+1),...
                       obs(2,9+1)-obs(1,9+1)+obs(2,10+1)-obs(1,10+1),0,100)

plot(x,y,'k')
cb=colorbar;
set(get(cb,'Label'),'String','Climate Sensitivity (K)')


xlabel('Cox 2018')
ylabel('Sherwood 2015')
% create smaller axes in top right, and plot on it
ax=axes('Position',[0.6,0.45,0.15,0.15])
box on
hist([nmo,nmo1,ones(1000,1)]*regress(mdlsens,[ec_bg(:,16),ec_bg(:,10)+ec_bg(:,9),ones(size(ec_spin,1),1)]),[0:0.1:6])
xlabel('Climate Senstivity (K)')

set(gcf, 'PaperPosition', [0 0 6 6]);
set(gcf, 'PaperSize', [6 6]);

print(gcf,'-dpdf','-painters',['summary.pdf'])


