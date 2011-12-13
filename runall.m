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
'Get Peaks'
[PeakIndex, PeakAmp, PeakChannel] = Snip(dataNorm,10);

% extract features
'Extract Features'
[features] = extract_features(dataNorm, PeakIndex);

% reduce dimensions of features via PCA
'PCA Reduce'
[reduced_features, coeff] = pca_reduce(features, REDUCED_DIMENSION);
%% reduce dimensions of featuers by fitting a polynomial
%reduced_features = polyfit(features, REDUCED_DIMENSION,30);

'Clustering'
[CenterIds, Centers] = gmeans_cluster(reduced_features);
