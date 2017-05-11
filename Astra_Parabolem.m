%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Nozzle Parabolem
%
%  Author: Edwin Jacobson
%
%  Description: 
%  This script takes user input in the form of a vector and determines the 
%  exit divergence angle of a bell nozzle as well as the quadratic
%  coefficients. Sample points are created at the inlet of the nozzle to
%  assist the polyfit feature determine a best fit quadratic. Once the
%  quadratic is known, another point is placed slightly after the exit
%  point and the angle is measured to determine the exit divergence angle. 
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear

%--- INPUTS ---
%USER inputs x1,r1,x2,r2,initial, & initial divergence angle
data=[0.5 1.25 14.93 5 30];


%Extract Data input
xdata= [data(1) data(1) data(3) data(3)]; %Vector of x inputs
ydata= [data(2) -data(2) data(4) -data(4)]; %Vecotor of mirrored y inputs
div_a=data(5); %Divergence Angle

xscale=1.5*data(3);
yscale=1.5*data(4);

%Create two points to obtain divergence angle
dx=1/2;
da_x1=data(1);
da_x2=dx+data(1);
da_x3=2*dx+data(1);
da_y1=data(2);
da_y2=da_y1+(dx*tand(div_a));
da_y3=da_y1+(2*dx*tand(div_a));

%Add points to polyfit 
xdata=[xdata da_x2 da_x2 da_x3 da_x3];
ydata=[ydata da_y2 -da_y2 da_y3 -da_y3];


%Create quadratic from four points 
poly=polyfit(ydata, xdata,2);

%Find exit divergence angle using point on quadratic
dx2=dx/2;
xe=xdata(3);
ye=ydata(3);
ye2=ye+dx2;
xe2=poly(1)*ye2^2+poly(2)*ye2+poly(3);
div_angle2=atand((dx2)/(xe-xe2))*-1;

%Add ending points
xdata=[xdata xe2 xe2];
ydata=[ydata ye2 -ye2];

%Plot Results
step=0.01;
y1=ydata(4):step:ydata(2);
y2=ydata(1):step:ydata(3);
y=[y1 y2];
x=polyval(poly,y);
hold on
plot(x,y,'o')
plot(xdata,ydata,'*r','markersize',30)
xlabel('Inches from Throat');
ylabel('Inches from center line');
xlim([-1 xscale])
ylim([-yscale yscale])
grid on

%Print Results
fprintf(' Quadratic Function: X(y)=%fy^2+%fy+%f\n\n ', poly(1), poly(2), poly(3));
fprintf('Exit Divergence Angle: %f°\n\n\n\n ', div_angle2);
