%DRAWREFERENCE Draw coordinate reference frame.
%   DRAWREFERENCE(X,LABEL,SIZE,COLOR) draws a reference frame at
%   pose X = [x;y;theta] and labels it with the string LABEL.
%   SIZE is the length of the frame axes in [m], and COLOR is a
%   [r g b]-vector or a color string such as 'r' or 'g'.
%
%   H = DRAWREFERENCE(...) returns a column vector of handles to
%   all graphic objects of the drawing. Remember that not all
%   graphic properties apply to all types of graphic objects. Use
%   FINDOBJ to find and access the individual objects.
%
%   See also DRAWARROW, DRAWLABEL, FINDOBJ, PLOT.

% v.1.0, 09.11.02, Kai Arras, ASL-EPFL


function h = drawreference(xvec,label,size,color);

% Constants
FILL   = 0;            % enable/disable arrow head filling
AHSIZE = size*0.2;     % arrow head size
FSCALE = size*0.15;    % font size relative to the rest
FOFFST = size*0.04;    % font offset
CRSIZE = size*0.1;     % cross size
LH = size*0.55;        % label offset from x-axis
XK = 0.9;              % default value XKERNING in drawlabel.m
XS = 0.6;              % default value XSQUEEZE in drawlabel.m
FH = 2*FOFFST+FSCALE;  % label frame height

x = xvec(1); y = xvec(2); phi = xvec(3);
sphi = sin(phi); cphi = cos(phi);

% Draw cross
px = [x-CRSIZE*cphi, x+CRSIZE*cphi, x+CRSIZE*sphi, x-CRSIZE*sphi];
py = [y-CRSIZE*sphi, y+CRSIZE*sphi, y-CRSIZE*cphi, y+CRSIZE*cphi];
h1 = plot(px(1:2),py(1:2),px(3:4),py(3:4),'Color',color);

% Draw frame and draw label if it was specified
if ~isempty(label),
  fwidth  = 2*FOFFST+FSCALE*(XK*length(label)-XK+XS);     % label frame width
  px = [x-LH*sphi x-LH*sphi+fwidth*cphi x-(LH+FH)*sphi+fwidth*cphi x-(LH+FH)*sphi];
  py = [y+LH*cphi y+LH*cphi+fwidth*sphi y+(LH+FH)*cphi+fwidth*sphi y+(LH+FH)*cphi];
  h2 = plot(px,py,'Color',color);
  h3 = drawlabel([x-LH*sphi; y+LH*cphi; phi],label,FSCALE,FOFFST,color);
else
  h2 = []; h3 = [];
end;

% Plot x- and y-axis
h4 = drawarrow(xvec,[x+size*cphi, y+size*sphi],FILL,AHSIZE,color);
h5 = drawarrow(xvec,[x-size*sphi, y+size*cphi],FILL,AHSIZE,color);
h = cat(1,h1,h2,h3,h4,h5);
