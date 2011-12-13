function [CenterIds, Centers] = gmeans_cluster(features)
alpha = 0.0001;
crit = 4; %for alpha = 0.0001, critical point is 1.8692
oldk = 1;
k = 16;
n = size(features, 1);
[CenterIds, Centers] = kmeans(features, k);

while oldk ~= k && k < 100 % can't reliably measure differences b/w >100 cells
  oldk = k;
  for i=1:size(Centers,1)
    fprintf('checking center %d of %d\n', i, size(Centers,1))
    is = features(CenterIds == i,:);
    if (size(is, 1) < 2)
      continue;
    end
    % do sub-split to 2 clusters
    [CenterIds2, Centers2] = kmeans(is, 2);
    v = Centers2(1,:)' - Centers2(2,:)';
    % project features onto v
    XPrime = features * v / norm(v)^2;
    XPrimeNorm = (XPrime - mean(XPrime)) / std(XPrime);
    Z = max(.000001, min(.999999, normcdf(XPrimeNorm, 0, 1)));
    
    A2Z = -n;
    for j=1:n
      A2Z = A2Z + (2*j - 1)*(log(Z(j)) + log(1 - Z(n+1-j)));
    end
    A2Z = -A2Z / n;
    A2SZ = A2Z*(1 + 4/n - 25/n^2);
    if A2SZ > crit
      k = k+1; % reject null hypothesis, there should be 2 clusters
    end
  end
  fprintf('reclustering with %d centers\n', k)
  [CenterIds, Centers] = kmeans(features, k);
end
