## Code description

In the provided code a matrix was created containing the data. The dtm matrix contains for each document on the rows
the number of occurance of each term on the columns. The problem is that the code is not taking into consedration the number
of articles with no ground truth while classyfing the data. 

## What needs to be done is :
    * Create a list of the document rows where ground truth is available
    * Train and test on the data from the new list 
    * Create a model with cross validatoin on the new data list
    * how will the testing work for data,  when having a matching point is found how does it get classified (uninong of categories, no categroies or what)
    * Print a roc curve for the cross validation data
    * custom made validation of data ( if real category is 3 words and predectied is 4 or 5 how to mark this)
    * Test on the un clasified data and print the results
