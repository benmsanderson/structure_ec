simens_1=randn(1000,30);
simens_2=randn(1000,30);


v_2=ones(30,1);%=tmp(:,1)*cont(1)+v_1*cont(2);
v_2=v_2/norm(v_2);

dims=[1,2,5,10,30];
figure(1)
clf
nn=1
  for j=1:5

for i=1:j
  subplot(5,5,5*(i-1)+j)
  %real world
    simtmp_1=repmat(mean(simens_1,1),1000,1);
    simtmp_1(:,1:dims(i))=simens_1(:,1:dims(i));
 %model
    simtmp_2=repmat(mean(simens_1,1),1000,1);
    simtmp_2(:,1:dims(j))=simens_2(:,1:dims(j));
%create 100 random ECs
    actfdb=simtmp_2*v_2+randn(1000,1)*0.0;
    simfdb=simtmp_1*v_2+randn(1000,1)*0.0;
    clear v_e skillec
for n=1:100
    v_r=randn(30,1);
    v_e(:,n)=v_r/norm(v_r);
    simec=simtmp_1*v_e(:,n)+randn(1000,1)*0.0;
    skillec(n)=(corr(simec,simfdb));
end
[duf bestec]=max(skillec);
v_1=v_e(:,bestec);

    actec=simtmp_2*v_1+randn(1000,1)*0.0;
    simec=simtmp_1*v_1+randn(1000,1)*0.0;


    b=regress(simfdb,[simec,ones(1000,1)]);
    p11=plot([actec,ones(1000,1)]*b,actfdb,'.','color',[0.5,0.5,0.5])
         hold on

	 p13=plot([simec,ones(1000,1)]*b,simfdb,'k.')
	 axis([-1,1,-1,1]*3*std(actfdb))
	     xlabel('Observable')
    ylabel({'Future','Response'})
title(['(' char(nn+97) ') D_{ens}=' num2str(dims(i)) ', D_{real}=' num2str(dims(j))])
    nn=nn+1

  end
  end
  psn=get(gca,'position')
  l=legend([p13,p11],'Best EC in model ensemble','EC applied to full dimensional ensemble')
set(l,'position',[0.55,0.1,0.1,0.05])

  for i=1:30
    for j=1:1000
      v_1=randn(i,1);
v_1=v_1/norm(v_1);
v_2=randn(i,1);
v_2=v_2/norm(v_2);

simens_1=randn(1000,i)+1;

   simec=simens_1*v_1+randn(1000,1)*0.05;
   simfdb=simens_1*v_2+randn(1000,1)*0.05;
   cmat(i,j)=corr(simec,simfdb);
    end
  end
  subplot('Position',[0.1,0.1,0.3,0.3])
  hold off
	   p1=plot(sum(cmat'>0.9)/1000,'k--')
	   hold on
	   p2=plot(sum(cmat'>0.7)/1000,'k-')
           legend([p1,p2],'Correlation>0.9','Correlation>0.7')
	   xlabel('D_{ens}')
	   ylabel('Fraction')
	   title({'(a) Fraction of random observations which','correlate with future response in ensemble'})


set(gcf, 'PaperPosition', [0 0 12 10]);
set(gcf, 'PaperSize', [12 10]);

print(gcf,'-dpdf','-painters',['simec.pdf'])
print(gcf,'-dpng','-painters',['simec.png'])

