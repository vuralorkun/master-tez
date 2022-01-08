function [newCentroids] = deleteExtraCentroids(preCentroids,postCentroids)
    if isempty(preCentroids)
        newCentroids=preCentroids;
    else if(length(preCentroids(:,1))-length(postCentroids(:,1))>0)  
        newCentroids = zeros(length(postCentroids(:,1)),2);
        for i = 1:length(postCentroids(:,1))
            [~,index] = min(abs(preCentroids - postCentroids(i)));
            newCentroids(i,:) = preCentroids(index(1),index(2));
        end
    else  
        newCentroids=preCentroids;
    end
end

