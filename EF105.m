%% EF 105 Matlab Numerical Integration Example 2
clear all, close all, clc, format compact, format long g;

%% Numerical integration of a function from x1 to x2
F = inline('sin(x)');  % function to integrate
x1=0; x2=pi;           % limits
a1 = quad(F,x1,x2);    % use quad to integrate

%% Show the curve and display a message to define the problem
fplot(F,[x1,x2])       % a quick way to plot a function
msg = sprintf('What is the integral of %s from %.2f to %.2f?',formula(F),x1,x2);
disp(msg); waitfor(msgbox(msg));

%% Show the result
msg = ['Area calculated by the quad function = ' num2str(a1,10)];
disp(msg); waitfor(msgbox(msg));

%% Approximate the integral via trapz for different numbers of points
for np=[5 10 25 50]
    clf                     % clear the current figure    
    hold on                 % allow stuff to be added to this plot
    
    x = linspace(x1,x2,np); % generate x values
    y = F(x);               % generate y values
    a2 = trapz(x,y);        % use trapz to integrate
    
    % Generate and display the trapezoids used by trapz
    for ii=1:length(x)-1
        px=[x(ii) x(ii+1) x(ii+1) x(ii)];
        py=[0     0       y(ii+1) y(ii)];
        fill(px,py,ii)
    end

    fplot(F,[x1,x2]);       % plot the actual curve for reference
    msg = sprintf('Area calculated by trapz function with %u points = %.8f',np,a2);
    disp(msg); waitfor(msgbox(msg));
end