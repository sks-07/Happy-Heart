function mod = getMod(A,Member)

%Input A: adjacency Matrix of size n*n;
%Member : Class membership of nodes 1 to n
%Computes and Returns back modularity

n = size(A,1);
% Compute # of edges
X = triu(A,1);
m = sum(sum(X));
% Array with degree info of each node
deg = sum(A);
Q = 0;
for i = 1:n
        for j = 1:n
                if Member(i) == Member(j)
                        Q = Q + ( A(i,j) - deg(i)*deg(j)/(2*m));
                end
        end
end
Q = Q/(2*m);
mod = Q;
end