function  out=findMostDifferSamples(label,labels)
    count=1;
    flag=false;
    out=[];
    xi=label;
    array2=label;
    %-----------------------------------------------------------
    
        for i=1:size(labels,2)
            candidate_sample=labels(:,i);
            if (size(intersect(candidate_sample,xi),2)==1)
                out(count)=i;
                count=count+1;
                flag=true;
            end
        end
  
    %-----------------------------------------------------------

end
