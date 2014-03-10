function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%

inputLayer = [ones(size(X(:,1))),X];
hiddenLayer = sigmoid(inputLayer*Theta1');
hiddenLayer = [ones(size(hiddenLayer(:,1))),hiddenLayer];
outputLayer = sigmoid(hiddenLayer*Theta2');
[val, p] = max(outputLayer,[],2);


%disp(X(1:10,:));
%disp(size(X));
%disp(size(ones(size(X(:,1)))));
%disp(size(inputLayer));
%disp(inputLayer([1:10],1));
%disp(size(outputLayer));
%disp(size(p));

%  The testing script doesn't actually say 0, it says 10, while it counts that as a correct prediction.  If you use the following line of code, it switches 10s to 0s, but the accuracy "goes down".  Confusing.  Leave it out, enforcing convention that 10 is really 0.
%p(p==10) = 0;
	







% =========================================================================


end
