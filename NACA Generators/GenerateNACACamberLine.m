function [xc,yc]=GenerateNACACamberLine(cl,a,dotcount)

%--------------------------------------------------------------------------
%GenerateNACACamberLine
%Version 1.00
%Created by Stepen (zerocross_raptor@yahoo.com
%Created 3 December 2010
%--------------------------------------------------------------------------
%GenerateNACACamberLine generates the camber line coordinate of a NACA
%airfoil with given design lift coefficient and uniform load distribution
%characteristic. The math equation used to generates the airfoil
%coordinates is based on Theory of Wing Section Chapter 4 by Abbott and
%Doenhoff.
%--------------------------------------------------------------------------
%Syntax: [xc,yc]=GenerateNACACamberLine(cl,a,dotcount)
%Input argument:
%- cl (1 x 1 num) specifies the airfoil's design lift coefficient.
%- a (1 x 1 num) specifies the chordwise location in fraction of chord
%  where load distribution is uniform from leading-edge to this point and
%  linearly decreasing to zero behind this point.
%- dotcount (1 x 1 int) specifies the number of vertexes to be generated on
%  the airfoil's camber/mean line.
%Output argument:
%- xc (m x 1 num) specifies the x axis location of the camber line's
%  vertexes.
%- yc (m x 1 num) specifies the y axis location of the camber line's
%  vertexes.
%--------------------------------------------------------------------------

%CodeStart-----------------------------------------------------------------
%Checking input cl
    if numel(cl)~=1
        error('Lift Coefficient must be scalar!')
    end
%Checking input a
    if numel(a)~=1
        error('Uniform load location must be a scalar!')
    end
    if (a>1)||(a<0)
        error('Uniform load location values must be between 0 and 1!')
    end
%Checking input dotcount
    if numel(dotcount)~=1
        error('Number of vertex must be scalar!')
    end
    if (mod(dotcount,1~=0))||(dotcount<0)
        error('Number of vertex must be positive integer!')
    end
%Calculating x-axis location of camber line vertexes
    panelcount=dotcount-1;
    panellength=1/panelcount;
    xc=(0:panellength:1)';
%Preallocating array for speed
    yc=zeros(dotcount,1);
%Calculating y-axis location of camber line vertexes
    for i=2:1:dotcount-1
        tempval1=(-1/(1-a))*(((a^2)*((0.5*log(a))-0.25))+0.25);
        tempval2=((1/(1-a))*((0.5*((1-a)^2)*log(1-a))-(0.25*((1-a)^2))))+tempval1;
        if xc(i)==a
            xc(i)=xc(i)+0.0001*xc(i);
        end
        if a==1.0
            yc(i)=(-cl/(4*pi()))*(((1-xc(i))*log(1-xc(i)))+(xc(i)*log(xc(i))));
        else
            yc(i)=(cl/(2*pi()*(a+1)))*(((1/(1-a))*((0.5*((a-xc(i))^2)*log(abs(a-xc(i))))-...
                                                   (0.5*((1-xc(i))^2)*log(abs(1-xc(i))))-...
                                                   (0.25*((a-xc(i))^2))+...
                                                   (0.25*((1-xc(i))^2))))-...
                                       (xc(i)*log(xc(i)))+...
                                       (tempval1)-...
                                       (tempval2*xc(i)));
        end
    end
%CodeEnd-------------------------------------------------------------------

end