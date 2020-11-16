function [recon_out,sens_out]=predsens(ec_spin,obsm)


if nargin>1
ec_sprse=[ec_spin;obsm];
else
ec_sprse=ec_spin;
end

ec_mu=nanmean(ec_sprse);
ec_std=nanstd(ec_sprse);
ec_in=(ec_sprse-repmat(ec_mu,size(ec_sprse,1),1))./repmat(ec_std,size(ec_sprse,1),1);

opt = statset('ppca');
opt.TolFun = 1e-6;
opt.MaxIter=1000;
[coeff,score,pcvar,mu,v,S]=ppca(ec_in,10,'Options',opt);
recon=score*coeff'+mu;
u=score*inv(diag(pcvar));
 s=(diag(pcvar));
 v=coeff;
recon_out=(recon.*repmat(ec_std,size(ec_sprse,1),1))+repmat(ec_mu,size(ec_sprse,1),1);

if nargin>1
sens_out=recon_out(end,1);
else
sens_out=NaN;
end
