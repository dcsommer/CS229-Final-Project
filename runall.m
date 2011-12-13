'Loading Data'
load 110810a_1m.mat;

REDUCED_DIMENSION = 300;

% convert from cells array to matrix
CHAN_N = length(data);
CHAN_L = length(data{1});

'Normalize Data'
dataM = (reshape(cell2mat(data),CHAN_L,CHAN_N));
dataNorm = (dataM - repmat(mean(dataM),CHAN_L,1)) ./ repmat(std(dataM),CHAN_L,1);
dataNorm = dataNorm'; %Put in format rest of program is expeting
% get peaks
'Getting Peaks'
[PeakIndex, PeakAmp, PeakChannel] = Snip(dataNorm);

% extract features
'Extract Features'
[features] = extract_features(dataNorm, PeakIndex);

[reduced_features] = pca_reduce(features, REDUCED_DIMENSION);
%reduced_features = polyfit_reduce(features, REDUCED_DIMENSION, 30);

% TODO: k-means here
[CenterIds, Centers] = kmeans_cluster(reduced_features);
