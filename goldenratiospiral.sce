//These are golden ratios in terms of numbers and angles in degrees
phid=137.5077;
phi=1.618034;
figure;

//plotting simple outward spirals of circles that are phid offset and phi ratio diameter increasing
//initializing basic variables
r_spiral = 1;
r=1;
theta=0;

r_fibo_counter(1)=0;
r_fibo_counter(2)=1;

for i=1:1:20
    r_fibo_counter(i+2)=r_fibo_counter(i)+r_fibo_counter(i+1);
    n=5; //number of spirals
    for j=0:1:n-1
        xc=r_spiral*cosd(theta+ (j* (360/n)));
        yc=r_spiral*sind(theta+ (j* (360/n)));

        a = linspace(0, 360, 100);
        //x axis
        x = xc + r*cosd(a);
        //y axis
        y = yc + r*sind(a);

        //plot the circle
        plot(x, y);
    end
    theta=theta+phid;
    r_spiral=2*sqrt(i);
    //r_spiral=r_fibo_counter(i);
    r=sqrt(i);
    //disp(r);
end

//figure
//n=1:500;
//r=sqrt(n);
//t=phid*%pi/180*n;
//plot(r.*cos(t),r.*sin(t),'x')
