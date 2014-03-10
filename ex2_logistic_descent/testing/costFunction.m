function[jVal, gradient] = costFunction(theta)

%cost function J(theta)
jVal = (theta(1)-5)^2 + (theta(2)-5)^2;  

%partial derivatives
gradient = zeros(2,1);
gradient(1) = 2*(theta(1)-5);
gradient(2) = 2*(theta(2)-5);
