#from Tkinter import *
#from ttk import *
from scipy.stats import lognorm
#from tkFileDialog   import askopenfilename
from lmfit.models import VoigtModel,PseudoVoigtModel, LinearModel, GaussianModel
from math import sin,cos,pi,radians,tan,sqrt,log1p,log
from scipy import stats
from scipy.signal import savgol_filter

#import Pmw
import sys
#import tkMessageBox
import matplotlib.pyplot as plt

import numpy as np
import copy
import pylab as pl

path =r'ZnO_STD_Fendas/'

file ='ZnO_STD_101_M_XY.xy'

namefile = path + file

x,y = np.loadtxt(namefile, unpack= True)

plt.plot(x,y)
plt.show()
