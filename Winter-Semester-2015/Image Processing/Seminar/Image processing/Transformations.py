# -*- coding: utf-8 -*-
"""
Created on Tue Nov 10 23:26:47 2015

@author: alisaleh
"""
import numpy as np
from scipy import misc

""" Main equaiton is V=R(V-V0)"""
alpha=45 #nick
Rx = np.matrix([ # rotation around x-axis
        [1,0,0],
        [0,np.cos(alpha),np.sin(alpha)],
        [0,-np.sin(alpha),np.cos(alpha)]
    ])

beta = -60 #pan
Ry = np.matrix([ # rotation around y-axis
        [np.cos(beta),0,-np.sin(beta)],
        [0,1,0],
        [np.sin(beta),0,np.cos(alpha)]
    ])

gamma = 0 #tilt
Rz = np.matrix([ # rotation around z-axis
        [np.cos(gamma),np.sin(gamma),0],
        [-np.sin(gamma),np.cos(gamma),0],
        [0,0,1]
    ])

R = Rx * Ry * Rz

V0=np.matrix([100,75,150])

Vx=np.matrix([0,300,0])

V=R*np.transpose((Vx-V0))

print(V)