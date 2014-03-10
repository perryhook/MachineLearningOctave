function [error_train_avg, error_val_avg] = ...
    randoLearningCurve(X, y, Xval, yval, lambda, selectionPercent, numberTests)
%LEARNINGCURVE Generates the train and cross validation set errors needed 
%to plot a learning curve
%   [error_train, error_val] = ...
%       LEARNINGCURVE(X, y, Xval, yval, lambda) returns the train and
%       cross validation set errors for a learning curve. In particular, 
%       it returns two vectors of the same length - error_train and 
%       error_val. Then, error_train(i) contains the training error for
%       i examples (and similarly for error_val(i)).
%
%   In this function, you will compute the train and test errors for
%   dataset sizes from 1 up to m. In practice, when working with larger
%   datasets, you might want to do this in larger intervals.
%
% You need to return these values correctly
m = length(y);
nSelected = ceil(m*selectionPercent);
error_train = zeros(m, numberTests);
error_val   = zeros(m, numberTests);



% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return training errors in 
%               error_train and the cross validation errors in error_val. 
%               i.e., error_train(i) and 
%               error_val(i) should give you the errors
%               obtained after training on i examples.
%
% Note: You should evaluate the training error on the first i training
%       examples (i.e., X(1:i, :) and y(1:i)).
%
%       For the cross-validation error, you should instead evaluate on
%       the _entire_ cross validation set (Xval and yval).
%
% Note: If you are using your cost function (linearRegCostFunction)
%       to compute the training and cross validation error, you should 
%       call the function with the lambda argument set to 0. 
%       Do note that you will still need to use lambda when running
%       the training to obtain the theta parameters.
%
% Hint: You can loop over the examples with the following:
%
%       for i = 1:m
%           % Compute train/cross validation errors using training examples 
%           % X(1:i, :) and y(1:i), storing the result in 
%           % error_train(i) and error_val(i)
%           ....
%           
%       end
%

% ---------------------- Sample Solution ----------------------
for j = 1: numberTests,
	% loop over size of training set
	for i = 1:nSelected,
	randTrainIndices = randomIndicesNR(length(y),selectionPercent);
	X_random = zeros(nSelected,size(X)(2));
	y_random = zeros(nSelected,1);

% Loop that finds nSelected examples and puts them in X_random and y_random
for i=1:nSelected,

	X_random(i,:)=X(randTrainIndices(i),:);
	y_random(i)=y(randTrainIndices(i));

	Xval_random(i,:)=Xval(randTrainIndices(i),:);
	yval_random(i)=yval(randTrainIndices(i));




end




		%for each size of training set, learn theta
		theta =	trainLinearReg(X_random(1:i,:),y_random(1:i),lambda);

		% compute error_train for randomized training set with size 1i
		error_train(i,j) = linearRegCostFunction(X_random(1:i,:), y_random(1:i), theta, 0);
	
		% compute validation error over randomized validation set
		error_val(i,j) = linearRegCostFunction(Xval_random,yval_random', theta, 0);
	

	end
end

error_train_avg = sum(error_train,2)/numberTests;
error_val_avg = sum(error_val,2)/numberTests;



% -------------------------------------------------------------

% =========================================================================

end
