function out = roidraw3x3
% ROIDRAW3X3 Draw 3x3 Region of Interest
% out = roidraw3x3 prompts the user to pick a point on the current graph,
% then creates a 3x3 rectangular mask out, which includes this point in the
% center of the ROI.
%
% Nade Sritanyaratana
% Created September 4, 2012
% University of Wisconsin-Madison
% v1.0

xlims = get(gca,'XLim');
ylims = get(gca,'YLim');
h = impoint(gca,mean(xlims),mean(ylims));
api = iptgetapi(h);
% fcn = makeConstrainToRectFcn('impoint',xlims,ylims);
fcn = makeConstrainToRectFcn('impoint',[xlims(1)+2 xlims(2)-2],[ylims(1)+2 ylims(2)-2]);
% fcn = makeConstrainToRectFcn('impoint',[50 200],[50 200]);
api.setPositionConstraintFcn(fcn);
setPositionConstraintFcn(h,fcn);
position = round(wait(h));
delete(h)

%  Get information from the current figure
A = getimage;
nrows = size(A,1);
ncols = size(A,2);

out= false([nrows ncols]);
out((position(2)-1):(position(2)+1),(position(1)-1):(position(1)+1)) = true;