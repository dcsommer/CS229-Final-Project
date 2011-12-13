% 'dims' is the degree of each polynomial we fit, so the total
% end result is a ('dims'+1)*60 dimension training example
% samples_per is the number of samples per spike per channel
% (30 as of this writing)

[reduced_features] = polyfit_reduce(input, dims, samples_per)
reduced_features = zeros(size(input,1), dims);
for i=1:size(input,1)
  for j=0:(size(input,2)/samples_per - 1)
    reduced_features(i,(j*dim + 1):((j+1)*dim) =
      polyfit(input(i,((j*samples_per + 1):((j+1)*samples_per))), dims);
  end
end
