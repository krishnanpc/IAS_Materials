import numpy as np # makes numpy accesable as 'np'
from numpy import linalg as la # makes the Linear Algebra Module
                               #accessable as 'la'
sigma  = np.matrix([[15, 5, 9, 3],   # Use the covariance matrix eigenvectors                                     
                    [5, 15, 3, 9],   # as a representation of the data eigenvectors 
                    [9, 3, 15, 5],
                    [3, 9, 5, 15]])
sigma = .25 * sigma

num_samples = 1

# The  mean values of the sample.
mu = np.array([0.0, 0.0, 0.0, 0.0])


# Generate the random samples.
X = np.random.multivariate_normal(mu, sigma, size=num_samples)

ew, ev = la.eig(sigma)
A3 = ev[0:3, :]

print 'Trasformation Matrix'
print A3

print 'Data Points'
print X

Y = A3 * np.transpose(X)

print 'Projected Points'
print Y

X_bar = np.transpose(A3) * Y
print 'Restored points'
print X_bar

MSE = (X_bar[0, 0] - X[0, 0]) ** 2
print MSE
# ev[:,i] is the eigenvector to the eigenvalue ew[i]
# ev*ev.T is the matrix multipl. should give the id. matrix in this example

