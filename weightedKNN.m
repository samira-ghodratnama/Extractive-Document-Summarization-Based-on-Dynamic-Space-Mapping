function [label]=weightedKNN(testSample,trainSample,trainLabel,W,knearest)
    label=[];
    if(knearest==1)
        dist = findDistance2Dim(testSample,trainSample,W,1);
        [~,index]=min(dist);
        label=trainLabel(index);
%     elseif(knearest==3)
%         X=repmat(testSample,size(trainSample,2),1);
%         dist = findDistance2Dim(X,trainSample,W,1);
%        
%         for i=1:size(trainSample,2)
%             dist(i)=findDistance2Dim(testSample,trainSample(i),W,1);
%         end
%         [m mi] = sort(dist);
%         lowest5index = mi(1:3);
%         AllLabels=[cell2mat(trainLabel(lowest5index(1))),cell2mat(trainLabel(lowest5index(2))),cell2mat(trainLabel(lowest5index(3)))];
%         [count,numbers]=hist(AllLabels,unique(AllLabels));
%         for i=1:size(count,2)
%             if(count(1,i)>1)
%                 label=[label,numbers(1,i)];
%             end
%         end
%         if(isempty(label))
%             b=randperm(3);
%             label=cell2mat(trainLabel(lowest5index(b(1,1))));
%         end
%         label=label;
%     elseif(knearest==5)
%         X=repmat(testSample,size(trainSample,2),1);
%         dist = findDistance2Dim(X,trainSample,W,1);
%         [m mi] = sort(dist);
%         lowest5index = mi(1:5);
%         AllLabels=[cell2mat(trainLabel(lowest5index(1))),cell2mat(trainLabel(lowest5index(2))),cell2mat(trainLabel(lowest5index(3))),cell2mat(trainLabel(lowest5index(4))),cell2mat(trainLabel(lowest5index(5)))];
%         [count,numbers]=hist(AllLabels,unique(AllLabels));
%         for i=1:size(count,2)
%             if(count(1,i)>2)
%                 label=[label,numbers(1,i)];
%             end
%         end
%         if(isempty(label))
%             b=randperm(5);
%             label=cell2mat(trainLabel(lowest5index(b(1,1))));
%         end
%         label=label;
%     end
end