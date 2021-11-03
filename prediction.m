function [centroids,predictedCentroids] = prediction(po,kalmanFilter)
 
            predictedCentroids = predict(kalmanFilter);
    
end

