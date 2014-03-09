function out = roishrink_u_only(in,p)
% SHRINK REGION OF INTEREST - UP ONLY
%   out = roishrink(in,p) extends the mxnxz mask in by some integer value
%   of pixels p from the top.
%
%   Nade Sritanyaratana
%   Created April 3, 2013 - roishrinkud.m used as template
%   University of Wisconsin, Madison
%   v1.0 - created from roishrinkud.m

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
            outz((m1+p):m2,n) = 1;
        end
    end
    out(:,:,m) = outz;
end