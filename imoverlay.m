function h = imoverlay(in,bgim,alphalevel,mapopt,inwl,bgwl,invertgray_flag)
% IMOVERLAY Overlay target image over background image
%   h = imoverlay(in,bgim,alphalevel,mapopt,inwl,bgwl) overlays mxn mask 
%   on background mxn matrix image bgim. bgim will be displayed as a 'jet' 
%   colormap. in will be  displayed in grayscale. For best results, in 
%   should be a sparse, logical nxn matrix, while bgim relatively nonsparse.
%   alphalevel can be any constant between 0 and 1. If alphalevel is not 
%   specified, then it is defaulted to 0.6. h is the handle to the display 
%   for in (as opposed to bgim).
%
%   invertgray_flag is an optional parameter (default 0). If set to 1,
%   whichever image (Background or Foreground) with the grayscale property
%   (see mapopt) will be inverted (white for low values, black for high
%   values)
%
%   See update notes for instructions on mapopt.
%   
%   inwl and bgwl are optional inputs indicating the desired window/level
%   for the image in and the image bgim, respectively. If not specified,
%   then the window/level is set to auto.
%
%   See also IMINSERT.
%
%   Nade Sritanyaratana
%   Created: September 29, 2011
%   Last Modified: March 14, 2012
%   University of Wisconsin, Madison
%   v1.0 - Initialized
%   v2.0 - Supports (optional) custom Alpha transparency level
%        - Fixed "lim1 lim2" bug
%   v3.0 - "bgim" now set as jet colormap, "in" as grayscale
%           - above feature provided as an option (mapopt=2). Default 1.

if ~exist('alphalevel','var'), alphalevel = .6; end
if ~exist('mapopt','var'), mapopt = 1; end
if ~exist('inwl','var'), inwl = [min(in(:)) max(in(:))]; end
if ~exist('bgwl','var'), bgwl = [min(bgim(:)) max(bgim(:))]; end
if ~exist('invertgray_flag','var'), invertgray_flag=0; end

if mapopt==1,     h = imjet(in,bgim,alphalevel,inwl,bgwl,invertgray_flag);
elseif mapopt==2, h = bgjet(in,bgim,alphalevel,inwl,bgwl,invertgray_flag);
end

end

function h = imjet(in,bgim,alphalevel,inwl,bgwl,invertgray_flag)
    if isempty(nonzeros(isnan(in)))
        mask = (in~=0);
    else
        mask = ~isnan(in);
    end
    mask = mimsc(mask);
    
    c = 65534/max(bgim(:));
    bgim = round(c*mimsc(bgim))-1; bgim = uint16(bgim);
    bgwl = round(c*bgwl)-1; bgwl = uint16(bgwl);
    
    if invertgray_flag
        cmap = colormapgray_inverted;
    else
        cmap = colormapgray;
    end
    bgim = ind2rgb(bgim,cmap);

    imagesc(bgim,bgwl);

    % imagesc(mimsc(bgim)), colormap('gray')
    hold on;
    h = imagesc(mimsc(in), inwl);
    colormap(jet(256));
    hold off; axis off;

    set(h,'AlphaData',mask*alphalevel);
end

function h = bgjet(in,bgim,alphalevel,inwl,bgwl,invertgray_flag)
    if isempty(nonzeros(isnan(in)))
        mask = (in~=0);
    else
        mask = ~isnan(in);
    end
    mask = mimsc(mask);
    
%     c = 65534/max(in(:));
% %     in2 = -round(c*mimsc(in))+65534; in2 = uint16(in2);
% %     inwl = -round(c*inwl)+65534; inwl = uint16(inwl);
%     in2  = round(c*mimsc(in))-1; in2 = uint16(in2);
%     inwl = round(c*inwl)-1; inwl = uint16(inwl);
    c = 65534/max(bgim(:));
    bgim = round(c*mimsc(bgim))-1; bgim = uint16(bgim);
    bgwl = round(c*bgwl)-1; bgwl = uint16(bgwl);

    bgim2  = ind2rgb(bgim,jet(65535));

    imagesc(bgim2, bgwl);
    
    if invertgray_flag
        cmap = colormapgray_inverted(256);
    else
        cmap = colormapgray(256);
    end
    hold on;
    h = imagesc(in,inwl);
    colormap(cmap);
    hold off; axis off;

    set(h,'AlphaData',mask*alphalevel);
end

function graymap = colormapgray(num_shades)
    if ~exist('num_shades','var')
        num_shades = 65535;
    end
    graymap = gray(num_shades);
%     Rlist = linspace(0,1,65535);
%     Rlist = Rlist';
%     Glist = Rlist; Blist = Rlist;
%     graymap = [Rlist, Glist, Blist];
end

function graymap_inverted = colormapgray_inverted(num_shades)
    if ~exist('num_shades','var')
        num_shades = 65535;
    end
    graymap = gray(num_shades);
    graymap_inverted = graymap(end:-1:1,end:-1:1,end:-1:1);
%     Rlist = linspace(0,1,65535);
%     Rlist = Rlist';
%     Glist = Rlist; Blist = Rlist;
%     graymap = [Rlist, Glist, Blist];
end