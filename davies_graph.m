function v = davies_graph(reduced_features)
  v = zeros(1, 20);
  for k = 2:100
    [CenterIds, Centers] = kmeans(reduced_features, k);
    [t, r] = davies_web(reduced_features, CenterIds, Centers);
    v(k) = t;
  end
end
