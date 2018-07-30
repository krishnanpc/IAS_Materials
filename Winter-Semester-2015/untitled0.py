# -*- coding: utf-8 -*-
"""
Created on Wed Dec  9 01:33:00 2015

@author: alisaleh
"""

import sys
import numpy as np
from scipy import misc
from scipy import signal
import matplotlib.pyplot as plt
import Image

roberts_cross_v = np.array( [[ 0, 0, 0 ],
                             [ 0, 1, 0 ],
                             [ 0, 0,-1 ]] )

roberts_cross_h = np.array( [[ 0, 0, 0 ],
                             [ 0, 0, 1 ],
                             [ 0,-1, 0 ]] )
def load_image( infilename ) :
    img = Image.open( infilename )
    img.load() 
    # note signed integer
    return np.asarray( img, dtype="int32" )

def save_image( data, outfilename ) :
    img = Image.fromarray( np.asarray( np.clip(data,0,255), dtype="uint8"), "L" )
    img.save( outfilename )

def roberts_cross( image ) :
    
    vertical = signal.convolve2d(image, roberts_cross_v, boundary='symm', mode='same')
    
    horizontal = signal.convolve2d(image, roberts_cross_h , boundary='symm', mode='same')

    output_image = np.sqrt( np.square(horizontal) + np.square(vertical))

    return output_image

image  = misc.lena()
output = roberts_cross( image )

plt.imshow(image, cmap = plt.cm.Greys_r)
plt.figure()
img_plot = plt.imshow(output, cmap = plt.cm.Greys_r)

