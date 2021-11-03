clc
clear
cam = webcam();
videoPlayer = vision.VideoPlayer;
% tracks=initializeTracks();
count=1;
detector = peopleDetectorACF();
postCentroids=[0,0];
preCentroids = [0,0];
predictedCentroids = [0,0];
prevP = [2, 1];
prevQ = [5, 5];
prevR = 100;
kalmanFilter = adaptiveKalmanFilter(preCentroids,postCentroids,predictedCentroids,count); 
% frame = snapshot(cam);
%     [bboxes,scores] = detect(detector,frame,'Threshold',0.5);
%     [bboxes, scores] = selectStrongestBbox(bboxes, scores, ...
%                             'RatioType', 'Min', 'OverlapThreshold', 0.6); 
% if isempty(bboxes)
% 	centroids = [];
% else
%     centroids = [(bboxes(:, 1) + bboxes(:, 3) / 2), ...
%                 (bboxes(:, 2) + bboxes(:, 4) / 2)];
%     predictedCentroids = predict(kalmanFilter); 
%     frame = insertObjectAnnotation(frame,'rectangle',bboxes,scores);
% end                       
while 1
    frame = snapshot(cam);
    [bboxes,scores,postCentroids]=detectHuman(detector,frame);   
   
    %predictedCentroids = predict(kalmanFilter);          
    if isempty(bboxes)
        postCentroids = [];
    else
%                 newCentroids = [(bboxes(:, 1) + bboxes(:, 3) / 2), ...
%                 (bboxes(:, 2) + bboxes(:, 4) / 2)];
%                 if exist(predictedCentroids) 
%                   kalmanFilter = adaptiveKalmanFilter(centroids,newCentroids,predictedCentroids);
%                   predictedCentroids = predict(kalmanFilter);
                  if isempty(preCentroids)
                  else    
                     preCentroids  
                    kalmanFilter = adaptiveKalmanFilter(preCentroids,postCentroids,predictedCentroids,count);
                    predictedCentroids=predict(kalmanFilter)
                    bboxes=reconstructBbox(bboxes,predictedCentroids);
                  end  
                  frame = insertObjectAnnotation(frame,'rectangle',bboxes,scores);
                  
%                 end
    end
    step(videoPlayer,frame);
    preCentroids=postCentroids;
    count = count + 1;
end   
 
 
