clear all;
clc
% close all;
%%Cycloid Drawing Machine
m=5; %%module (mm)

%%Define the Main Gear
%%Teeth=150;
Mt=150;
Mc=[0 0];
figure;
hold on;
%%Driving gear
%%teeth=50;
Dt=50;
Dr=25; %%times the module (value of Dr has to be less than half of the number of teeth)
if Dr> (0.5*Dt) 
    disp('Correcting the length of the arm...');
    Dr=Dr-(0.5*Dt);
    if Dr> (0.5*Dt) 
        disp('the arm is longer than the gear..')
        Dr= 0.5*Dt;
        disp('arm length is corrected to be equal to the pitch radius of the gear!')
    end
end

%%machine parameter
rd=Dr*m;

%%angle of the line joining the centre of the main gear and driving gear w.r.t positive x axis in degrees is angled
angled=-45;
dcentre=[0.5*(Mt+Dt)*m*cosd(angled) 0.5*(Mt+Dt)*m*sind(angled)];

%%Pivot Point **this can be floating as well as fixed**
%%floating point means it is mounted on an additional gear in the gear train
%%Pivot point also has the pin for the sliding link
%%number of teeth on the last gear with the moving pivot
lastt=30;
anglelast=-135;
lastcentre=[0.5*(Mt+lastt)*m*cosd(anglelast) 0.5*(Mt+lastt)*m*sind(anglelast)];


%%Adjustable sliding link parameters
l1=500;
l2=200;
%%This is the setup information. Based on this, we mark the innitial position of all the critical points and then using time marching, find the subsequent positions of all the critical
i=0;
for t=1:0.5:3600
    i=i+1;
    alpha=-t; %%angle of driving gear in degree
    omegad= 1 * (Mt/Dt);
    omegalast= 1 * (Mt/lastt);
    gamma= omegalast * t;
    beta=t*omegad; %%angle of driven gear in degree
    P= [(lastcentre(1)+ (lastt*m*0.5) * cosd(gamma)) (lastcentre(2)+ (lastt*m*0.5) * sind(gamma))];
    p1 = [((dcentre(1)) + rd * cosd(beta)) ((dcentre(2)) + rd * sind(beta))];
    sliderlen=sqrt((P(1)-p1(1))^2+(P(2)-p1(2))^2);
    uvect1 = [((P(1)-p1(1))/sliderlen) ((P(2)-p1(2))/sliderlen)];
    p2 =[p1(1)+uvect1(1)*l1 p1(2)+uvect1(2)*l1];
    uvect2 = [uvect1(2) -1*uvect1(1)];
    p3 =[p2(1)+uvect2(1)*l2 p2(2)+uvect2(2)*l2];
    x(i)=p3(1);
    y(i)=p3(2);
end
% p1 = [((dcentre(1)) + rd * cosd(0)) ((dcentre(2)) + rd * sind(0))];
% P= [(lastcentre(1)+ (lastt*m*0.5) * cosd(0)) (lastcentre(2)+ (lastt*m*0.5) * sind(0))];
p=[Mc(1) dcentre(1) P(1) p1(1) p2(1) p3(1)];
q=[Mc(2) dcentre(2) P(2) p1(2) p2(2) p3(2)];
plot (p,q)
plot (x,y)

%%circle plot trial
for i=1:1:3600
    g1x(i)= (Mt*m*0.5) * cosd(i);
    g1y(i)= (Mt*m*0.5) * sind(i);
end
plot(g1x,g1y,'red-.')

for i=1:1:3600
    g2x(i)= dcentre(1)+ (Dt*m*0.5) * cosd(i);
    g2y(i)= dcentre(2)+ (Dt*m*0.5) * sind(i);
end
plot(g2x,g2y,'red-.')

for i=1:1:3600
    g2x(i)= lastcentre(1)+ (lastt*m*0.5) * cosd(i);
    g2y(i)= lastcentre(2)+ (lastt*m*0.5) * sind(i);
end
plot(g2x,g2y,'red-.')

figure
i=0;
for t=1:0.5:3600
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
