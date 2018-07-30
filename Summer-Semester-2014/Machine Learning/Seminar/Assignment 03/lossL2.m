function err=lossL2(Y_test,YDash_test)
err=.5*(sum(pow2(Y_test-YDash_test)));