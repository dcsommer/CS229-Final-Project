load 041111_0a_1m.mat;

% convert from cells array to matrix
dataM = zeros(size(data, 1), size(data{1},1));
for i = 1:size(dataM, 1)
  dataM(i,:) = data{1} .';
end

% get peaks
[Data, PeakIndex, PeakAmp, PeakChannel] = Snip(dataM);

% extract features
[features] = extract_features(data, peaks);

% run PCA to find principal components
[coeff, score] = princomp(features);

% Project each feature onto the top 300 principal components to reduce
% the dimension of the features
REDUCED_DIMENSION = 300;
topDims = coeff(1:REDUCED_DIMENSION, size(coeff,2));
featuresReduced = features * topDims';

