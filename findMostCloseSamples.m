function  out=findMostCloseSamples(label,labels)
    count=1;
    flag=false;
    out=[];
    array2=label;
    for i=1:size(labels,2)
        array1=labels(i);
        if (size(intersect(array1,array2),2)==1)
            out(count)=i;
            count=count+1;
            flag=true;
        end
    end
end