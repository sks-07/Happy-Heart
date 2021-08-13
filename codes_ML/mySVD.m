function [U, S, V] = mySVD(X,ReducedDim)                                                 

MAX_MATRIX_SIZE = 500; 
EIGVECTOR_RATIO = 0.1; 


[nSmp, mFea] = size(X);
if mFea/nSmp > 1.0713
    ddata = X*X';
    ddata = max(ddata,ddata');
    
    dimMatrix = size(ddata,1);
    if (ReducedDim > 0) && (dimMatrix > MAX_MATRIX_SIZE) && (ReducedDim < dimMatrix*EIGVECTOR_RATIO)
        option = struct('disp',0);
        [U, D] = eigs(ddata,ReducedDim,'la',option);
        D = diag(D);
    else
        if issparse(ddata)
            ddata = full(ddata);
        end
        
        [U, D] = eig(ddata);
        D = diag(D);
        [~, index] = sort(-D);
        D = D(index);
        U = U(:, index);
    end
    clear ddata;
    
    maxEigValue = max(abs(D));
    eigIdx = find(abs(D)/maxEigValue < 1e-10);
    D(eigIdx) = [];
    U(:,eigIdx) = [];
    
    if (ReducedDim > 0) && (ReducedDim < length(D))
        D = D(1:ReducedDim);
        U = U(:,1:ReducedDim);
    end
    
    eigvalue_Half = D.^.5;
    S =  spdiags(eigvalue_Half,0,length(eigvalue_Half),length(eigvalue_Half));

    if nargout >= 3
        eigvalue_MinusHalf = eigvalue_Half.^-1;
        V = X'*(U.*repmat(eigvalue_MinusHalf',size(U,1),1));
    end
else
    ddata = X'*X;
    ddata = max(ddata,ddata');
    
    dimMatrix = size(ddata,1);
    if (ReducedDim > 0) && (dimMatrix > MAX_MATRIX_SIZE) && (ReducedDim < dimMatrix*EIGVECTOR_RATIO)
        option = struct('disp',0);
        [V, D] = eigs(ddata,ReducedDim,'la',option);
        D = diag(D);
    else
        if issparse(ddata)
            ddata = full(ddata);
        end
        
        [V, D] = eig(ddata);
        D = diag(D);
        
        [~, index] = sort(-D);
        D = D(index);
        V = V(:, index);
    end
    clear ddata;
    
    maxEigValue = max(abs(D));
    eigIdx = find(abs(D)/maxEigValue < 1e-10);
    D(eigIdx) = [];
    V(:,eigIdx) = [];
    
    if (ReducedDim > 0) && (ReducedDim < length(D))
        D = D(1:ReducedDim);
        V = V(:,1:ReducedDim);
    end
    
    eigvalue_Half = D.^.5;
    S =  spdiags(eigvalue_Half,0,length(eigvalue_Half),length(eigvalue_Half));
    
    eigvalue_MinusHalf = eigvalue_Half.^-1;
    U = X*(V.*repmat(eigvalue_MinusHalf',size(V,1),1));
end






