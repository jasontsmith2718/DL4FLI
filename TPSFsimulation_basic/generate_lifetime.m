function [tau1, tau2, ratio] = generate_lifetime( image )
% generate random lifetime values for the 28x28 binary image
    
    m = size(image, 1);
    n = size(image, 2);
%     Create randomly generated value matrices for the tau1 and tau2
%     thresholds of interest.
    tau1 = rand(m, n)*.4 + .2; % t1 values between 0.2-0.6
    tau2 = rand(m,n)*.4 + .8; % t2 values between .8-1.2

    tau1 = tau1.*image;
    tau2 = tau2.*image;
    ratio = rand(m, n).*image;
end
