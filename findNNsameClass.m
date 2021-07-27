function  [pS,ds]=findNNsameClass(samples,W,x,label,labels)
    pS =[];
    ds=[];
    CommonSamples=[];
    commonIndexes= findMostCloseSamples(label,labels);
    if (~isempty(commonIndexes))
        for i=1:size(commonIndexes,2)
            CommonSamples=[CommonSamples,samples(commonIndexes(i))];
        end
        dists = findDistance2Dim(x,CommonSamples,W,1);
        [distance ,index]=min(dists);
        IndexNearSample=commonIndexes(index(1));
        pS=samples(IndexNearSample,:);
        ds=distance(1);
    end
end