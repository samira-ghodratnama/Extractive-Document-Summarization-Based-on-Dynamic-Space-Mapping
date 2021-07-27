function  [pD,dd]=findNNdiffClass(samples,W,x,label,labels)
    pD=[];
    dd=[];
    DifferSamples=[];
    differIndexes= findMostDifferSamples(label,labels);
    if ~isempty(differIndexes)
        for i=1:size(differIndexes,2)
            DifferSamples=[DifferSamples,samples(differIndexes(i))];
        end
        dists = findDistance2Dim(x,DifferSamples,W,1);
        [distance ,index]=min(dists);
        IndexFarSample=differIndexes(index(1));
        pD=samples(IndexFarSample,:);
        dd=distance(1);
    end
end