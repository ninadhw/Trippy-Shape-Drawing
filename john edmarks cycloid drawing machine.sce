//John Edmark's cycloid Drawing Machine
close;
//input variables
//these are all the variables that a user can edit for changes in the shape:
n1=90; // number of teeth for gears
n2=75;
n3=50;
n4=25;
e=10; //middle gear offset in terms of module
f=5; //inner gear offset in terms of module


//check for offset 'e' and 'f'
if e> (n2-n3)/2 then
    disp ('correcting offset e...');
    e=(n2-n3)/2;
end

if f > n4/2 then
    disp ('correcting offset f...');
    f=n4/2;
end

//working varibles
m=5;//module
r1=n1*m/2;
r2=n2*m/2;
r3=n3*m/2;
r4=n4*m/2;

function []=drawcircle(cx,cy,r,colour)
    for i=1:1:360
        x(i)= cx+ r * cosd(i);
        y(i)= cy+ r * sind(i);
    end
    plot(x,y,colour);
endfunction

//drawing the basic structure of the setup at the first instance
//figure();
//drawcircle(0,0,r1,'r'); //this is the first outer circle
//finding the centre of the second circle
//drawcircle( 0,(r2-r1),r2,'b');
//drawcircle( 0,(r3-r1),r3,'g');
//drawcircle( 0,(r4-r1),r4,'m');

figure();
//drawing cycloid
for i=1:1:3600
    x(i)=(r1-r2)*cosd(i) - (r2) * cosd (((r1-r2)/r2)*i);
    y(i)=(r1-r2)*sind(i) + (r2) * sind (((r1-r2)/r2)*i);
    lc2x(i)=(r1-r2)*cosd(i);
    lc2y(i)=(r1-r2)*sind(i);
end
//plot(x,y,'b');
//drawcircle(0,0,r1,'r');
//drawcircle( 0,(r2-r1),r2,'--b')
//plot(lc2x,lc2y,'--r')
