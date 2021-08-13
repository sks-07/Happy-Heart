function [eigvector, eigvalue] = KPCA(data, options)



ReducedDim = 20;
if isfield(options,'ReducedDim')
    ReducedDim = options.ReducedDim;
end


K = constructKernel(data,[],options);

clear data;
    
nSmp = size(K,1);
if (ReducedDim > nSmp) || (ReducedDim <=0)
    ReducedDim = nSmp;
end

sumK = sum(K,2);
H = repmat(sumK./nSmp,1,nSmp);
K = K - H - H' + sum(sumK)/(nSmp^2);
K = max(K,K');
clear H;


[eigvector, eigvalue] = eig(K);
eigvalue = diag(eigvalue);
    
[~, index] = sort(-eigvalue);
eigvalue = eigvalue(index);
eigvector = eigvector(:,index);



if ReducedDim < length(eigvalue)
    eigvalue = eigvalue(1:ReducedDim);
    eigvector = eigvector(:, 1:ReducedDim);
end

maxEigValue = max(abs(eigvalue));
eigIdx = find(abs(eigvalue)/maxEigValue < 1e-6);
eigvalue (eigIdx) = [];
eigvector (:,eigIdx) = [];

for i=1:length(eigvalue) % normalizing eigenvector
    eigvector(:,i)=eigvector(:,i)/sqrt(eigvalue(i));
end



