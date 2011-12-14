function [reduced_features, topDims] = pca_reduce(features, dims)
[coeff, score] = princomp(features);

% Project each feature onto the top 'dims' principal components to reduce
% the dimension of the features
%topDims = coeff(1:dims, 1:size(coeff,2));
topDims = coeff(:,1:dims);
reduced_features = features * topDims;
