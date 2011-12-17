%% Parameters
filename = '110810a_1m.mat';
SMOOTH_POINTS = 7;
REDUCED_DIMENSION = 180;
GMEANS_CRIT = 7; %for alpha = 0.0001, critical point is 1.8692
MAX_CLUSTERS = 20; % can't reliably measure differences b/w >100 cells
SNIP_THRESH = 7;

LEFT = 21;
RIGHT = 8;

FULL_PIPE = 1; %Set to one to extract data too
PCA = 1;


%% Pipeline
if(FULL_PIPE == 1)
disp '------Format Data------'
[dataNorm] = data_format(filename,SMOOTH_POINTS);

% get peaks
disp '------Get Peaks------'
[PeakIndex, PeakAmp, PeakChannel] = Snip(dataNorm,SNIP_THRESH);

% extract features
disp '------Extract Features----'
[features] = extract_features(dataNorm, PeakIndex, LEFT, RIGHT);
end

% reduce dimensions of features via PCA
if(PCA==1)
    disp '------PCA Reduce------'
    [reduced_features, coeff] = pca_reduce(features, REDUCED_DIMENSION);
else 
    %% reduce dimensions of features by fitting a polynomial
    disp '------PolyFit Reduce ------'
    reduced_features = polyfit_reduce(features, REDUCED_DIMENSION,30);
end
disp '-----Clustering-----'
[CenterIds, Centers] = gmeans_cluster(reduced_features, GMEANS_CRIT, MAX_CLUSTERS);
