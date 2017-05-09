%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Parabolem
%
%  Edwin Jacobson
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
format long

%--- INPUTS ---
%USER inputs x1,r1,x2,r2,initial divergence angle, & throat radius, respectively 
data=[0.5 1.25 5 6 15 1];

xdata= [data(1) data(1) data(3) data(3)]; %Vector of mirrored x inputs
ydata= [data(2) -data(2) data(4) -data(4)]; %Vecotor of mirrored y inputs
div_a=data(5); %Divergence Angle

%Create two points to obtain divergence angle
da_x1=0;
da_x2=0.0001;
da_y1=data(6);
da_y2=da_y1+(da_x2*tand(div_a));

%Add points to polyfit 
xdata=[da_x1 da_x1 da_x2 da_x2 xdata];
ydata=[da_y1 -da_y1 da_y2 -da_y2 ydata];

%Fit four points to polynomial (x^2) curve
poly=polyfit(ydata, xdata,2)


%Plot values
counter=1;
y=-10;
while y<10
    x(counter)=poly(1)*y^2+poly(2)*y+poly(3)
    y=y+0.1;
    counter=counter+1;
end

%Plot Results
y=-10:0.1:10;
x=polyval(poly,y)
hold on
plot(y,x,'o')
plot(xdata,ydata,'*r','markersize',30)
xlim([-1 10])
ylim([-10 10])
grid on

%Find exit divergence angle
xl=xdata(4)
yl=ydata(4)
yl2=yl+0.0001
xl2=poly(1)*yl2^2+poly(2)*yl2+poly(3)
div_angle2=atand((yl2-yl)/(xl-xl2))
