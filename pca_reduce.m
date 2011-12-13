function [reduced_features] = pca_reduce(features, dims)
[coeff, score] = princomp(features)

% Project each feature onto the top 'dims' principal components to reduce
% the dimension of the features
topDims = coeff(1:dims, size(coeff,2));
reduced_features = features * topDims';