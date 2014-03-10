function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% Set m
m = size(X,1);

% You need to return the following variables correctly.
idx = zeros(m, 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%

% loop over m training examples
for i=1:m,

	% initialize lowestDistance to 
	% squaredDistance(X(i,:), centroids(1,:))];
	distance = squaredDistance(X(i,:), centroids(1,:));
	lowestDistance = distance;
	idx(i)=1;

	% loop over K centroids
	for k=2:K,
		
		% calculate distance to each centroid, if
		% distance is lower than current min, stored
		% in idx(k) then update idx(k) to new min.
		distance = squaredDistance(X(i,:), centroids(k,:));

		% if distance is equal, pick a random
		% centroid of the two, otherwise if 
		% distance < lowestDistance, update
		% lowestDistance<-distance  and idx(i)<-k
		if ((distance == lowestDistance) && (round(rand()) == 1)) || (distance < lowestDistance),

			lowestDistance = distance;
			idx(i)=k;
		end;

	end;
	
end;


% =============================================================

end

