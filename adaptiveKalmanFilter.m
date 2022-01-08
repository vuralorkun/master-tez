function [confedKalman,Q,R] = adaptiveKalmanFilter (postCentroids,predictedCentroids,P,count)
           if count == 1
            P=[20,10];
            Q=[5, 5];
            R=0.01;
            confedKalman = configureKalmanFilter('ConstantVelocity', ...
                postCentroids, P , Q , R );
           else
               
            Q=[abs((var([predictedCentroids postCentroids]))/1024+0.01) 1];
            R=abs((predictedCentroids(1)-postCentroids(1))/2048)+abs((predictedCentroids(2)-postCentroids(2))/2048)+0.01;
               confedKalman = configureKalmanFilter('ConstantVelocity', ...
                postCentroids, P, Q, R);
           end 
end      