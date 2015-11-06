function [ geom, iner, cpmo ] = polygonGeometry(varargin)
%POLYGEOM Geometry of a planar polygon
%
% sample data
% x = [ 2.000  0.500  4.830  6.330 ];
% y = [ 4.000  6.598  9.098  6.500 ];
% 3x5 test rectangle with long axis at 30 degrees
% area=15, x_cen=3.415, y_cen=6.549, perimeter=16
% Ixx=659.561, Iyy=201.173, Ixy=344.117
% Iuu=16.249, Ivv=26.247, Iuv=8.660
% I1=11.249, ang1=30deg, I2=31.247, ang2=120deg, J=42.496
%
% H.J. Sommer III, Ph.D., Professor of Mechanical Engineering, 337 Leonhard Bldg
% The Pennsylvania State University, University Park, PA  16802
% (814)863-8997  FAX (814)865-9693  hjs1@psu.edu  www.me.psu.edu/sommer/

% parse input arguments
if nargin == 1
    var = varargin{1};
    px = var(:,1);
    py = var(:,2);
elseif nargin == 2
    px = varargin{1};
    py = varargin{2};
end

% vertex indices
N = length(px);
iNext = [2:N 1];

% temporarily shift data to mean of vertices for improved accuracy
xm = mean(px);
ym = mean(py);
px = px - xm*ones(N,1);
py = py - ym*ones(N,1);

% delta x and delta y
dx = px(iNext) - px;
dy = py(iNext) - py;

% summations for CW boundary integrals
A = sum( py.*dx - px.*dy )/2;
Axc = sum( 6*px.*py.*dx -3*px.*px.*dy +3*py.*dx.*dx +dx.*dx.*dy )/12;
Ayc = sum( 3*py.*py.*dx -6*px.*py.*dy -3*px.*dy.*dy -dx.*dy.*dy )/12;
Ixx = sum( 2*py.*py.*py.*dx -6*px.*py.*py.*dy -6*px.*py.*dy.*dy ...
    -2*px.*dy.*dy.*dy -2*py.*dx.*dy.*dy -dx.*dy.*dy.*dy )/12;
Iyy = sum( 6*px.*px.*py.*dx -2*px.*px.*px.*dy +6*px.*py.*dx.*dx ...
    +2*py.*dx.*dx.*dx +2*px.*dx.*dx.*dy +dx.*dx.*dx.*dy )/12;
Ixy = sum( 6*px.*py.*py.*dx -6*px.*px.*py.*dy +3*py.*py.*dx.*dx ...
    -3*px.*px.*dy.*dy +2*py.*dx.*dx.*dy -2*px.*dx.*dy.*dy )/24;
P = sum( sqrt( dx.*dx +dy.*dy ) );

% check for CCW versus CW boundary
if A < 0,
    A = -A;
    Axc = -Axc;
    Ayc = -Ayc;
    Ixx = -Ixx;
    Iyy = -Iyy;
    Ixy = -Ixy;
end

% centroidal moments
xc = Axc / A;
yc = Ayc / A;
Iuu = Ixx -  A*yc*yc;
Ivv = Iyy -  A*xc*xc;
Iuv = Ixy -  A*xc*yc;
J = Iuu + Ivv;

% replace mean of vertices
x_cen = xc + xm;
y_cen = yc + ym;
Ixx = Iuu + A*y_cen*y_cen;
Iyy = Ivv + A*x_cen*x_cen;
Ixy = Iuv + A*x_cen*y_cen;

% principal moments and orientation
I = [ Iuu  -Iuv ;
    -Iuv   Ivv ];
[ eig_vec, eig_val ] = eig(I);
I1 = eig_val(1,1);
I2 = eig_val(2,2);
ang1 = atan2( eig_vec(2,1), eig_vec(1,1) );
ang2 = atan2( eig_vec(2,2), eig_vec(1,2) );

% return values
geom = [ A  x_cen  y_cen  P ];
iner = [ Ixx  Iyy  Ixy  Iuu  Ivv  Iuv ];
cpmo = [ I1  ang1  I2  ang2  J ];