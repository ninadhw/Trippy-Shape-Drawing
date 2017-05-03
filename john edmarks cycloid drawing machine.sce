//John Edmark's cycloid Drawing Machine

//input variables
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
