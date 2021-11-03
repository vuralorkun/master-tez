function [bboxes] = reconstructBbox(bboxes,centroids)
    bboxes=[centroids - bboxes(3:4)/2, bboxes(3:4)];
end

