function Z = projectData(X, U, K)
%PROJECTDATA Computes the reduced data representation when projecting only 
%on to the top k eigenvectors
%   Z = projectData(X, U, K) computes the projection of 
%   the normalized inputs X into the reduced dimensional space spanned by
%   the first K columns of U. It returns the projected examples in Z.
%

m = size(X,1) ;

% You need to return the following variables correctly.

Z = zeros(m, K) ;

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the projection of the data using only the top K 
%               eigenvectors in U (first K columns). 
%               For the i-th example X(i,:), the projection on to the k-th 
%               eigenvector is given as follows:
%                    x = X(i, :)' ;
%                    projection_k = x' * U(:, k) ;
%

% loop through the examples
for i=1:m,
	
	%	grab an example
	% NOTE I removed the Transpose off the X(i,:)
	% here and off the x in the inner loop
	% before removal, this was x = X(i,:)' ;
	x = X(i,:) ;

	% loop through the U vectors
	for k=1:K,
		
		%	project x example onto u
		% NOTE I removed the Transpose off the x both
		% here and in the outer loop, before removal,
		% this was z = x' * U(:, k) ;
		z = x * U(:, k) ;
	
		% add projection into reduced-D representation
		Z(i,k) = z ;

	end

end


% =============================================================

end
