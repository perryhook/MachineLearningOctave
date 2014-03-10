function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);
%disp(Theta);
            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%

% COST FUNCTION
% is there a way to make this more vectorized?

% VECTORIZED UNCOMPRESSED
%{
%tic;
% this is (in math-speak) (Theta')*X
predictions =X*(Theta');

% mult by R matrix (binary indicator, 1=reviewed)
error = predictions-Y;
squaredError = error.^2;
summation = sum(sum(R.*squaredError));
J = 0.5*summation;
%toc;
%}

% VECTORIZED compressed
%{
%tic;
J = 0.5*sum(sum( R.*(( (X*(Theta')) - Y ).^2) ) );
%toc;
%}

% VECTORIZED half-compressed 
% (keep error for gradient)
%%{
%tic;
error = (X*(Theta'))-Y;
Theta_reg_term = (lambda/2)*sum(sum(Theta.^2));
X_reg_term = (lambda/2)*sum(sum(X.^2));

J = (0.5*sum(sum( R.*(error.^2) ) ))+Theta_reg_term+X_reg_term;
%toc;
%}


%{
% NOT VECTORIZED
% sum is the squared error of ratings predicted
% by the model and actual ratings
%tic;
ratingsSum = 0;

% double loop over the R matrix

% loop over i movies
for i=1:size(R,1),
	
	% loop over j users
	for j=1:size(R,2),
%		disp('you are in loop (i,j)');
%		disp([i,j]);

		if R(i,j),
%			disp('movie is rated');
			
			% this is equivalent to 
			% "Theta(j) transpose dot product x(i)"
			% but looks different because of how 
			% Theta and X are constructed
			predicted = (Theta(j,:)*(X(i,:)'));
			squaredError = (predicted-Y(i,j))^2 ;
			ratingsSum = ratingsSum +squaredError;

%			disp('predicted:');
%			disp(predicted);
%			disp('actual:');
%			disp(Y(i,j));
%			disp('squaredError:');
%			disp(squaredError);
%			disp('ratingsSum:');
%			disp(ratingsSum);
		end
	end
end
% J is cost
J = 0.5*ratingsSum;
%toc;
%}

%{
disp('Theta size');
disp(size(Theta));
disp('X size');
disp(size(X));
disp('Y size');
disp(size(Y));
disp('error size');
disp(size(error));
disp('R size:');
disp(size(R));
%}

% Calculate gradients
% perhaps this way makes too many calculations
% while still being better than looped versions
% still seems to be fastest

% zero-out non rated combinations of users/movies
error = R.*error;
% regularization terms
X_grad_reg_term = lambda*X;
Theta_grad_reg_term = lambda*Theta;

X_grad = error*Theta + X_grad_reg_term;
Theta_grad = (error')*X + Theta_grad_reg_term;


% can I do better, ala prof Ng's suggestion to use 
% find(R==1) ????????
%  I was able to make it work for X_grad, but not for Theta_grad.  I just can't figure it out.  Mine (above) is faster anyway I think.
%{
for i=1:num_movies,
	idx = find(R(i,:)==1);
%	disp('idx');
%	disp(idx);
	Theta_temp = Theta(idx,:);
	Y_temp=Y(i,idx);
	new_error = (X(i,:) * Theta_temp' - Y_temp);	
	X_grad(i,:) = new_error * Theta_temp;
end
%}

%=============================================================

grad = [X_grad(:); Theta_grad(:)];

end
