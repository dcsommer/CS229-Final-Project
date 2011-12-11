dataTemp = data';

W = eye(size(data,2));

normalizedData = 0.99 * data ./ (ones(size(data,1),1)*max(abs(data)));


anneal = [0.1 0.1 0.1 0.05 0.05 0.05 0.02 0.02 0.01 0.01 0.005 0.005 0.002 0.002 0.001 0.001];

for iter=1:length(anneal)
   iter
   %G = 1 ./ (1 + exp(-W * normalizedData));
   %A = (1 - 2.*G) * normalizedData' + inv(W');
   %W = W + anneal(iter) .* A;
   
   for i=1:length(data)
      G = 1 ./ (1 + exp(-W*normalizedData(:,i)));                                                                         
      A = (1 - 2 * G) * normalizedData(:,i)' + inv(W');
      W = W + anneal(iter) .* A;
   end
   %%%% here comes your code part (should not be much, ours was about 10 lines of code)
end;

%%%% After finding W, use it to unmix the sources.  Place the unmixed sources
%%%% in the matrix S (one source per column).  (Your code.)
S = W * normalizedData;

S=0.99 * S./(ones(size(data,1),1)*max(abs(S)));  % rescale each column to have maximum absolute value 1
