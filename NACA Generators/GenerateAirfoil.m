function [xu,yu,xl,yl]=GenerateAirfoil(xc,yc,yt)

%--------------------------------------------------------------------------
%GenerateAirfoil
%Version 1.10
%Created by Stepen
%Created 3 December 2010
%Last modified 17 December 2010
%--------------------------------------------------------------------------
%GenerateAirfoil generates the airfoil coordinates from the given camber
%line and thickness distribution. GenerateAirfoil generates airfoil's
%vertexes by assuming that airfoil thickness at each chordwise loation is
%measured perpendicular to the camber line.
%--------------------------------------------------------------------------
%Syntax:
%[xu,yu,xl,yl]=GenerateAirfoil(xc,yc,yt)
%Input argument:
%- xc (m x 1 num) specifies the x axis location of the airfoil's camber
%  line vertexes.
%- yc (m x 1 num) specifies the y axis location of the airfoil's camber
%  line vertexes.
%- yt (m x 1 num) specifies the airfoil's thickness at the corresponding
%  camber line vertexes.
%Output argument:
%- xu (i x 1 num) specifies the x axis location of airfoil's upper surface
%  vertexes in fraction of chord. The airfoil's upper surface vertex are
%  arranged from leading edge (the first element of xu) to the trailing
%  edge (the last element of xu).
%- yu (i x 1 num) specifies the y axis location of airfoil's upper surface
%  vertexes in fraction of chord. The airfoil's upper surface vertex are
%  arranged from leading edge (the first element of yu) to the trailing
%  edge (the last element of yu).
%- xl (i x 1 num) specifies the x axis location of airfoil's lower surface
%  vertexes in fraction of chord. The airfoil's lower surface vertex are
%  arranged from leading edge (the first element of xl) to the trailing
%  edge (the last element of xl).
%- yl (i x 1 num) specifies the y axis location of airfoil's lower surface
%  vertexes in fraction of chord. The airfoil's lower surface vertex are
%  arranged from leading edge (the first element of yl) to the trailing
%  edge (the last element of yl).
%--------------------------------------------------------------------------

%CodeStart-----------------------------------------------------------------
%Checking input xc
    size_xc=size(xc);
    if ~iscolumn(xc)
        error('Input xc must be one column array!')
    end
%Checking input yc
    if ~iscolumn(yc)
        error('Input yc must be one column array!')
    end
%Checking input yt
    if ~iscolumn(yt)
        error('Input yt must be one column array!')
    end
    if yt(1)~=0
        error('Airfoil thickness at leading edge must be zero!')
    end
%Checking input consistency
    if (numel(xc)~=numel(yc))||(numel(xc)~=numel(yt))
        error('Input xc, yc, and yt must have the same size!')
    end
%Preallocating array for speed
    gc=zeros(size_xc(1),1);
    xu=zeros(size_xc(1),1);
    xl=zeros(size_xc(1),1);
    yu=zeros(size_xc(1),1);
    yl=zeros(size_xc(1),1);
%Calculating camber line's gradients
    for i=2:1:size_xc(1)-1
        gc(i)=(yc(i+1)-yc(i-1))/(xc(i+1)-xc(i-1));
    end
    sc=atand(gc);
%Generating airfoil vertexes
    for i=1:1:size_xc(1)
        xu(i)=xc(i)-yt(i)*sind(sc(i));
        yu(i)=yc(i)+yt(i)*cosd(sc(i));
        xl(i)=xc(i)+yt(i)*sind(sc(i));
        yl(i)=yc(i)-yt(i)*cosd(sc(i));
    end
%CodeEnd-------------------------------------------------------------------

end