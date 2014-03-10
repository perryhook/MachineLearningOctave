function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

% Compute Regularized Cost Function J, and do not regularize for theta zero
z = X*theta;
hOfX = sigmoid(z);
regTerm = (lambda/(2*m))*sum(theta(2:length(theta)).^2);
J =-(1/m)*((sum(y.*log(hOfX)+(1-y).*log(1-hOfX))))+regTerm;


% Compute Gradient

% Compute gradient for regularization term
% Do not regularize theta zero
deltaRegTerm = zeros(size(theta));
deltaRegTerm(1)=0;
% Regularize gradient for theta one to theta n
deltaRegTerm(2:length(theta)) = (lambda/m)*theta(2:length(theta));

grad = (1/m)*(hOfX-y)'*X + deltaRegTerm;




% =============================================================

end
