function [confedKalman] = adaptiveKalmanFilter (postCentroids,preCentroids,count)
           if count == 1
            P=[2,1];
            Q=[5, 5];
            R=0.01;
            confedKalman = configureKalmanFilter('ConstantVelocity', ...
                postCentroids, P , Q , R );
           else
               
            Q=[abs((var([preCentroids postCentroids]))+0.01) 1].*10;
            R=rand(1)*0.1;
               confedKalman = configureKalmanFilter('ConstantVelocity', ...
                postCentroids, [2, 1], Q, R);
           end 
end      