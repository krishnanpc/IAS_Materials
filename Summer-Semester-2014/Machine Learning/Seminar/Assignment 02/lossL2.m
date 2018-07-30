function err=lossL2(Y_test,YDash_test)
n=length(Y_test);
err=1/n*(sum(pow2(Y_test-YDash_test)));