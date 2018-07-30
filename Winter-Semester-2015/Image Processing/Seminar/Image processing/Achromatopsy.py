# -*- coding: utf-8 -*-
"""
Created on Wed Oct 28 23:18:16 2015

@author: alisaleh
"""

import numpy as np
from scipy import misc
from PIL import Image
import matplotlib.pyplot as plt
import random

rgbArray = np.zeros((512,512,3), 'uint8')

rgbArray[50:100,50:100, 0] = 255
rgbArray[:,:, 1] = 255
rgbArray[:,:, 2] = 255

img = Image.fromarray(rgbArray)


#
#from PIL import Image
#
#pilImage = Image.frombuffer('RGBA',(w,h),img,'raw','RGBA',0,1)
#pilImage.save('my.png')


plt.figure()
img_plot = plt.imshow(img)
