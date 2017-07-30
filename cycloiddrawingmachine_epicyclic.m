clear all;
clc

%all user input variables:
Mt=150; %centre of the main gear
Dt=75;
Dr=25; %%times the module (value of Dr has to be less than half of the number of teeth)
angled=-45; %angle of driving gear versus main gear x-y frame
lastt=25; %last gear teeth
anglelast=-135; %last gear angle versus main gear x-y frame
l1=500; %%Adjustable sliding link parameters
l2=200;

%planet and sun
sunt=20; %should be less than half of the dt
%it is assumed that the sun is fixed

if sunt> (0.5 * Dt)
    sunt=0.5*Dt;
    disp('\nsun too large');
end

plt=(Dt-sunt)/2;
plt=5;
% close all;
%%Cycloid Drawing Machine
m=5; %%module (mm)

%%Define the Main Gear
%%Teeth=150;

Mc=[0 0];
figure;
hold on;
%%Driving gear
%%teeth=50;

if Dr> (0.5*Dt) 
    disp('Correcting the length of the arm...');
    Dr=Dr-(0.5*Dt);
    if Dr> (0.5*Dt) 
        disp('the arm is longer than the gear..')
        Dr= 0.5*Dt;
        disp('arm length is corrected to be equal to the pitch radius of the gear!')
    end
end

%using basic geometry and the position of the centre 

%%machine parameter
rd=Dr*m;
rplanet=plt*m/2;
rsun=sunt*m/2;
%%angle of the line joining the centre of the main gear and driving gear w.r.t positive x axis in degrees is angled

dcentre=[0.5*(Mt+Dt)*m*cosd(angled) 0.5*(Mt+Dt)*m*sind(angled)];

%%Pivot Point **this can be floating as well as fixed**
%%floating point means it is mounted on an additional gear in the gear train
%%Pivot point also has the pin for the sliding link
%%number of teeth on the last gear with the moving pivot
lastcentre=[0.5*(Mt+lastt)*m*cosd(anglelast) 0.5*(Mt+lastt)*m*sind(anglelast)];


%%This is the setup information. Based on this, we mark the innitial position of all the critical points and then using time marching, find the subsequent positions of all the critical
i=0;
for t=1:0.1:360
    i=i+1;
    alpha=-t; %%angle of driving gear in degree
    omegad= 1 * (Mt/Dt);
    omegalast= 1 * (Mt/lastt);
    gamma= omegalast * t;
    beta=t*omegad; %%angle of driven gear in degree
    P= [(lastcentre(1)+ (lastt*m*0.5) * cosd(gamma)) (lastcentre(2)+ (lastt*m*0.5) * sind(gamma))];
    %p1 = [((dcentre(1)) + rd * cosd(beta)) ((dcentre(2)) + rd * sind(beta))];
    %pin joint moving on a planet gear
    pix(i)=((dcentre(1))+ ((rplanet+rsun)*cos(t) - rplanet*cos((rplanet+rsun)*t/rplanet)));
    piy(i)=((dcentre(2))+ ((rplanet+rsun)*sin(t) - rplanet*sin((rplanet+rsun)*t/rplanet)));
    p1=[pix(i) piy(i)];
    sliderlen=sqrt((P(1)-p1(1))^2+(P(2)-p1(2))^2);
    uvect1 = [((P(1)-p1(1))/sliderlen) ((P(2)-p1(2))/sliderlen)];
    p2 =[p1(1)+uvect1(1)*l1 p1(2)+uvect1(2)*l1];
    uvect2 = [uvect1(2) -1*uvect1(1)];
    p3 =[p2(1)+uvect2(1)*l2 p2(2)+uvect2(2)*l2];
    x(i)=p3(1);
    y(i)=p3(2);
    plot(p1);
end
% p1 = [((dcentre(1)) + rd * cosd(0)) ((dcentre(2)) + rd * sind(0))];
% P= [(lastcentre(1)+ (lastt*m*0.5) * cosd(0)) (lastcentre(2)+ (lastt*m*0.5) * sind(0))];
p=[Mc(1) dcentre(1) P(1) p1(1) p2(1) p3(1)];
q=[Mc(2) dcentre(2) P(2) p1(2) p2(2) p3(2)];
plot (p,q)
plot (x,y)

%%circle plot trial
for i=1:1:360
    g1x(i)= (Mt*m*0.5) * cosd(i);
    g1y(i)= (Mt*m*0.5) * sind(i);
end
plot(g1x,g1y,'red-.')

for i=1:1:360
    g2x(i)= dcentre(1)+ (Dt*m*0.5) * cosd(i);
    g2y(i)= dcentre(2)+ (Dt*m*0.5) * sind(i);
end
plot(g2x,g2y,'red-.')

for i=1:1:360
    g2x(i)= lastcentre(1)+ (lastt*m*0.5) * cosd(i);
    g2y(i)= lastcentre(2)+ (lastt*m*0.5) * sind(i);
end
plot(g2x,g2y,'red-.')
plot(pix,piy);


figure
i=0;
for t=1:0.1:360
    i=i+1;
    alpha=-1*t;
    theta1 = atan2d(y(i),x(i));
    aar(i)= sqrt((x(i))^2+(y(i))^2);
    theta(i)= t*pi/180;
    phi(i)=(alpha+theta1);
    p(i)= aar(i) * cos(alpha+theta1);
    q(i)= aar(i) * sin(alpha+theta1);
end

%%this is obviously wrong, but the angular difference, I can't capture this just yet
%%polarplot(phi,aar)
%%polarplot (theta, aar);
%%polarplot((0:0.1:2*%pi),Mt*m*0.5);

for i=1:1:length(phi)
    chi(i)=(phi(i)+i)*pi/180;
end
grid off;
polar (chi, aar);
hold on;
k=0:0.01:2*pi;
si=size(k);
l=Mt*m*0.5*ones(1,si(2));
polar(k,l);


[x11,y11]=pol2cart(chi,aar);

A=[x11',y11'];
eo=fopen('output2.txt','w');
fprintf(eo,'%0.2f,%0.2f\r\n',A');
fclose(eo);
