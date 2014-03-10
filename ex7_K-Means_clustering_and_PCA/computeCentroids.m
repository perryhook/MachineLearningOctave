function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returs the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%

% loop over clusters K
%{
for k=1:K,
	
	% The following is an expanded version
	% ksExamples = X(idx==k,:);
	% sizeCk = size(ksExamples,1);		
	% ksum = sum(ksExamples, 1);
	% centroids(k,:) = (1/sizeCk)*ksum;

	centroids(k,:) = (1/size(X(idx==k,:),1))*sum(X(idx==k,:),1);
		
end;
%}

t=cputime;

idxLogical = zeros(K,m);

for k=1:K,
	idxLogical(k,:) = (idx==k);
end;

% slower:
%{
for i=1:m
	idxLogical(idx(i),i)=1;
end;

%}

%numInk = zeros(K,1);
%numInk = sum(idxLogical,2);
%idxLogical(:,idx) = 1;
%sums = idxLogical*X;

centroids = bsxfun(@rdivide, idxLogical*X, sum(idxLogical,2));
printf('Total cpu time: %f seconds\n', cputime-t);
% =============================================================


end

