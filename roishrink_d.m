function out = roishrink_d(in,p)
% SHRINK REGION OF INTEREST - DOWN
%   out = roishrink(in,p) removes the mxnxz image in by some integer value
%   of pixels p from the bottom.
%
%   Nade Sritanyaratana
%   Created Nov 13, 2013 - roishrink_u_only.m used as template
%   University of Wisconsin, Madison
%   v1.0 - created from roishrink_u_only.m

dims = size(in);
if length(dims)>5
    error('roishrink_d supports only 2D, 3D, 4D, and 5D matrices.');
end


out=zeros(dims);
if length(dims)<4
    out = volshrink_d(in,p);
elseif length(dims)==4
    for i_d = 1:dims(4)
        out(:,:,:,i_d) = volshrink_d(in,p);
    end
elseif length(dims)==5
    for i4 = 1:dims(4)
        for i5=1:dims(5)
            out(:,:,:,i4,i5) = volshrink_d(in,p);
        end
    end
end

function out = volshrink_d(in,p)
    out = zeros(size(in));
    z = size(in,3);

    for m=1:z
        inz = in(:,:,m);
        outz = out(:,:,m);
        for n=1:size(inz,2)
            m1=find(inz(:,n),1);
            m2=find(inz(:,n),1,'last');
            if or(and(isempty(m1),isempty(m2)),m1==m2)
                continue
            else
                outz((m1):(m2-p),n) = inz((m1):(m2-p),n);
            end
        end
        out(:,:,m) = outz;
    end
end
end