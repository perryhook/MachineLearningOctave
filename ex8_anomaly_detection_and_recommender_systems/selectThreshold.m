function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

m = size(yval);

stepsize = (max(pval) - min(pval)) / 1000;
%tic;
for epsilon = min(pval):stepsize:max(pval)
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions

predictions = (pval < epsilon);

%{
% loop over the cases to get truePositive,
% falsePositive, and falseNegative. SLOW

truePositive = 0;
falsePositive = 0;
falseNegative = 0;

for i=1:m,
	
	% true positive
	if ((yval(i) == 1) &&	(predictions(i) == 1)),
		truePositive = truePositive + 1;
	% falsePositive	
	elseif ((yval(i) == 0) && (predictions(i) == 1)),
		falsePositive = falsePositive + 1;
	% falseNegative
	elseif ((yval(i)==1) && (predictions(i) == 0)),
		falseNegative = falseNegative + 1;
	end

end
precision = truePositive /(truePositive + falsePositive);

recall = truePositive / (truePositive + falseNegative);
%}

% or this FASTER vectorized version using 
% logical arrays.  Note the single '&' 
% which is the element-wise logical AND operator.

truePositive2 = sum((predictions == 1) & (predictions == yval));
falsePositive2 = sum((predictions == 1) & (yval == 0));
falseNegative2 = sum((predictions == 0) & (yval == 1));


precision = truePositive2 /(truePositive2 + falsePositive2);

recall = truePositive2 / (truePositive2 + falseNegative2);



F1 = 2*((precision*recall)/(precision+recall));



    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end
%disp(toc);
end
