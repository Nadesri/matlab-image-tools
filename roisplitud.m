function [mask1 mask2] = roisplitud(in)
% SPLIT REGION OF INTEREST - UP/DOWN
%   [mask1 mask2] = roisplitud(in) splits the mxnxz mask in into two halves,
%   top and bottom, into two mxnxz matrices mask1 and mask2, respectively.
%
%   Nade Sritanyaratana
%   Created September 29, 2011
%   University of Wisconsin, Madison
%   v1.0
%   v1.1 (10/14/11) - Added 3D capability

mask1 = zeros(size(in));
mask2 = zeros(size(in));
z = size(in,3);

for m=1:z
    inz = in(:,:,m);
    for n=1:size(inz,2)
        m1=find(inz(:,n),1);
        m2=find(inz(:,n),1,'last');
        if or(and(isempty(m1),isempty(m2)),m1==m2)
            continue
        else
            midm=round((m1+m2)/2);
            mask1(m1:(midm-1),n,m) = 1;
            mask2(midm:m2,n,m)     = 1;
        end
    end
end

mask1 = logical(mask1.*in);
mask2 = logical(mask2.*in);