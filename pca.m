load 041111_0a_1m.mat

X = zeros(size(data,1), size(data{1}, 1));
for i = 1:size(X,1)
  X(i,:) = data{i} .';
end

