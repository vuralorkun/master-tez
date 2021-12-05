function [bboxes] = reconstructBbox(bboxes,centroids)
    for i=1:length(centroids(:,1))
        bboxes(i,:)=[centroids(i,:) - bboxes((4*i-1):(4*i))/2, bboxes((4*i-1):(4*i))];
    end    
end

