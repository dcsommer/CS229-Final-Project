[reduced_features] = polyfit_reduce(input_features, dims)
reduced_features = zeros(size(input_features,1), dims);
for i=1:size(input_features,1)
  reduced_features(i,:) = polyfit(input_features(i,:), dims);
end
