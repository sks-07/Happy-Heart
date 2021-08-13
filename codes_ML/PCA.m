function [V, D] = PCA(data, options)

ReducedDim = 0;
if isfield(options,'ReducedDim')
    ReducedDim = options.ReducedDim;
end


[nSmp,nFea] = size(data);
if (ReducedDim > nFea) || (ReducedDim <=0)
    ReducedDim = nFea;
end


if issparse(data)
    data = full(data);
end
sampleMean = mean(data,1);
data = (data - repmat(sampleMean,nSmp,1));

[V, D] = mySVD(data',ReducedDim);
D = full(diag(D)).^2;



