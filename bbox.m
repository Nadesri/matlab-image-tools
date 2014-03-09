% BBOX Bounding Box
%
% [xrng yrng zrng] = bbox(im) is an approximation of Alexey Samsonov's bbox
% function. Creates a bounding box of the 3D image im and stores the
% indices in xrng, yrng, and zrng.
%
% Nade Sritanyaratana
% University of Wisconsin-Madison
% October 09, 2013
% v1.0

function [xrng yrng zrng] = bbox(im,zoomfact)

if ~exist('zoomfact','var')
    zoomfact = [1 1 1];
end
if length(zoomfact(:))<3
    zoomfact(3) = 1;
end
if prod(double(zoomfact<=0))
    error('All elements of zoomfact must be larger than 0.')
end

dims = size(im);
if length(dims)<3; dims(3) = 1; end

im(isnan(im)) = 0;

xrng = [1 dims(1)];
yrng = [1 dims(2)];
zrng = [1 dims(3)];

% get xrng
xrng(1) = find(sum(sum(im,3),2),1,'first');
xrng(2) = find(sum(sum(im,3),2),1,'last');
xdelta = (xrng(2)-xrng(1))*(zoomfact(1)-1)/2;
xrng(1) = max(round(xrng(1)-xdelta),1);
xrng(2) = min(round(xrng(2)+xdelta),size(im,1));

% get yrng
yrng(1) = find(sum(sum(im,3),1),1,'first');
yrng(2) = find(sum(sum(im,3),1),1,'last');
ydelta = (yrng(2)-yrng(1))*(zoomfact(2)-1)/2;
yrng(1) = max(round(yrng(1)-ydelta),1);
yrng(2) = min(round(yrng(2)+ydelta),size(im,2));

% get zrng
zrng(1) = find(sum(sum(im,2),1),1,'first');
zrng(2) = find(sum(sum(im,2),1),1,'last');
zdelta = (zrng(2)-zrng(1))*(zoomfact(3)-1)/2;
zrng(1) = max(round(zrng(1)-zdelta),1);
zrng(2) = min(round(zrng(2)+zdelta),size(im,3));

xrng = xrng(1):xrng(2);
yrng = yrng(1):yrng(2);
zrng = zrng(1):zrng(2);

end