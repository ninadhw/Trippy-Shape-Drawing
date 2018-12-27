clear
A = [0,0];
B = [10,0];
C = [10,10];
D = [0,10];

array1=[A(1);B(1);C(1);D(1)];
array2=[A(2);B(2);C(2);D(2)];
figure(1)

plot(array1,array2)

for i=0:0.5:10
    p1=array1(1)+i;
    q1=array1(2);
    r1=array1(3)-i;
    s1=array1(4);

    p2=array2(1);
    q2=array2(2)+i;
    r2=array2(3);
    s2=array2(4)-i;

    arrayp1=[p1 q1 r1 s1 p1];
    arrayp2=[p2 q2 r2 s2 p2];
    plot(arrayp1,arrayp2);
end


clear

figure(2)


r=10;
theta=0;
i=1;
for theta=0:0.5:360
    x(i)=r*sind(theta);
    y(i)=r*cosd(theta);
    i=i+1;
end
plot(x,y);
clear theta;
clear i;
clear x;
clear y;
dibber=121;
theta=1;
i=1;
while theta-fix(theta./360).*360 ~= 0
    p(i)=r*sind(theta);
    q(i)=r*cosd(theta);
    i=i+1;
    theta=theta+dibber;
    disp(i)
end

plot(p,q)

clear 
figure

r=31.4;
theta=0;
i=1;
for theta=0:0.5:360
    x(i)=r*sind(theta);
    y(i)=r*cosd(theta);
    i=i+1;
end
plot(x,y);

clear
a=31.4;
b=10;
theta=0;

for theta=1:1:5000
    x(theta)=(a-b)*cosd(theta) + b*cosd (((a-b)/(b))*theta);
    y(theta)=(a-b)*sind(theta) - b*sind (((a-b)/(b))*theta);
end

plot(x,y)


clear 
figure

r=70;
theta=0;
i=1;
for theta=0:0.5:360
    x(i)=r*sind(theta);
    y(i)=r*cosd(theta);
    i=i+1;
end
plot(x,y);

clear
a=70;
b=45;
theta=0;

for theta=1:1:3000
    x(theta)=(a-b)*cosd(theta) + b*cosd (((a-b)/(b))*theta);
    y(theta)=(a-b)*sind(theta) - b*sind (((a-b)/(b))*theta);
end

plot(x,y)
