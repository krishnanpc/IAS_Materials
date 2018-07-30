## -*- coding: utf-8 -*-
#"""
#Spyder Editor
#
#This temporary script file is located here:
#/home/alisaleh/.spyder2/.temp.py
#"""

#B= np.array([ [[111, 112], [121, 122]],
#               [[211, 212], [221, 222]],
#               [[311, 312], [321, 322]] ])
#print(B[0][1][0])               
#S = np.array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
#print(S[:])
#A = np.array([
#[11,12,13,14,15],
#[21,22,23,24,25],
#[31,32,33,34,35],
#[41,42,43,44,45],
#[51,52,53,54,55]])
#print(A[0:3,0:2])
#print(A[3:,:])
#print("new")
#print(A[:,4:])
#
#X = np.arange(28)
#print(X)
#X = np.arange(28).reshape(4,7)

#X = np.arange(28).reshape(2,2,7)
#
#Z=X[0:,:,5:6]
#Z=Z*5;
#print(X)
#print(Z)
#print(np.may_share_memory(X,Z))
import numpy as np
from scipy import misc
import RotateImage as R
import matplotlib.pyplot as plt

X=np.array([255,255,255,255,255,255,255,255,255
            ,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,])
plt.hist(X, bins=[0,50,100,150,200, 255])
plt.show()

#X=misc.imread("Lina.png")
#plt.imshow(X)
#plt.figure()
#
#Z=R.RotateImage(X,"horizontal")
#img_plot = plt.imshow(Z)
#plt.figure()
#
#Y=R.RotateImage(X,"vert")
#img_plot = plt.imshow(Y)
#Z=X.copy()
#Red=Z[:,:,0]
#Green=Z[:,:,1]
#Blue=Z[:,:,2]
#Fourth=Z[:,:,3]
#Red=Red[:,(Red.shape)[1]::-1]
#Green=Green[:,(Green.shape)[1]::-1]
#Blue=Blue[:,(Blue.shape)[1]::-1]
#Fourth=Fourth[:,(Fourth.shape)[1]::-1]
#Y=Z
#Y[:,:,0]=Red
#Y[:,:,1]=Green
#Y[:,:,2]=Blue
#Y[:,:,3]=Fourth
