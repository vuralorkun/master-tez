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
kalmanFilter = adaptiveKalmanFilter(preCentroids,postCentroids,count); 
actArray = zeros(50,2);
estArray = zeros(50,2);
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
while count <50
    frame = snapshot(cam);
    [bboxes,scores,postCentroids]=detectHuman(detector,frame);  
    preCentroids=deleteExtraCentroids(preCentroids,postCentroids);
        
        
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
                    postCentroids;
                    predictedCentroids = [0,0];
                    
                    for i=1:length(postCentroids(:,1))
                        kalmanFilter = adaptiveKalmanFilter(predictedCentroids(i,:),postCentroids(i,:),2);
                        predict(kalmanFilter);
                        predictedCentroids(i,:)=correct(kalmanFilter,preCentroids(i,:));
                    end
                    predictedCentroids;
                    bboxes;
                    bboxes=reconstructBbox(bboxes,predictedCentroids);
                    actArray(count,:)=postCentroids;
                    estArray(count,:)=predictedCentroids;
                    count = count + 1;
                  end  
                
%                   for j=1:length(bboxes(:,1))
%                     if ()  
                    frame = insertObjectAnnotation(frame,'rectangle',bboxes,scores);
                  
%                 end
    end
    step(videoPlayer,frame);
    preCentroids=postCentroids;
    
    
end   

plot(actArray(1),actArray(2));
hold on
plot(estArray(1),estArray(2));
plot()
 
