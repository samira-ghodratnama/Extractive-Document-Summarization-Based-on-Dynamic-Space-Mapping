% function [clusterLabels, centroids] = ourKmeans(samples, k, W, type, C)
%     -----------------centroid is random or is defined---------------------
%     if type==1
%         centerIndex= randperm(size(samples,1));
%         centroids = samples(centerIndex(1:k),:);
%     else
%         centroids = C;
%     end
%     ----------------------------------------------------------------------
%     clusterLabels = -1.*ones(1,size(samples,1));
%     newClusterLabels = -1.*ones(1,size(samples,1));
%     change_clusters=ones(1,k);
%     before_cluster=zeros(1,k);
%     counter = 0;
%     while counter<20
%         while ( sum(change_clusters ~= before_cluster) > 0)
%             clusterLabels = newClusterLabels;
%             newClusterLabels = zeros(1,size(samples,1));
%             for i=1:size(samples,1)
%                 newClusterLabels(i) =findDistance(samples(i), W,centroids);
%             end
%             -----------------------update centers-----------------------------
%             update centers
%             for i=1:k
%                 clusterSamples = samples(newClusterLabels==i,:);
%                 if(size(clusterSamples,2)>0)
%                     centroids(i,:) = mean(clusterSamples);
%                 end
%             end
%         end
%          counter = counter+1;
%     end
% end
% 
% function distance = findDistance(image, W,centroids)
%     for i = 1: size(centroids,2)
%         if(~isempty(centroids(i)))
%             dists(i)=sum(sum(W(i).*((abs(image-centroids(i))).^2),2),1);
%         end
%     end
%     [~,distance] = min(dists);
% end
% 
% function [Feature1] = findMean(clusterSamples)
%     if(size(clusterSamples,2)>0)
%         Feature1=clusterSamples(1);
%         for i = 2: size(clusterSamples,2)
%             Feature1 =Feature1+clusterSamples(i);
%         end
%         Feature1=Feature1./size(clusterSamples,2);
%     end
% end


function [clusterLabels, centroids] = ourKmeans(samples, k, W, type, C) %Note: without labels
    
    if type==1
        centerIndex= randperm(size(samples,1));
        centroids = samples(centerIndex(1:k),:);
    else
        centroids = C;
    end
    clusterLabels = zeros(1,size(samples,1));
    newClusterLabels = -1.*ones(1,size(samples,1));
    counter = 0;

        while (sum(newClusterLabels ~= clusterLabels) > 0 && counter<50 )
            clusterLabels = newClusterLabels;
            newClusterLabels = zeros(1,size(samples,1));
            for i=1:size(samples,1)
%                 X = repmat(samples(i,:),k,1);
                X=samples(i,:);
                dists= findDistance(X, W,centroids);
                [~,newClusterLabels(i)] = min(dists);
            end
            %update centers
            for i=1:k
                clusterSamples = samples(newClusterLabels==i,:);
                centroids(i,:) = mean(clusterSamples);
            end
        end
        counter = counter+1;
end
function distance = findDistance(sample, W,centroids)               
    for i = 1: size(centroids,1)
        if(~isempty(centroids(i)))
            dists = sum(sum(W(i).*(sample-centroids(i)).^2 , 2 ));
            distance(i)=dists;
%             dists(i)=sum(sum(W(i).*((abs(sample-centroids(i))).^2),2),1);
        end
    end
%     [~,distance] = min(dists);
end
