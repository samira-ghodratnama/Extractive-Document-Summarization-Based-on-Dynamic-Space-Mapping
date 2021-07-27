function [F1,precision,recall,accuracy] = measures(trueLable,estimatedLabel)
    if(size(estimatedLabel,2) ~=0) %if it could estimate any label
            precision=size(intersect(trueLable,estimatedLabel),2)/size(estimatedLabel,2);
            recall=size(intersect(trueLable,estimatedLabel),2)/size(trueLable,2);
            accuracy=size(intersect(trueLable,estimatedLabel),2)/size(union(trueLable,estimatedLabel),2);
            if(precision~=0 && recall~=0)
                F1=(1/precision)+(1/recall);
                F1=2/F1;
            else
                F1=0;
            end
    else
        F1=0;
        precision=0;
        recall=0;
        accuracy=0;
    end
end