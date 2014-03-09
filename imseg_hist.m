function segim = imseg_hist(im, Teps, delta, N)
% IMAGE SEGMENTATION: HISTOGRAM METHOD
% segim = imseg_hist(im) segments an image and returns it as the output.
% imseg_hist is designed for spgr and afi raw images, but may work on other
% raw images as well. The segmentation will remove background noise and
% possibly some tissue, leaving most of the tissue intact. By default, the
% histogram stage is designed for 224x224x20 spgr/afi images.
%
% segim = imseg_hist(im, Teps) will increase the threshold of the image by
% Teps. This is designed to skew the threshold beyond the default threshold
% T, where T is in the middle of the two "noise" and "signal"
% distributions.
%
% segim = imseg_hist(im, Teps, delta) will modify the setup for the
% histogram peak detection stage of the segmentation. delta is the minimal
% count that a peak must rise or fall in order to be determined a peak. See
% peakdet for more information. To ignore Teps and still use delta, set 
% Teps=0.
%
% segim = imseg_hist(im, Teps, delta, N) will modify the setup for the
% histogram stage of the segmentation. N is the number of bins in 
% counts = hist(im(:)).
%
% University of Wisconsin-Madison
% Nade Sritanyaratana
% Created: February 17, 2011
% v1.0 (02/17/11)

if ~exist('Teps','var')
    Teps = 0;
end
if ~exist('delta', 'var')
    delta = round(3000/(224*224*20)*length(im(:)));
end
if ~exist('N','var')
    N=round(300/(224*224*20)*length(im(:)));
end

[y x] = hist(im(:),N);
[maxima minima] = peakdet(y,delta,x);
if ~isempty(maxima)
    T1 = 2*maxima(1,1);
else
    sect1  = (1:round(N/10));
    T1 = 2*x(y(sect1 )==max(y(sect1 )));
end
if ~isempty(minima)
    T2 = minima(1,1);
elseif length(maxima(:,1))>=2
    sect1 = (x>maxima(1,1)).*(x<maxima(2,1));
    [value i] = min(y.*sect1);
    T2 =   x(i(1));
else
    T2 = 0;
end
T       = T1+T2;
That    = T+Teps;
segim   = (im>That).*im;