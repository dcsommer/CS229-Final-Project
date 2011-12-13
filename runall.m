%% Parameters
filename = '110810a_1m.mat';
SMOOTH_POINTS = 7;
REDUCED_DIMENSION = 300;
GMEANS_CRIT = 7; %for alpha = 0.0001, critical point is 1.8692

%% Pipeline
disp '------Format Data------'
[dataNorm] = data_format(filename,SMOOTH_POINTS);

% get peaks
disp '------Get Peaks------'
[PeakIndex, PeakAmp, PeakChannel] = Snip(dataNorm,10);

% extract features
disp '------Extract Features----'
[features] = extract_features(dataNorm, PeakIndex);

% reduce dimensions of features via PCA
disp '------PCA Reduce------'
[reduced_features, coeff] = pca_reduce(features, REDUCED_DIMENSION);
%% reduce dimensions of featuers by fitting a polynomial
%reduced_features = polyfit(features, REDUCED_DIMENSION,30);

disp '-----Clustering-----'
[CenterIds, Centers] = gmeans_cluster(reduced_features, GMEANS_CRIT);

