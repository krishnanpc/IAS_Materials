# -*- coding: utf-8 -*-
"""
Created on Sun Oct 18 00:23:35 2015

@author: alisaleh
"""

def RotateImageVertically(image):
    imageSizeTuple=image.shape
    ret = image.copy()
    
    if len(imageSizeTuple)>2:
        Red=ret[:,:,0].copy()
        Green=ret[:,:,1].copy()
        Blue=ret[:,:,2].copy()        
        
        Red=Red[(Red.shape)[0]::-1,:]
        Green=Green[(Green.shape)[0]::-1,:]
        Blue=Blue[(Blue.shape)[0]::-1,:]
        
        ret[:,:,0]=Red
        ret[:,:,1]=Green
        ret[:,:,2]=Blue       
        
        if imageSizeTuple[2] > 3:
            Fourth=ret[:,:,3].copy()
            Fourth=Fourth[(Fourth.shape)[0]::-1,:] 
            ret[:,:,3]=Fourth
        return ret
        
    ret=ret[(ret.shape)[1]::-1,:]
    return ret