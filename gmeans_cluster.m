function [CenterIds, Centers, ks, means] = gmeans_cluster(features, crit, maxClusters)
oldk = 1;
k = 16;
fprintf('Initial cluster with %d centers\n', k);
[CenterIds, Centers] = kmeans(features, k);

a=1;
while oldk ~= k && k < maxClusters
  oldk = k;
  A2SZ = zeros(size(Centers,1), 1);
  for i=1:size(Centers,1)
    %fprintf('checking center %d of %d\n', i, size(Centers,1))
    is = features(CenterIds == i,:);
    if (size(is, 1) < 2)
      continue;
    end
    % do sub-split to 2 clusters
    [~, Centers2] = kmeans(is, 2);
    v = Centers2(1,:)' - Centers2(2,:)';
    % project features of data subset onto v
    XPrime = is * v / norm(v)^2;
    XPrimeNorm = (XPrime - mean(XPrime)) / std(XPrime);
    Z = max(.00000001, min(.99999999, normcdf(XPrimeNorm, 0, 1)));
    
    n = size(is, 1);
    sum = 0;
    for j=1:n
      sum = sum + (2*j - 1)*(log(Z(j)) + log(1 - Z(n+1-j)));
    end
    A2Z = -n - sum/n;
    A2SZ(i) = A2Z*(1 + 4/n - 25/n^2);
    if A2SZ(i) > crit
      k = k+1; % reject null hypothesis, there should be 2 clusters
    end
  end
  ks(a) = k;
  means(a) = mean(A2SZ);
  fprintf(  'reclustering with %d centers\n', k)
  [CenterIds, Centers] = kmeans(features, k);
  a = a+1;
end
