clear all
clc

%[FileName,FileDirectoryPath]=uigetfile('*.*','Load any file');
%Load geometry file and calculate angles
[FileName,FileDirectoryPath]=uigetfile('geometry.dat','Load Coordinates of Cross-section - geometry.dat');
delimiterIn = ' '; %Defines space-delimited ASCII reading file
headerlinesIn = 0; %Defines Header, If does not exist then 0
geometry_data = importdata(FileName,delimiterIn,headerlinesIn); %Make geometry data
%Calculate poligon's Center of Gravity
%geometry_centroid = polygonCentroid(geometry_data);
%Calculate poligon's length and angles of straight lines (vectors)
[geometry_length,  geometry_angle] = polygonLengthAngleOfLines(geometry_data);
%Calculate cosine and sine of vector angle
geometry_trig = [ cos(geometry_angle) sin(geometry_angle)];
%Copies first row to last position to make closed poligon
geometry_data = ChangeLengthOfMatrix(geometry_data,0,0,0,0,1);

%Load measurement points file
[FileName, FileDirectoryPath]=uigetfile('measpoints.dat','Load Measurement Points Coordinates - measpoints.dat');
delimiterIn = ' '; %Defines space-delimited ASCII reading file  proveriti sa %12.8f\t
headerlinesIn = 0; %Defines Header, If does not exist then 0
measpoints_data = importdata(FileName,delimiterIn,headerlinesIn); %Make tags data
measpoints_tags = ChangeLengthOfMatrix(measpoints_data,0,0,0,2,1);
measpoints_data = ChangeLengthOfMatrix(measpoints_data,0,0,1,0,1);
%Calculate Center of Gravity of poligon
%measpoints_centroid = polygonCentroid(measpoints_data);
%Calculate length and angle of vector
[measpoints_length, measpoints_angle] = polygonLengthAngleOfLines(measpoints_data);
%Calculate cosine and sine  of vector angle
measpoints_trig = [ cos(measpoints_angle) sin(measpoints_angle)];

%Load pressures file
[FileName,FileDirectoryPath]=uigetfile('*.dat','Load Pressures File');
delimiterIn = '	';%Defines space-delimited ASCII reading file
headerlinesIn = 0; %Defines Header, If does not exist then 0
pressures = importdata(FileName,delimiterIn,headerlinesIn); %Make pressures data
pressures_time = ChangeLengthOfMatrix(pressures,1,0,0,43,0);
pressures_geometry = ChangeLengthOfMatrix(pressures,1,0,1,41,1);
pressures_angle = ChangeLengthOfMatrix(pressures,1,0,3,40,0);
pressures = ChangeLengthOfMatrix(pressures,1,0,4,0,1); %Make pressures data

%Plot
figure
axis equal
plot(measpoints_data(:,1), measpoints_data(:,2), 'b')
ylim=get(gca,'YLim');
xlim=get(gca,'XLim')
%text(xlim(2),ylim(2),measpoints_data(:,1), measpoints_data(:,2), num2str(measpoints_tags),'Outside top right corner','VerticalAlignment','bottom','HorizontalAlignment','left');
text(measpoints_data(:,1), measpoints_data(:,2), num2str(measpoints_tags), 'HorizontalAlignment', 'center','VerticalAlignment','bottom')
hold on
plot(geometry_data(:,1), geometry_data(:,2), 'g')
hold off
%Proveriti funkciju pdepoly(x,y)!!!!!!!!!!!!!!!!

%[Fd, Fl, M] = AeroforcesFromPressures(pressures_angle, pressures, geometry_data, geometry_trig, measpoints_data);
%fid = fopen('Aeroforces.dat', 'wt');
% formatSpec = '%12.8f\t';
% fprintf(fid, formatSpec, Fd, Fl, M);
% fclose(fid);