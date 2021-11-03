function [confedKalman] = adaptiveKalmanFilter (preCentroids,postCentroids,predictedCentroids,count)
%            if count > 1
%             P=(predictedCentroids-postCentroids).^2+var(preCentroids)
%             Q=[5, 5];
%             R=1;
%             confedKalman = configureKalmanFilter('ConstantVelocity', ...
%                 postCentroids, P , Q , R );
%            else
               confedKalman = configureKalmanFilter('ConstantVelocity', ...
                preCentroids, [2, 1], [5, 5], 0.1);
%            end 
end      