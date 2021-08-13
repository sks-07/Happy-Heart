function Kernel = constructKernel(fea_a,fea_b,options)
if ~isfield(options,'KernelType')
    options.KernelType = 'Gaussian';
end

switch lower(options.KernelType)
    case {lower('Gaussian')}       
        if ~isfield(options,'t')
            options.t = 1;
        end
    
end


switch lower(options.KernelType)
    case {lower('Gaussian')}       
        if isempty(fea_b)
            D = EuDist2(fea_a,[],0);
        end
        Kernel = exp(-D/(2*options.t^2));
    
end

if isempty(fea_b)
    Kernel = max(Kernel,Kernel');
end

    