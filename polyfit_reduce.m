% 'dims' is the degree of each vpolynomial we fit, so the total
% end result is a ('dims'+1)*60 dimension training example
% samples_per is the number of samples per spike per channel
% (30 as of this writing)
function [reduced_features] = polyfit_reduce(input, poly_dims, samples_per)
poly_dims = (poly_dims / 60) - 1; %end with poly_dims number of dims
DimsFrom = 1:samples_per;
reduced_features = zeros(size(input,1), (size(input,2) / samples_per) * (poly_dims+1));
for i=1:size(input,1)
  for j=1:(size(input,2)/samples_per)
     WriteTo = ((j-1)*(poly_dims + 1) + 1):(j*(poly_dims+1));
     FitFrom = input(i,(((j-1)*samples_per + 1):(j*samples_per)));
     Fit = polyfit(DimsFrom, FitFrom ,poly_dims);
     reduced_features(i,WriteTo) = Fit;
  end
end
