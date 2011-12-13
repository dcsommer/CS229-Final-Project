function [PeakIndex, PeakAmp, PeakChannel] = Snip(Data)
   
NumChannels = size(Data,1);
NumSamples = size(Data,2);

dthresh = 2;
    
d2=[zeros(1,NumSamples-1);diff(Data,1,2);zeros(1,NumSamples-1)];
%Select Peaks larger than dthresh
disp 'Find Peaks - local maxima of derivative'
peaklocs= find(and(and(d2(1:NumChannels,:)>0,d2(2:NumChannels+1,:)<=0),Data(:,1:NumSamples-1)>dthresh))';
%Select Sample Index (Time)
disp 'Find Times of Peaks'
PeakIndex = sort(mod(peaklocs,NumSamples));  %%%Also Peak Times! 
PeakIndex = unique(PeakIndex(PeakIndex ~= 0));
    
%Only Select ones at least 15 samples apart
disp 'Only select peaks at least 15 samples apart'
selpeaks = zeros(size(PeakIndex));
avail(1:max(PeakIndex)+20) = 1;
for curpeak=1:size(PeakIndex,2)
   if (PeakIndex(curpeak) > 30 && avail(PeakIndex(curpeak))==1)
       selpeaks(curpeak)=1;
       avail(max([1 PeakIndex(curpeak)-15]):PeakIndex(curpeak)+15)=0;
   end
end
    
disp 'Create final Index, Amplitude and Channel for each peak'
PeakIndex = PeakIndex(find(selpeaks));
[PeakAmp PeakChannel] = max(Data(:,PeakIndex),[],1);