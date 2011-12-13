function [avgDist, val] = davies(clusters, clusterI, examples)
    nclusters = size(clusters, 1);  

    totDist = zeros(nclusters, 1);
    numAss = zeros(nclusters, 1);

    m = size(examples, 1);
    
    for i = 1:m
        c = clusterI(i);
        dist = norm(examples(i,:) - clusters(c,:));
        totDist(c) = totDist(c) + dist;
        numAss(c) = numAss(c) + 1;
    end

    avgDist = zeros(nclusters, 1);
    for i = 1:nclusters
        avgDist(i) = totDist(i) / numAss(i);
    end

    tot = 0;
    for i = 1:nclusters
        max = -1;
        for j = 1:nclusters
            if i == j
                break;
            end

            v = (avgDist(i) + avgDist(j)) * (1.0 / (norm(clusters(i,:) - clusters(j,:))));

            if v > max
                max = v;
            end                                                        
        end
        tot = tot + max;
    end

    val = tot / nclusters;
end
