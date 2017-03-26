%Drawing the orbit of mars from a heliocentric perspective

re=1;
rm=1.5237;

omegae=1;
omegam=1.8809;

for t=1:1:360
    xe=re*cosd(t*omegae);
    ye=re*sind(t*omegae);
    
    xm=rm*cosd(t*omegam);
    ym=rm*sind(t*omegam);
    
    xr(t)=xm-xe;
    yr(t)=ym-ye;
    
end

plot(xr,yr)
    