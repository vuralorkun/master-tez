function [confedKalman] = adaptiveKalmanFilter (preCentroids,postCentroids,predictedCentroids,count)
           if count > 1
            P=[2,1]
            Q=[5, 5];
            R=0.01;
            confedKalman = configureKalmanFilter('ConstantVelocity', ...
                postCentroids, P , Q , R );
           else
               confedKalman = configureKalmanFilter('ConstantVelocity', ...
                preCentroids, [10, 10], [0.1, 0.1], 0.01);
           end 
end      