function [random_indices] = randomIndicesNR(m, selectionPercent)
%{ RANDOMINDICESNR Generates a vector random_indices
%	that contains a subset of indices selected from  
%	{1,2,...,m} with size=selectionPercent*m, rounded
%	to the nearest whole number.  This subset does
% not repeat (NonRepeating) indices in random_indices.
%}

indices = [1:m];
nSelected = ceil(m*selectionPercent);

random_indices = zeros(nSelected,1);

% Loop that finds nSelected examples and puts them in X_random and y_random
for i=1:nSelected,
%	disp("i=");
%	disp(i);
	% While loop tests if next index has been chosen yet
	while random_indices(i)==0,
%		disp("randomIndices(i)=");
%		disp(randomIndices(i));
		randomIndex = ceil(m*rand());
%		disp("Testing: ");
%		disp(randomIndex);
%		disp("With Value: ");
%		disp(indices(randomIndex));
		value = indices(randomIndex);
		random_indices(i)=value;
		indices(randomIndex) = 0;
	end
	
end


end
