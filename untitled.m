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
prevP = [20, 10];
prevQ = [5, 5];
prevR = 100;
kalmanFilter = adaptiveKalmanFilter(preCentroids,postCentroids,prevP,count);

actArray = zeros(1000,2);
estArray = zeros(1000,2);
qVal=zeros(1000,2);
rVal=zeros(1000,1);
Ppred=zeros(1001,2);
Ppred(1,:)=prevP;
Ppred(2,:)=prevP;
K=zeros(1000,1);
C=[1 0 0 0; 0 0 1 0];
[aaa,bbb,K]=correct(kalmanFilter,postCentroids);

K(1,:)=norm(K*C'*(inv(C*K*C'+prevR)));
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
while count <100
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
                    
                    if length(postCentroids(:,1))>length(predictedCentroids(:,1))
                        dummy=length(postCentroids(:,1))-length(preCentroids(:,1));
                        dummy2=length(preCentroids(:,1));
                        for i=1:dummy
                            preCentroids=[preCentroids;postCentroids(i+dummy2,:)];
                        end
                    end
                    if length(postCentroids(:,1))>length(predictedCentroids(:,1))
                        dummy=length(postCentroids(:,1))-length(predictedCentroids(:,1));
                        dummy2=length(predictedCentroids(:,1));
                        for i=1:dummy
                            predictedCentroids=[predictedCentroids;postCentroids(i+dummy2,:)];
                        end
                    end
                    for i=1:length(postCentroids(:,1))
                        [kalmanFilter, qVal(count,:), rVal(count,:)] = adaptiveKalmanFilter(predictedCentroids(i,:),postCentroids(i,:),Ppred(count,:),count);
                        predict(kalmanFilter);
                        [predictedCentroids(i,:),xpred,dummyA]=correct(kalmanFilter,postCentroids(i,:));
                        dummy=norm(dummyA);
                        Ppred(count+1,1)=dummy;
                        Ppred(count+1,2)=1;
                        count = count + 1;
                        actArray(count,:)=postCentroids(i,:);
                        estArray(count,:)=predictedCentroids(i,:);
                        Kvec=dummyA*C'*(inv(C*dummyA*C'+rVal(count,:))); %Pk*H'*(inv(H*Pk*H'+R))
                        K(count,:)=norm(Kvec);
                    end
                    predictedCentroids;
                    bboxes;
                    bboxes=reconstructBbox(bboxes,predictedCentroids);
                    
                    
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
 
