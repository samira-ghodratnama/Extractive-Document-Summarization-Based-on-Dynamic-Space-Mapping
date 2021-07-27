function out = d_obj_c(x,c,W)
    out=x;
    distSum=findDistance2Dim(x,c,W,1);
    if(distSum~=0)
        out= -1.*(((W).^2).*((x-c).^2))/( distSum);
    else
        out=zeros(1,size(W,2));
    end
end