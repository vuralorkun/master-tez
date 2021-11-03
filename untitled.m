clc
clear
detector = peopleDetectorACF();
cam = webcam();
videoPlayer = vision.VideoPlayer;
camHeight=720;
while 1
    frame = snapshot(cam);
    %frame=imresize(frame,1.5);
    [bboxes,scores] = detect(detector,frame,'Threshold',0.5);
    [bboxes, scores] = selectStrongestBbox(bboxes, scores, ...
                            'RatioType', 'Min', 'OverlapThreshold', 0.6);                   
  
    if isempty(bboxes)
        centroids = [];
    else
    %bboxes=prediction(bboxes);
    frame = insertObjectAnnotation(frame,'rectangle',bboxes,scores);
    centroids = [(bboxes(:, 1) + bboxes(:, 3) / 2), ...
                (bboxes(:, 2) + bboxes(:, 4) / 2)]; 
    end
    step(videoPlayer,frame);
    
end    