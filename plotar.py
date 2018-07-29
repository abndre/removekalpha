from math import sin,cos,pi,radians,tan,sqrt,log1p,log
import matplotlib.pyplot as plt
import numpy as np

path =r'ZnO_STD_Fendas/DEF/'
file = 'ZnO_STD_F_XY.xy'
#file = 'ZnO_STD_202_F_XY.xy'
namefile = path + file
x,y = np.loadtxt(namefile, unpack= True)


def plotar():
    plt.plot(x,y)
    plt.show()

def removekalpha(x,y):
    lambida2=1.541220
    lambida1=1.537400
    deltaL = lambida2 - lambida1
    deltaL = deltaL/lambida1
    diferenca=x[1]-x[0]
    minimo=min(y)
    novoy=[]
    for i in range(len(y)):
        deltasoma = x[1]-x[0]
        ase= np.tan(np.radians(x[i]/2))*2*deltaL/(diferenca)
        n=1;

        while(ase>deltasoma):
            deltasoma=deltasoma+diferenca
            n+=1
        try:
            yy=y[i]-0.5*y[i-n]

            if yy<0:yy=(yy+y[i])/8

            if yy<0:yy=minimo
            novoy.append(yy)
        except:
            novoy.append(y[i])

    return novoy

plt.plot(x,removekalpha(x,y))

plotar()
