%function [Fd, Fl,M] = AeroforcesFromPressures(angle,P)
clear all; %!!!!!!!!!!!!!!! Remark when make Function !!!!!!!!!!!!!!!
clc; %!!!!!!!!!!!!!!! Remark when make Function !!!!!!!!!!!!!!!
%--------------------------------------------------------------------------
%procedure which is as an output gives the file with integrated values of
%the pressures on the Hardangar bridge cross section, trapezoidal rule is
%taken and the values at the cornert are extrapolated with the rectangular
%it is used to provide the forces and static coefficients
%obtained from the pressure measurments

%In the program it is necessary to give the values for:

%P      -       variable in which p values must be entered

%angle  -       angle of the rotation of the cross section
%               (wind tunnel convection),
%               0 angle meens body fix coordinate system
%--------------------------------------------------------------------------

angle=6*pi/180;
P=[-0.38437913	 -0.27590526	 -0.20714459	 -0.17527429	 -0.14827595	 -0.13351133	 -0.13045601	 -0.12976972	 -0.15404870	 -0.14048281	 -0.13664527	 -0.14715777	 -0.12137657	 -0.13180968	 -0.14203699	 -0.12047136	 -0.03581564	 -0.00202419	  0.01674329	  0.03152082	  0.04866098	 -0.09357156	 -0.41981564	 -0.11751085	  0.21187911	  0.36677065	  0.50334081	  0.59418264	  0.74786391	  0.80972100	 -0.72653304	 -0.25482831	 -0.14587970	 -0.34484185	 -0.63465217	 -0.93435049	 -0.95154067	 -0.89898909	 -0.70483953	 -0.52287189];
%P=P*(0.5*1.18*5.031*5.031);

%coordinates of the center
Xc=0;
Yc=-5.1;

%Coordinates of the edges
C_edge=[
    -142 26.6;
    -23 26.6; %D.T. Unosi se zajednicka tacka izmedju koordinata pop. preseka i koordinata mernih traka 
    142 26.6;
    183 0;
    103 -40;
    -103 -40;
    -183 0;
    -142 26.6;
    ];
%Coordinates of the points C[x y]
C=[ -23 26.6;
    0   26.6;
    23  26.6;
    46  26.6;
    69  26.6;
    92  26.6;
    115 26.6;
    138 26.6;
    144.43  25.02;
    159.53  15.22;
    174.63  5.43;
    174.06  -4.75;
    151.70  -15.66;
    129.34  -26.85;
    106.99  -38.04;
    98  -40;
    70   -40;
    42  -40;
    14  -40;
    -14  -40;
    -42  -40;
    -70  -40;
    -98  -40;
    -105.6  -38.7;
    -116.77 -33.11;
    -127.95 -27.51;
    -139.13 -21.92;
    -150.31 -16.33;
    -161.49 -10.73;
    -172.66 -5.14;
    -174.61 5.44;
    -167.06 10.34;
    -159.51 15.24;
    -151.96 20.14;
    -144.41 25.03;
    -138    26.6;
    -115    26.6;
    -92    26.6;
    -69    26.6;
    -46    26.6;
    -23 26.6];

%moving the coordinate system into the denret of rotation
C(:,2)=C(:,2)-Yc;
C_edge(:,2)=C_edge(:,2)-Yc;

%plot(C(:,1),C(:,2));
%hold on;
%plot(C_edge(:,1),C_edge(:,2));

%Indexing the poins on the edges
Range=[36 41;
    1 8;
    9 11;
    12 15;
    16 23;
    24 30;
    31 35 ];

N=size(Range,1);

alpha=[ 0; 0; -0.5755; -2.6776; -3.1416; -3.6056; -5.7077];

P(41)=P(1);
P=-P;

%initialisation values for Forces
Fl=0;
Fd=0;
M=0;

%integration of the pressures
for ii=1:N
    trig(ii,1)=cos(alpha(ii));
    trig(ii,2)=sin(alpha(ii));
    for jj=Range(ii,1):(Range(ii,2)-1)
        lenght=sqrt((C(jj,2)-C(jj+1,2))^2+(C(jj,1)-C(jj+1,1))^2)*0.1;
        Fl=Fl+(P(jj)*trig(ii,1)+P(jj+1)*trig(ii,1))/2*lenght;
        Fd=Fd-(P(jj)*trig(ii,2)+P(jj+1)*trig(ii,2))/2*lenght;
        if (P(jj)*P(jj+1))>0
            if (abs(P(jj))>abs(P(jj+1)))
                Fl1=P(jj+1)*lenght*trig(ii,1);
                Fd1=-P(jj+1)*lenght*trig(ii,2);
                xC1=(C(jj,1)+C(jj+1,1))/2;
                yC1=(C(jj,2)+C(jj+1,2))/2;
                Fl2=(P(jj)-P(jj+1))*lenght/2*trig(ii,1);
                Fd2=-(P(jj)-P(jj+1))*lenght/2*trig(ii,2);
                xC2=C(jj,1)+(C(jj+1,1)-C(jj,1))/3;
                yC2=C(jj,2)+(C(jj+1,2)-C(jj,2))/3;
                M=M+Fd1*(yC1)+Fl1*(-xC1)+Fd2*(yC2)+Fl2*(-xC2);
            else
                Fl1=P(jj)*lenght*trig(ii,1);
                Fd1=-P(jj)*lenght*trig(ii,2);
                xC1=(C(jj,1)+C(jj+1,1))/2;
                yC1=(C(jj,2)+C(jj+1,2))/2;
                Fl2=(P(jj+1)-P(jj))*lenght/2*trig(ii,1);
                Fd2=-(P(jj+1)-P(jj))*lenght/2*trig(ii,2);
                xC2=C(jj,1)+2*(C(jj+1,1)-C(jj,1))/3;
                yC2=C(jj,2)+2*(C(jj+1,2)-C(jj,2))/3;
                M=M+Fd1*(yC1)+Fl1*(-xC1)+Fd2*(yC2)+Fl2*(-xC2);
            end
        else
            lenght1=lenght/(abs(P(jj))+abs(P(jj+1)))*abs(P(jj));
            lenght2=lenght/(abs(P(jj))+abs(P(jj+1)))*abs(P(jj+1));
            Fl1=P(jj)*lenght1/2*trig(ii,1);
            Fd1=-P(jj)*lenght1/2*trig(ii,2);
            xCp=C(jj,1)+(C(jj+1,1)-C(jj,1))*lenght/(abs(P(jj))+abs(P(jj+1)))*abs(P(jj));
            yCp=C(jj,2)+(C(jj+1,2)-C(jj,2))*lenght/(abs(P(jj))+abs(P(jj+1)))*abs(P(jj));
            xC1=C(jj,1)+(xCp-C(jj,1))/3;
            yC1=C(jj,2)+(yCp-C(jj,2))/3;
            
            Fl2=P(jj+1)*lenght2/2*trig(ii,1);
            Fd2=-P(jj+1)*lenght2/2*trig(ii,2);
            xC2=C(jj+1,1)-(C(jj+1,1)-xCp)/3;
            yC2=C(jj+1,2)-(C(jj+1,2)-yCp)/3;
            M=M+Fd1*(yC1)+Fl1*(-xC1)+Fd2*(yC2)+Fl2*(-xC2);
        end
    end
    
    %adding the extrapolated rectangular parts at the corners
    if (ii==1)
        lenght=sqrt((C_edge(ii,2)-C(Range(ii,1),2))^2+(C_edge(ii,1)-C(Range(ii,1),1))^2)*0.1;
        Fl1=P(Range(ii,1))*trig(ii,1)*lenght;
        Fd1=-P(Range(ii,1))*trig(ii,2)*lenght;
        Fl=Fl+Fl1;
        Fd=Fd+Fd1;
        xC=(C(Range(ii,1),1)+C_edge(ii,1))/2;
        yC=(C(Range(ii,1),2)+C_edge(ii,2))/2;
        M=M+Fd1*(yC)+Fl1*(-xC);
    elseif (ii==2)
        lenght=sqrt((C_edge(ii+1,2)-C(Range(ii,2),2))^2+(C_edge(ii+1,1)-C(Range(ii,2),1))^2)*0.1;
        Fl1=P(Range(ii,2))*trig(ii,1)*lenght;
        Fd1=-P(Range(ii,2))*trig(ii,2)*lenght;
        Fl=Fl+Fl1;
        Fd=Fd+Fd1;
        xC=(C(Range(ii,2),1)+C_edge(ii+1,1))/2;
        yC=(C(Range(ii,2),2)+C_edge(ii+1,2))/2;
        M=M+Fd1*(yC)+Fl1*(-xC);
    else
        lenght1=sqrt((C_edge(ii,2)-C(Range(ii,1),2))^2+(C_edge(ii,1)-C(Range(ii,1),1))^2)*0.1;
        Fl1=P(Range(ii,1))*trig(ii,1)*lenght1;
        Fd1=-P(Range(ii,1))*trig(ii,2)*lenght1;
        Fl=Fl+Fl1;
        Fd=Fd+Fd1;
        xC1=(C(Range(ii,1),1)+C_edge(ii,1))/2;
        yC1=(C(Range(ii,1),2)+C_edge(ii,2))/2;
        M=M+Fd1*(yC1)+Fl1*(-xC1);
        
        lenght2=sqrt((C_edge(ii+1,2)-C(Range(ii,2),2))^2+(C_edge(ii+1,1)-C(Range(ii,2),1))^2)*0.1;
        Fl2=+P(Range(ii,2))*trig(ii,1)*lenght2;
        Fd2=-P(Range(ii,2))*trig(ii,2)*lenght2;
        Fl=Fl+Fl2;
        Fd=Fd+Fd2;
        xC=(C(Range(ii,2),1)+C_edge(ii+1,1))/2;
        yC=(C(Range(ii,2),2)+C_edge(ii+1,2))/2;
        M=M+Fd2*(yC)+Fl2*(-xC);
    end
    
end
display (trig(N,1));
display (trig(N,2));
    

angle=-angle;

Fdu=(Fd*cos(angle)-Fl*sin(angle))/100;
Flu=(Fd*sin(angle)+Fl*cos(angle))/100;

Fd=Fdu;
Fl=Flu;
M=M/1000/100; %ili vec vidi koliko

%ovaj deo izbaci, samo kao kontrola
%Cm=M/1000/100/(0.5*1.18*5.031*5.031*0.3665*0.3665)
%Cl=Flu/(0.5*1.18*5.031*5.031*0.3665)
%Cd=Fdu/(0.5*1.18*5.031*5.031*0.3665)
