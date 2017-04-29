//These are golden ratios in terms of numbers and angles in degrees
phid=137.5077;
phi=1.618034;
figure;

//plotting simple outward spirals of circles that are phid offset and phi ratio diameter increasing
//initializing basic variables
r_spiral = 1;
r=0.8;
theta=0;

for i=1:1:20
    n=3; //number of sppirals
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
    r_spiral=r_spiral*1.1;
    r=r*1.1;
end
