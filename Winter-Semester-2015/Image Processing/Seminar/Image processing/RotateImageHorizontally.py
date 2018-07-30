# -*- coding: utf-8 -*-
"""
Created on Sat Oct 17 23:38:57 2015

@author: alisaleh
"""

def RotateImageHorizontally(image):
    imageSizeTuple=image.shape
    ret = image.copy()
    
    if len(imageSizeTuple)>2:
        ret=ret[:,(ret.shape)[1]::-1,:]
        return ret
#        Red=ret[:,:,0].copy()
#        Green=ret[:,:,1].copy()
#        Blue=ret[:,:,2].copy()        
#        
#        Red=Red[:,(Red.shape)[1]::-1]
#        Green=Green[:,(Green.shape)[1]::-1]
#        Blue=Blue[:,(Blue.shape)[1]::-1]
#        
#        ret[:,:,0]=Red
#        ret[:,:,1]=Green
#        ret[:,:,2]=Blue       
#        
#        if imageSizeTuple[2] > 3:
#            Fourth=ret[:,:,3].copy()
#            Fourth=Fourth[:,(Fourth.shape)[1]::-1] 
#            ret[:,:,3]=Fourth
#        return ret
        
    ret=ret[:,(ret.shape)[1]::-1]
    return ret