load 110810a_1m.mat;

REDUCED_DIMENSION = 300;

% convert from cells array to matrix
dataM = zeros(size(data, 1), size(data{1},1));
for i = 1:size(dataM, 1)
  dataM(i,:) = data{1} .';
end

% get peaks
[Data, PeakIndex, PeakAmp, PeakChannel] = Snip(dataM);

% extract features
[features] = extract_features(Data, PeakIndex);

% reduce dimensions of features via PCA
[reduced_features] = pca_reduce(features, REDUCED_DIMENSION);
%% reduce dimensions of featuers by fitting a polynomial
%reduced_features = polyfit(features, REDUCED_DIMENSION);

% TODO: k-means here