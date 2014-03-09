function out = roiextendud(in,p)
% EXTEND REGION OF INTEREST - UP/DOWN
%   out = roiextendud(in,p) extends the mxnxz mask in by some integer value
%   of pixels p, going from top to bottom.
%
%   Nade Sritanyaratana
%   Created November 1, 2011
%   University of Wisconsin, Madison
%   v1.0

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
            outz(m1-p:m2+p,n) = 1;
        end
    end
    out(:,:,m) = outz;
end