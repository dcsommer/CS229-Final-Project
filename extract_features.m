function [features] = extract_features(data, peaks)
left = 21;
right = 8;
numChannels = size(data, 1);
numPeaks = size(peaks, 2);
featureDim = numChannels * (left + right + 1);
features = zeros(numPeaks, featureDim);
for i=1:(numPeaks)
  leftBound = peaks(i)-left;
  rightBound = peaks(i)+right;
  event = data(:, leftBound:rightBound);
  event = event - repmat(mean(event,2),1,left+right+1);
  features(i,:) = reshape(event', numChannels * (rightBound - leftBound + 1), 1);
end

fprintf('Extracted %d Featured!\n', numPeaks);