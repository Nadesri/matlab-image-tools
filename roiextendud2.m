function out = roiextendud2(in,p,np)
%  (IN PROGRESS) EXTEND REGION OF INTEREST - UP/DOWN
%   out = roiextendud2(in,p) extends the mxnxz mask in by some integer value
%   of pixels p, going from top to bottom.
%
%   np is the max number of "pieces" that roiextendud2 should expect when
%   scanning vertical lines. Currently roiextendus2 only supports np=1 and
%   np=2.
%
%   Nade Sritanyaratana
%   IN PROGRESS: Last modified Sept 4, 2012
%   University of Wisconsin, Madison
%   v1.0

out = zeros(size(in));
z = size(in,3);

if (np~=1)||(np~=2)
    error('Sorry - roiextendus only supports np 1 or 2')
end

if np == 1
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
end
if np == 2 %stopped here
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
end