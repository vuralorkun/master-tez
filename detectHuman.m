function [bboxes,scores,centroids] = detectHuman(detector,frame)
    [bboxes,scores] = detect(detector,frame,'Threshold',0.5);
    [bboxes, scores] = selectStrongestBbox(bboxes, scores, ...
                            'RatioType', 'Min', 'OverlapThreshold', 0.6);
    centroids = [(bboxes(:, 1) + bboxes(:, 3) / 2), ...
                 (bboxes(:, 2) + bboxes(:, 4) / 2)];                    
end

