clc;clear;
%-------------------------------------------read data-----------------------------------
data=dlmread('Copy_of_v2.txt',' ');
data = data(randperm(size(data,1)),:);
allSamples=data(:,1:end-1);
labels=data(:,end);
numofselecteddata = size(data,1);
% trainIndex = 1:floor(.8*size(data,1));
% testIndex = floor(.8*size(data,1))+1:size(data,1);
% trainData=data(trainIndex,:);
% testData=data(testIndex,:);
% w =ones(1,size(data,2)-1);
%------------------------------------------cluster data--------------------------------
nbclusters=2;
% Beta = 0.01;
% alpha = .9;
%[clusters, evalues, evectors] = spcl(data(:,1:end-1), nbclusters, w, 'kmean', [3 3]);
%------------------------------------------------------------------------------------------
%clusters = kmeans(data(:,1:end-1),nbclusters);
%------------------------------------------------------------------------------------------
% options.weight=w;
% clusters=weightedKmeans(data(:,1:end-1), nbclusters,options);
%------------------------------------------------------------------------------------------
W=ones(nbclusters,size(allSamples,2));
Wnew = W;
% [clusters] = ourKmeans(data(:,1:end-1), nbclusters, W);
%------------------------------------------classification------------------------------
% testClusters = clusters(testIndex);
% trainClusters = clusters(trainIndex);
%---------------------------------initialization---------------------------
% b=randperm(size(allSamples,2));
% load b
% allSamples = allSamples(:,b); 
% labels=labels(:,b);
Beta = 0.1;alpha = 0.9;
F1All=0;PrecisionAll=0;RecallAll=0;AccuracyAll=0;
knearest=1; 
TestSampleSize=numofselecteddata;
%--------------------------------------------------------------------------
for iter=1:100
    for j=1:numofselecteddata
         if(j<size(allSamples,1))
            if (j~=1)
                trainSamples= [allSamples(1:j-1,:);allSamples(j+1:size(allSamples,1),:)];
                trainLabels= [labels(1:j-1,:);labels(j+1:size(labels,1),:)];
                testSamples=allSamples(j,:);
                testLabels=labels(j);
            else
                trainSamples= allSamples(2:size(allSamples,1),:);
                trainLabels= labels(2:size(labels,1),:);
                testSamples=allSamples(1);
                testLabels=labels(1);
            end
         end
        [clusters,centroids] = ourKmeans(trainSamples, nbclusters,W, 1,[]);%first randolmly kmeans
        %========================start learning================================
        for itera=1:1
            for k=1:size(centroids,2) %iteration over clusters
                clusterSamples = trainSamples(clusters==k,:);%samples of each cluster
                clusterLabels = labels(clusters==k,:);%lables corresopnd to clusterSamples
                others = clusterSamples(:,:);%others to save all sapmles except the one whichi is analysing
                otherClusterLabels=clusterLabels(:,:);
                for i=1:size(clusterSamples,1) %iteraion over samples of special cluster
                    x = clusterSamples(i,:); %take a sample out
                    trueLabel = labels(i,:); % get the label of that sample 
                    others(i,:) = []; %remove that sample from other samples
                    otherClusterLabels(i,:) = []; %remove label of that sample from other labels
                    moshtagh = d_obj_w(x, others, trueLabel, otherClusterLabels, W(k,:), Beta,centroids(1,k));
                    if (~isempty(moshtagh))
                        Wnew(k,:) = W(k,:)- alpha.*moshtagh;
                    end
                    others = clusterSamples(:,:); %return the omitted sample
                    otherClusterLabels = clusterLabels; %return the omitted label
                end
            end
            %---------------------------update centers-------------------------
            W = Wnew;
            d_obj_c1=zeros(1,size(trainSamples,2));
            for i=1:size(trainSamples,1) %now set new centers
                x = trainSamples(i,:);
                dist= findDistance2Dim(x,centroids,W,2);
                [~,index]=min(dist);
                if(index<=size(centroids,1))
                    out=d_obj_c(x,centroids(index,:),W(index));
                    d_obj_c1=d_obj_c1+out;
                    out=alpha.*d_obj_c1;
                    centroids(index,:)=centroids(index,:)-out;
                end
            end
            [clusters,centroids] = ourKmeans(trainSamples, nbclusters, W, 2, centroids);
        end
        %===============================finish learning========================
    %     X=repmat(testSamples,size(centroids,1),1);
        dists = findDistance2Dim(testSamples,centroids,W,2);
        [te ,index]=min(dists);
        similar = trainSamples(:,clusters==index);
        if(isempty(similar)) %remove any cluster which has no sample
            while(isempty(similar))
                if(index>1 && index< size(centroids,1))
                    centroids=[centroids(1:index-1,:),centroids(index+1:end,:)];
                else
                    centroids=centroids(index+1:end,:);
                end
                dists = findDistance2Dim(testSamples,centroids(:),W,2);
                [te ,index]=min(dists);
                similar = trainSamples(clusters==index,:);
            end
        end
        trainLabels= labels(clusters==index,:);
        estimatedLabel = weightedKNN(testSamples,similar,trainLabels,W,knearest);
        trueLabel=testLabels;
        [F1,precision,recall,accuracy] = measures(testLabels,estimatedLabel);
        F1All=F1All+F1;
        PrecisionAll=PrecisionAll+precision;
        RecallAll=RecallAll+recall;
        AccuracyAll=AccuracyAll+accuracy;
    end
end
% ----------------------------measurement----------------------------------
MeanAcc=(AccuracyAll/TestSampleSize)*100
MeanF1=(F1All/TestSampleSize)*100
MeanPrecision=(PrecisionAll/TestSampleSize)*100
MeanRecall=(RecallAll/TestSampleSize)*100 
