function X_rec = recoverData(Z, U, K)
%RECOVERDATA Recovers an approximation of the original data when using the 
%projected data
%   X_rec = RECOVERDATA(Z, U, K) recovers an approximation the 
%   original data that has been reduced to K dimensions. It returns the
%   approximate reconstruction in X_rec.
%

m = size(Z,1);

J = size(U,1);

% You need to return the following variables correctly.
X_rec = zeros(m, J);

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the approximation of the data by projecting back
%               onto the original space using the top K eigenvectors in U.
%
%               For the i-th example Z(i,:), the (approximate)
%               recovered data for dimension j is given as follows:
%                    v = Z(i, :)';
%                    recovered_j = v' * U(j, 1:K)';
%
%               Notice that U(j, 1:K) is a row vector.
%               

% i think you might need to invert these nested loops or something

		% disp('J') ;
		% disp(J) ;




%{for i=1:m,
	
	for j=1:J,
		
		z = Z(i, :)' ;
%		disp('size z:') ;
%		disp(size(z)) ;

		% Notice that U(j, 1:K) is a row vector
		%xapprox = z' * U(j, 1:K)' ;	

%		disp('U reduce?');
%		disp(U(j, 1:K)) ;
		x_approx = U(j,1:K) * z ;
		X_rec(i,j) = x_approx ;


	end ;


end ;
%}

%UreduceAll = U(:,1:K) ;
disp('UreduceAll:') ;

output = UreduceAll * Z' ;
disp('size of output:') ;
disp(output) ;

% using num2Cell() and cellfun() and celltomat()
% IN PROGRESS See bookmark
%{
Z2c = num2cell(Z,K) ;
disp('Z to cell') ;
disp(Z2c);
U2c = num2cell(U,K) ;
disp('U to cell') ;
disp(U2c);
%}


% =============================================================

end
