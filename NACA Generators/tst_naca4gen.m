% INPUTS-------------------------------------------------------------------
%       iaf.designation = NACA 4 digit iaf.designation (eg. '2412') - STRING !
%                 iaf.n = no of panels (line elements) PER SIDE (upper/lower)
% iaf.HalfCosineSpacing = 1 for "half cosine x-spacing" 
%                       = 0 to give "uniform x-spacing"
%          iaf.wantFile = 1 for creating airfoil data file (eg. 'naca2412.dat')
%                       = 0 to suppress writing into a file
%       iaf.datFilePath = Path where the data  file has to be created
%                         (eg. 'af_data_folder/naca4digitAF/') 
%                         use only forward slash '/' (Just for OS portability)
% 
% OUTPUTS------------------------------------------------------------------
% Data:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%       af.x = x cordinate (nx1 array)
%       af.z = z cordinate (nx1 array)
%      af.xU = x cordinate of upper surface (nx1 array)
%      af.zU = z cordinate of upper surface (nx1 array)
%      af.xL = x cordinate of lower surface (nx1 array)
%      af.zL = z cordinate of lower surface (nx1 array)
%      af.xC = x cordinate of camber line (nx1 array)
%      af.zC = z cordinate of camber line (nx1 array)
%    af.name = Name of the airfoil
%  af.header = Airfoil name ; No of panels ; Type of spacing
%              (eg. 'NACA4412 : [50 panels,Uniform x-spacing]')
% 
% 
% File:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
% First line : Header eg. 'NACA4412 : [50 panels,Half cosine x-spacing]'
% Subsequent lines : (2*iaf.n+1) rows of x and z values
% 
% Typical Inputs:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
% iaf.designation='2312';
% iaf.n=56;
% iaf.HalfCosineSpacing=1;
% iaf.wantFile=1;
% iaf.datFilePath='./'; % Current folder
% iaf.is_finiteTE=0;


iaf.designation='0024';
%designation='0008';
iaf.n=49; 
iaf.HalfCosineSpacing=0;
iaf.wantFile=1;
iaf.datFilePath='./'; % Current folder
iaf.is_finiteTE=0;

af = naca4gen(iaf);

plot(af.x,af.z,'bo-')

plot(af.xU,af.zU,'go-') %Upper coordinates of NACA
hold on
plot(af.xL,af.zL,'ro-') %Lower coordinates of NACA

axis equal