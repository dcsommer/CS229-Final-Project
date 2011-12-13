% 'dims' is the degree of each polynomial we fit, so the total end
% result is a (n+1)*60 dimension training example
[reduced_features] = polyfit_reduce(input, dims)
reduced_features = zeros(size(input,1), dims);
for i=1:size(input,1)
  for j=0:(size(input,2)/30 - 1)
    reduced_features(i,(j*dim + 1):((j+1)*dim) =
      polyfit(input(i,((j*30 + 1):((j+1)*30))), dims);
  end
end
