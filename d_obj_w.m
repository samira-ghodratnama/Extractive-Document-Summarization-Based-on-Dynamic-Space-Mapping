function out = d_obj_w(x, clusterSamples, trueLabel, clusterLabels, w, Beta,centroid)
    out=zeros(1,size(clusterSamples,2));
    P = clusterSamples;
    W = repmat(w,size(P,1),1);
    out=[];
    [pS,ds]=findNNsameClass(P,W,x,trueLabel,clusterLabels);
    [pD,dd]=findNNdiffClass(P,W,x,trueLabel,clusterLabels);
    if ~isempty(pS) && ~isempty(pD)
       U = (ds)/(dd);
       sprim = Gsigmoid(U,Beta);
       if(size(pS,2)~=0 && size(pD,2)~=0)
           term1=(w.*(x-centroid))/findDistance2Dim(x,centroid,w,1);
           term2=U.*sprim.*(w.*((x - pS).^2 ))/(findDistance2Dim(x,centroid,w,1)^2);
       end
       out = term1+term2;
    end
end
