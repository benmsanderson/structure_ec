%rng=[0.1,1.5;0.5,1.16;1,8.6;53,317;0.8,2.5];
%rng1=[0.5,1.5;0.001,0.001;4.7,16.6;53,317;1,1];
rng= [0.2,10; 0.5,3;       2,10;  53,500; 0.8,2.5];
rng1=[0.2,2; .001,.001; 10,20;  53,500; 0.8,2.5];


n_m=50;
lh=lhsdesign(n_m,5);
ag=lh*diag(range(rng'))+repmat(rng(:,1),1,n_m)'
ag1=lh*diag(range(rng1'))+repmat(rng1(:,1),1,n_m)'


for i=1:n_m
  a(i,:)=from_geoffroy(ag(i,:));
  a1(i,:)=from_geoffroy(ag1(i,:));
  ts(i,:)=t_rsp(a(i,:),ones(1,10000)');
  tr(i,:)=t_rsp(a(i,:),2*randn(1,10000)');
  tt(i,:)=t_rsp(a(i,:),3.5*[linspace(0,1,140)';ones(1,140)']+.5*randn(1,280)');
  tt1(i,:)=t_rsp(a1(i,:),3.5*[linspace(0,1,140)';ones(1,140)']+.5*randn(1,280)');
  ts1(i,:)=t_rsp(a1(i,:),ones(1,10000)');
  tr1(i,:)=t_rsp(a1(i,:),2*randn(1,10000)');
  ec_sd(i)=std(detrend(tr(i,:),1));
  ec_sd1(i)=std(detrend(tr1(i,:),1));
  ac1(i,:)=autocorr(detrend(tt1(i,:)),'NumLags',30);
  ec_l1(i)=ac1(i,2);
  ac(i,:)=autocorr(detrend(tt(i,:)),'NumLags',30);
  ec_l(i)=ac(i,2);

  ec_cox(i)=ec_sd(i)/sqrt(-log(ec_l(i)));
  ec_cox1(i)=ec_sd1(i)/sqrt(-log(ec_l1(i)));
end

do_plot
