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



  %create bootstrap template
t = templateTree('MinLeafSize',3)
  
    rtree=fitrensemble(ec_bg,mdlsens,'Method','LSBoost', ...
                          'NumLearningCycles',10,'LearnRate',0.03,'Learners',t);
    %do crossvalidation
 rens=crossval(rtree);
 %bootstrap prediction
u_r=kfoldPredict(rens);
%best guess prediction
u_p=predict(rtree,ec_bg);
clf
plot(mdlsens(~isnan(mdlsens)),u_r,'ko')
hold on
plot(mdlsens,u_p,'ro')


