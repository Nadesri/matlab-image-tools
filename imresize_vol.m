function out = imresize_vol(in, c)
% IMRESIZE_VOL Resize a 3D stack of images
%   DEPRECATED: imresize3d.m is more general and can support any imresize options.
%   out = imresize_vol(in, c) resizes stack of images in as if each slice
%   inslice had been resized as in:
%       outslice = imresize(inslice,c)
%   out is the stack of images obtained by outslice.
%
%   Please see imresize for a description of how to use c.
%
%   Nade Sritanyaratana
%   11/10/10
%   University of Wisconsin, Madison

inslice = in(:,:,1);
outslice = imresize(inslice,c);

out = zeros([size(outslice) size(inslice,3)]);
out(:,:,1) = outslice;
for i=2:size(in,3)
    inslice = in(:,:,i);
    outslice = imresize(inslice,c);
    out(:,:,i) = outslice;
end
