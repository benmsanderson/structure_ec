[duf tmp]=xlsread('ECs.xlsx');

obs=duf([2,1],1:end);
cnsrt=tmp(1,3:end);


mdlname=tmp(7:end,1);

ec_spin=duf(4:end,2:end);
mdlsens=duf(4:end,1);







use_xc=[5,7,8,9,10,13,14,15,16];
nx=numel(use_xc)

low_s=find(mdlsens<nanmedian(mdlsens));
hi_s=find(mdlsens>nanmedian(mdlsens));

figure(2)
clf
for ii=1:nx
  i=use_xc(ii);
  subplot(nx,nx,ii+nx*(ii-1))
  u_in=[ec_spin(:,i),ones(size(ec_spin,1),1)];

nmb=bootstrp(1000,@regress,mdlsens,u_in)';
rng=[min(ec_spin(:,i)),max(ec_spin(:,i))];
if obs(2,i+1)-obs(1,i+1)>0
r=rectangle('Position',[obs(1,i+1),0,obs(2,i+1)-obs(1,i+1),6]);
set(r,'facecolor',[0.9,0.9,0.9],'edgecolor','none')
end
hold on

mno=mean([obs(1,i+1),obs(2,i+1)])
sdo=([obs(2,i+1)]-[obs(1,i+1)])/(1.282*2);

nmo1=randn(1000,1)*sdo+mno;

for kk=1:1000
    ss(kk)=[nmo1(kk),1]*nmb(:,kk);
end
prs= prctile(ss,[10,90]);

      
r=rectangle('Position',[rng(1),prs(1),rng(2)-rng(1),prs(2)-prs(1)]);
set(r,'facecolor',[0.5,0.7,0.5],'edgecolor',[0.3,0.7,0.3])

plot((obs(1,i+1))*[1,1],[0,6],'-','color',[0.2,.2,0.2])
plot((obs(2,i+1))*[1,1],[0,6],'-','color',[0.2,.2,0.2])

hold on

for kk=1:1000
 plot(rng,[rng;1,1]'*nmb(:,kk),'-','color',[1,0.5,0.5,.1])
 hold on
end


[b bint]=regress(mdlsens,u_in)

 plot(rng,[rng;1,1]'*b,'r-')
 
plot(ec_spin(low_s,i),mdlsens(low_s),'o','markersize',3,'markerfacecolor',[0.4,0.4,0.9],'markeredgecolor',[0.2,0.2,0.4])
hold on
plot(ec_spin(hi_s,i),mdlsens(hi_s),'o','markersize',3,'markerfacecolor',[0.9,0.4,0.4],'markeredgecolor',[0.4,0.2,0.2])

    hs=hist(ss,[0:0.1:6]);
%    patch(hs/max(hs)*(rng(2)-rng(1))/10+rng(1),[0:0.1:6],'k')
ylim([0,6])

xlabel(cnsrt{i})
ylabel('ECS (K)')
xlim(rng)


r=rectangle('Position',[rng(1),prs(1),rng(2)-rng(1),prs(2)-prs(1)]);
set(r,'facecolor','none','edgecolor',[0.3,0.7,0.3])


for jj=1:(ii-1)
  subplot(nx,nx,jj+nx*(ii-1))
  j=use_xc(jj);
  plot(ec_spin(low_s,j),ec_spin(low_s,i),'o','markersize',3,'markerfacecolor',[0.4,0.4,0.9],'markeredgecolor',[0.2,0.2,0.4])
hold on
  hold on
  plot(ec_spin(hi_s,j),ec_spin(hi_s,i),'o','markersize',3,'markerfacecolor',[0.9,0.4,0.4],'markeredgecolor',[0.4,0.2,0.2])

  pr=corrcoef(ec_spin(:,j),ec_spin(:,i),'rows','complete')

  rngx=[min(ec_spin(:,j)),max(ec_spin(:,j))];
xlim(rngx)
ylim(rng)


[x y]=calculateEllipse(mean(obs(1:2,j+1)),mean(obs(1:2,i+1)),(obs(2,j+1)-obs(1,j+1))/2,...
                       (obs(2,i+1)-obs(1,i+1))/2,0,100)
hold on
p=patch(x,y,[0.5,0.5,0.5])
set(p,'edgecolor',[0.2,0.2,0.2],'facecolor',[0.7,0.7,0.7],'FaceAlpha',0.5)
title(['Corr=' num2str(pr(2,1),'%0.2f')]);

ylabel(cnsrt{i})
xlabel(cnsrt{j})

end

end





set(gcf, 'PaperPosition', [0 0 12 10]);
set(gcf, 'PaperSize', [12 10]);

print(gcf,'-dpdf','-painters',['summary.pdf'])
print(gcf,'-dpng','-painters',['summary.png'])

