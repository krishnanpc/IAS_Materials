from scipy import misc
from scipy import signal
import numpy as np
import matplotlib.pyplot as plt

def rgb2gray(rgb):

    r, g, b = rgb[:,:,0], rgb[:,:,1], rgb[:,:,2]
    gray = 0.2989 * r + 0.5870 * g + 0.1140 * b

    return gray

X=misc.imread('image.png')

#   plt.imshow(X)
img=rgb2gray(X)
plt.imshow(img, cmap = matplotlib.cm.Greys_r)
grad = signal.convolve2d(img, img, boundary='symm', mode='same')
plt.figure()
plt.imshow(grad, cmap = matplotlib.cm.Greys_r)
