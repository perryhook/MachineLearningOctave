function distance = squaredDistance(x1,x2)
%SQUAREDDISTANCE computes the squared distance 
% ||x2-y(i)||^2 between the two vectors x1 and x2

distance = sum((x1-x2).^2);
