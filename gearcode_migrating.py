import numpy as np
import matplotlib.pyplot as mpl

#this is for setting basic parameteres
Mt=150
Mc=np.array([0, 0])
Dt=100
Dr=150
m=5
no_rot  =5    #number of rotations in the simulation
ang_len = no_rot * 3600
t_inc = 0.1   #this is to normalize each increment to 1 degree on the main gear (above line is 3600 not 360)

#diameter check
if Dr> (0.5*Dt):
    print('Correcting the length of the arm...')
    Dr=Dr-(0.5*Dt)
    if Dr> (0.5*Dt):
        print('the arm is longer than the gear..')
        Dr= 0.5*Dt
        print('arm length is corrected to be equal to the pitch radius of the gear!')

#machine parameter
rd=Dr*m

#angle of the line joining the centre of the main gear and driving gear w.r.t positive x axis in degrees is angled
angled=-0
angled=np.deg2rad(angled)
dcentre=np.array([0.5*(Mt+Dt)*m*np.cos(angled), 0.5*(Mt+Dt)*m*np.sin(angled)])

#Pivot Point **this can be floating as well as fixed**
#floating point means it is mounted on an additional gear in the gear train
#Pivot point also has the pin for the sliding link

P=np.array([-500, 300]);

#Adjustable sliding link parameters
l1=400
l2=250

#This is the setup information. Based on this, we mark the innitial position of all the critical points and then using time marching, find the subsequent positions of all the critical
i=0
x=[]
y=[]

for i in range(0,ang_len):
    t=i*t_inc
    alpha=(-t)                                                  #angle of driving gear in degree
    omega= 1 * (Mt/Dt)
    beta1=t*omega                                               #angle of driven gear in degree
    p1 = np.array([((dcentre[0]) + rd * np.cos(np.deg2rad(beta1))), ((dcentre[1]) + rd * np.sin(np.deg2rad(beta1)))])
    sliderlen=np.sqrt((P[0]-p1[0])**2+(P[1]-p1[1])**2)
    uvect1 = np.array([(P[0]-p1[0])/sliderlen, (P[1]-p1[1])/sliderlen])
    p2 =np.array([p1[0]+uvect1[0]*l1 , p1[1]+uvect1[1]*l1])
    uvect2 = np.array([uvect1[1], -1*uvect1[0]])
    p3 =np.array([p2[0]+uvect2[0]*l2, p2[1]+uvect2[1]*l2])
    x.append(p3[0])
    y.append(p3[1])

#this is for plotting layout
p=np.array([Mc[0], dcentre[0], P[0]])
q=np.array([Mc[1], dcentre[1], P[1]])
mpl.plot (p,q,'b')
a=np.array([P[0], p1[0], p2[0], p3[0]])
b=np.array([P[1], p1[1], p2[1], p3[1]])
mpl.plot (a,b,'g')
mpl.plot (x,y)

#circle plot trial
g1x=[]
g1y=[]
for i in range(0,360):
    i=np.deg2rad(i)
    g1x.append((Mt*m*0.5) * np.cos(i))
    g1y.append((Mt*m*0.5) * np.sin(i))

mpl.plot(g1x,g1y,'r-.')

g2x=[]
g2y=[]
for i in range(0,360):
    i=np.deg2rad(i)
    g2x.append(dcentre[0]+ (Dt*m*0.5) * np.cos(i))
    g2y.append(dcentre[1]+ (Dt*m*0.5) * np.sin(i))

mpl.plot(g2x,g2y,'r-.')
mpl.show()

#calculating the
aar=[]
theta=[]
phi=[]
p=[]
q=[]

for i in range(0, ang_len):
    t=i*t_inc
    alpha=-1*t
    theta1 = np.rad2deg(np.arctan2(y[i],x[i]))
    phi.append(alpha + theta1)      #this is in degrees

    aar.append(np.sqrt((x[i])**2+(y[i])**2))
    theta.append(np.deg2rad(t))

    p.append((np.sqrt((x[i])**2+(y[i])**2)) * np.cos(np.deg2rad(alpha +theta1)))
    q.append((np.sqrt((x[i])**2+(y[i])**2)) * np.sin(np.deg2rad(alpha +theta1)))

chi=[]

for i in range(0, len(phi)):
    chi.append(np.deg2rad(phi[i]))

mpl.polar (chi, aar)
mpl.show()

#[x11,y11]=mpl.pol2cart(chi,aar)
