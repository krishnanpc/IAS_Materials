# -*- coding: utf-8 -*-
"""
Created on Sun Oct 18 00:29:24 2015

@author: alisaleh
"""

def RotateImage(image,direction):
    if direction.lower() == "horizontal":
       return RotateImageHorizontally(image)
    elif direction.lower() == "vertical":
        return RotateImageVertically(image)
    else:
        raise ValueError('direction should contain the specific direction of image rotation')
    
        
def RotateImageVertically(image):
    imageSizeTuple=image.shape
    ret = image.copy()
    
    if len(imageSizeTuple)>2:
        ret=ret[(ret.shape)[0]::-1,:,:]        
    else:
        ret=ret[(ret.shape)[1]::-1,:]
        
    return ret
    
def RotateImageHorizontally(image):
    imageSizeTuple=image.shape
    ret = image.copy()
    
    if len(imageSizeTuple)>2:
        ret=ret[:,(ret.shape)[1]::-1,:]    
    else:   
        ret=ret[:,(ret.shape)[1]::-1]
        
    return ret