function dist=distance(XX,YY,XY,n1,n2)
dist = XX*ones(1,n1) + ones(n2,1)*YY' - 2*XY;