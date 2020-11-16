[duf tmp]=xlsread('ECs.xlsx');

obs=duf([2,1],1:end);



mdlname=tmp(6:end,1);

ec_spin=duf(4:end,1:end);




cnsrt=tmp(1,3:end);
obsm=mean(obs,1);

 recon_out=predsens(ec_spin,obsm)