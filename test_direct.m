[duf tmp]=xlsread('ECs.xlsx');

obs=duf([2,1],1:end);
cnsrt=tmp(1,3:end);


mdlname=tmp(6:end,1);

ec_spin=duf(4:end,1:end);



obsm=mean(obs,1);


for i=1:50
    i
obsr=obsm+randn(size(obsm)).*range(obs);
[~,sens_out(i)]=predsens(ec_spin,obsr);
end


for i=1:numel(mdlname)
    i
    for j=1:50
        j
testr=ec_spin(i,:);
testr(1)=NaN;
tset=find([1:numel(mdlname)]~=i);
[~,sens_test(i,j)]=predsens(ec_spin(tset,:),testr);
end
end