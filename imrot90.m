function out = imrot90(in,n_iter)
% ROTATE IMAGE 90 DEGREES
% out = imrot90(in) rotates an mxnxz image 90 degrees clockwise. Also
% supports 3D images.
%
% out = imrot90(in,n_iter) rotates an image 90 degrees n_iter times.
%
% Nade Sritanyaratana
% University of Wisconsin, Madison
% February 8, 2011
% v1.0
% v1.1 - supports multiple rotations (n_iter) (NS 10/11/2013)
% v2.0 - Supports 4D images (rotates each 3D volume one by one)

if ~exist('n_iter','var')
    n_iter = 1;
end

dims = size(in);
if length(dims)<=3
    for i=1:n_iter
        in = rot90(in);
    end
    result = in;
elseif length(dims)==4
    for i_vol = 1:dims(4)
        for i=1:n_iter
            in(:,:,:,i_vol) = rot90(squeeze(in(:,:,:,i_vol)));
        end
    end
    result = in;
else
    error('imrot90 only supports up to 4D images!')
end

out = result;

end

function out = rot90(in)
    dim = length(size(in));

    if (dim~=2&&dim~=3)
        error('in must be a 2D or 3D image.')
    end

    m = size(in,1); n = size(in,2); z = size(in,3);

    out = zeros([n m z]);
    for k=1:size(in,3) 
        inslice  = in(:,:,k);
        outslice = zeros([n m]);
        for i = 1:m
            row = inslice(i,:);
            outslice(:,m-i+1) = row';
        end
        out(:,:,k) = outslice;
    end
end