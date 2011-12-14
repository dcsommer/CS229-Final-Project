function [dataNorm] = data_format(filename,smooth_points)
%Get Data
fprintf('Loading %s => Smoothing with %d points\n', filename, smooth_points);
V = load(filename);

% convert from cells array to matrix
CHAN_N = length(V.data);
CHAN_L = length(V.data{1});

disp 'Format Data'
%Format Data In Correct Matrix Format
dataM = (reshape(cell2mat(V.data),CHAN_L,CHAN_N));

disp 'Smooth Data'
dataSmooth = dataM;
%Smooth Data
for i=1:CHAN_N
   dataSmooth(:,i) = smooth(dataM(:,i), smooth_points);
end

disp 'Normalize Data'
%Normalize - zero mean and 1 std
dataNorm = (dataSmooth - repmat(mean(dataSmooth),CHAN_L,1)) ./ repmat(std(dataSmooth),CHAN_L,1);
dataNorm = dataNorm'; %Put in format rest of program is expeting