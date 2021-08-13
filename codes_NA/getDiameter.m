%% Fast diameter implentation
function [diameter] = getDiameter(matrix)
    track=zeros(size(matrix,1));
    pl = 1;
    diameter = 0;
    pl_matrix = matrix; 
    while pl<size(matrix,1) 
        if pl_matrix==zeros(size(matrix,1))
            break
        end
        if all(track,'all')
            break
        end
        track = (track + pl_matrix)>0;
        pl_matrix = pl_matrix * matrix;        
        pl = pl + 1;
        if ~all(((pl_matrix>0)-track<1),'all') 
            diameter = pl;
        end
    end
end

%% Clustering coefficient function
function [cf_value] = clustering_coeff(matrix)
    cf_value = (3*sum(trace(matrix^3)))/(sum(sum(matrix^2)) - sum(diag(matrix^2)));
end