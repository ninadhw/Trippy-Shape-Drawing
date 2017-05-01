//These are golden ratios in terms of numbers and angles in degrees
phid=137.5077;
phi=1.618034;
figure;

//plotting simple outward spirals of circles that are phid offset and phi ratio diameter increasing
//initializing basic variables
r_spiral = 1;
r=1;
theta=0;
r(1)=r;
for i=1:1:20
    rsp=r_spiral;
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
    r_spiral=r_spiral*phi;
    r=r*phi;
    //disp(r_spiral);
end
