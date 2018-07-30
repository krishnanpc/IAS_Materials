import numpy as np
from scipy import misc
import matplotlib.pyplot as plt
img = misc.lena()
OperatorID = 'a'  # One of the four operators to run


def sobel(image):
    image = np.pad(image, 1, 'constant', constant_values=(0))
    gradient_magnitude = np.zeros(image.shape, dtype=np.float64)
    gradient_angle = np.zeros(image.shape, dtype=np.float64)
    for y in range(1, image.shape[1] - 1):
        for x in range(1, image.shape[0] - 1):
            dgx = image[x + 1, y + 1] + image[x + 1, y - 1]
            + 2 * image[x + 1, y] - image[x - 1, y + 1]
            - image[x - 1, y - 1] - 2 * image[x - 1, y]
            dgy = image[x + 1, y + 1] + image[x - 1, y + 1]
            + 2 * image[x, y + 1] - image[x + 1, y - 1]
            - image[x - 1, y - 1] - 2 * image[x, y - 1]
            gradient_magnitude[x, y] = np.sqrt(np.power(dgy, 2)
                                               + np.power(dgx, 2))
            gradient_angle[x, y] = dgx / dgy
    return gradient_magnitude, gradient_angle


def Kirsch(image):
    image = np.pad(image, 1, 'constant', constant_values=(0))
    gradient_magnitude = np.zeros(image.shape, dtype=np.float64)
    gradient_angle = np.zeros(image.shape, dtype=np.float64)
    for y in range(1, image.shape[1] - 1):
        for x in range(1, image.shape[0] - 1):
            maxim = 0
            maxk = 0
            block = image[x - 1: x + 2, y - 1: y + 2]
            for k in range(4):
                #rotate matrix 90 degrees python
                block = np.rot90(block)
                tempgxy = 3 * (block[1, 2] + block[2, 2] + block[2, 1] +
                               block[2, 0] + block[1, 0]) + 5 * (block[0, 0] + block[0, 1] + block[0, 2])
                if tempgxy > maxim:
                    maxim = tempgxy
                    maxk = k
            gradient_magnitude[x, y] = maxim
            gradient_angle[x, y] = np.tan(np.radians((90 + maxk * 45) % 360))
    return gradient_magnitude, gradient_angle


def Roberts(image):
    image = np.pad(image, 1, 'constant', constant_values=(0))
    gradient_magnitude = np.zeros(image.shape, dtype=np.float64)
    gradient_angle = np.zeros(image.shape, dtype=np.float64)
    for y in range(1, image.shape[1] - 1):
        for x in range(1, image.shape[0] - 1):
            cross1 = np.power(image[x, y - 1] - image[x - 1, y], 2)
            cross2 = np.power(image[x, y] - image[x - 1, y - 1], 2)
            gradient_magnitude[x, y] = np.sqrt(cross1 + cross2)
            gradient_angle[x, y] = np.divide(image[x, y - 1] - image[x - 1, y],
                                             image[x, y] - image[x - 1, y - 1])
    return gradient_magnitude, gradient_angle


def Laplacian(image):
    image = np.pad(image, 1, 'constant', constant_values=(0))
    gradient_magnitude = np.zeros(image.shape, dtype=np.float64)
    for y in range(1, image.shape[1] - 1):
        for x in range(1, image.shape[0] - 1):
            gradient_magnitude[x, y] = image[x + 1, y] + image[x - 1, y]
            + image[x, y - 1] - 4 * image[x, y]
    return gradient_magnitude

if (OperatorID == 'a'):
    mag_Roberts, angle_Roberts = Roberts(img)
    plt.imshow(img, cmap=plt.cm.Greys_r)
    plt.figure()
    img_plot = plt.imshow(mag_Roberts, cmap=plt.cm.Greys_r)
    plt.figure()
    img_plot = plt.imshow(angle_Roberts, cmap=plt.cm.Greys_r)
    
elif (OperatorID == 'b'):
    magn_sobel, angle_sobel = sobel(img)
    plt.imshow(img, cmap=plt.cm.Greys_r)
    plt.figure()
    img_plot = plt.imshow(magn_sobel, cmap=plt.cm.Greys_r)
    plt.figure()
    img_plot = plt.imshow(angle_sobel, cmap=plt.cm.Greys_r)

elif (OperatorID == 'c'):
    mag_Kirsch, angle_Kirsch = Kirsch(img)
    plt.imshow(img, cmap=plt.cm.Greys_r)
    plt.figure()
    img_plot = plt.imshow(mag_Kirsch, cmap=plt.cm.Greys_r)
    plt.figure()
    img_plot = plt.imshow(angle_Kirsch, cmap=plt.cm.Greys_r)

elif (OperatorID == 'd'):
    mag_Laplacian = Laplacian(img)
    plt.imshow(img, cmap=plt.cm.Greys_r)
    plt.figure()
    img_plot = plt.imshow(mag_Laplacian, cmap=plt.cm.Greys_r)
