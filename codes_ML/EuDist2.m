function Distance = EuDist2(fea_a,~,bSqrt)
if ~exist('bSqrt','var')
    bSqrt = 1;
end

    aa = sum(fea_a.*fea_a,2);
    ab = fea_a*fea_a';
    
    if issparse(aa)
        aa = full(aa);
    end
    
    Distance = (aa+aa') - 2*ab;
    Distance(Distance<0) = 0;
    if bSqrt
        Distance = sqrt(Distance);
    end
    Distance = max(Distance,Distance');
