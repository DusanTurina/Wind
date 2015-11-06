function [llength, langle] = polygonLengthAngleOfLines(varargin)

% parse input arguments
if nargin == 1
    var = varargin{1};
    px = var(:,1);
    py = var(:,2);
elseif nargin == 2
    px = varargin{1};
    py = varargin{2};
end
%Line(vector) length 
llength = sqrt(diff(px).^2+diff(py).^2);
% vertex indices
N = length(px);
iNext = [2:N 1];
%Angle of Line(vector)
langle = atan2(py(iNext) - py, px(iNext) - px);
