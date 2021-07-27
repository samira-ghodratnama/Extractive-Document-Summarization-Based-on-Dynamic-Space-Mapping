function [dist]=findDistance2Dim(X,trainSample,W,type)
    dist= zeros(size(trainSample,2),1);
    if type==1
        if(size(X,1)~=0 && size(trainSample,1)~=0)
            for i=1:size(trainSample,1)
                if(~isempty(trainSample(i,:)) && ~isempty(trainSample(i,:))&& i< size(trainSample,1) )
                    f1_train=trainSample(i,:);
                    f1_x=X;
                    dist1=sum(sum(W(1).*(f1_x-f1_train).^2,2));
                   
                    dist(i)=sqrt(dist1);
                end
            end
        end
    elseif  type==2 
       if(size(X,2)~=0 && size(trainSample,1)~=0)
            for i=1:size(trainSample,1)
                if(~isempty(trainSample(i,:)) && ~isempty(trainSample(i,:))&& i< size(trainSample,1))
                    f1_train=trainSample(i,:);
                    f1_x=X;
                    dist1=sum(sum(W(i).*(f1_x-f1_train).^2,2));
                    dist(i)=sqrt(dist1);
                end
            end
        end
    end
end
