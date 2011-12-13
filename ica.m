
CH = 60;
PER_CH = 30;
stream_size = size(features,1)*PER_CH;
NewStream = zeros(CH, stream_size);
for i=1:CH
    FeatureCH = features(:,((i-1)*30+1):i*30);
    NewStream(i,:) = reshape(FeatureCH,1,stream_size); 
end

W = eye(CH);

anneal = [0.1 0.1 0.1 0.05 0.05 0.05 0.02 0.02 0.01 0.01 0.005 0.005 0.002 0.002 0.001 0.001];

for iter=1:length(anneal)
   iter
   G = 1 ./ (1 + exp(-W * NewStream));
   A = (1 - 2.*G) * NewStream' + inv(W');
   W = W + anneal(iter) .* A;
   
%    for i=1:size(NewStream,2)
%       G = 1 ./ (1 + exp(-W*NewStream(:,i)));                                                                         
%       A = (1 - 2 * G) * NewStream(:,i)' + inv(W');
%       W = W + anneal(iter) .* A;
%    end
   %%%% here comes your code part (should not be much, ours was about 10 lines of code)
end;

%%%% After finding W, use it to unmix the sources.  Place the unmixed sources
%%%% in the matrix S (one source per column).  (Your code.)
S = W * NewStream;
S = S / (max(max(abs(S))));
%S=0.99 * S./(ones(size(NewStream,1),1)*max(abs(S)));  % rescale each column to have maximum absolute value 1

features_ica = features;
for i=1:size(features,1)
   F = S(:,((i-1)*30+1):(i*30));
   features_ica(i,:) = reshape(F',1,1800);
end