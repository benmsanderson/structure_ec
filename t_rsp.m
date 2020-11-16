function [t tp]=t_rsp(pt,fcg,ts)

if nargin<3
    ts=1:numel(fcg);
end

if nargin<3
    cfb=0;
end

sns=pt(1:2);
tt=pt(3:4);

dfcg=diff([0 fcg']);


tf=(1-exp(-repmat(ts,2,1)./repmat(tt(:),1,numel(ts))));
tp=filter(dfcg,1,tf(:,:)'*diag(sns));

t=sum(tp,2);

