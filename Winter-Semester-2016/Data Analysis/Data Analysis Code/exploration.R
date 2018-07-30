data("iris")
pdf("exploration.pdf", width = 5, height = 4)

iris[51, 5]  #show 51 row, column 5
iris[51:52,"Species"] #show rows in the "species" column
iris.setosa <- subset(iris, iris$Species == "setosa")

#Histogram
hist(iris$Petal.Length, nclass=25, main="")
hist(iris.setosa$Sepal.Length, nclass=25, main="")
hist(iris$Sepal.Length, breaks = 20, probability = T, xlim = c(4, 8), ylim = c(0.0, 1.0), col = "pink", xlab = "Sepal Length (cm)", main = "IRIS")
lines(density(iris$Sepal.Length), col = "blue", lwd = 2)

library(FSA)
hist(iris$Sepal.Length ~ iris$Species,data=iris,
          type="count",
          xlab="Sepal Length",
          main="Iris Dataset")
          

#Plots
#show relation btw speal length and width only for iris Setosa
#plot(iris.setosa$Sepal.Length, iris.setosa$Sepal.Width,xlab = "setosa Sepal Length", ylab = "setosa Sepal Width", col = 14)
#pairs(iris) #without colours
pairs(iris, col=iris$Species) #with colours

# #show relation btw width and length of all 3 classes, highlight the block code for it to work
#pch points shape is "circle/21"
plot(Sepal.Width ~ Sepal.Length, data = iris, subset = iris$Species ==
       "setosa", xlim = c(4, 8), ylim = c(1, 6), col = "red")
points(Sepal.Width ~ Sepal.Length, data = iris, subset = iris$Species ==
           "versicolor", col = "lightgreen")
points(Sepal.Width ~ Sepal.Length, data = iris, subset = iris$Species ==
           "virginica", col = "blue")
legend("topleft",legend = c("setosa", "versicolor", "virginica"),
       pch = c(21, 21, 21), col = c("red", "lightgreen", "blue")) 

#Plotting desnity function
plot(density(iris.setosa$Sepal.Width))
plot(density(iris.setosa$Sepal.Length))
plot(density(iris$Sepal.Length))

#cummulative distribution function
#plot(ecdf(iris$Petal.Length), col="blue", main="Iris Petal length cdf")

#some Info
head(iris)  #show the first 6 lines
class(iris) #show the class type
tail(iris)  #show the last 6 lines
levels(iris$Species)
help(levels)
summary(iris)

for (spec in levels(iris$Species)){
print(spec)
 y = iris[iris$Species==spec,]
print(max(y$Sepal.Length))
}
#some conclusions
#virginica has longest Petal length
#virginica has longest Sepal length
#setosa has widest speals
#virginica has widest Petal

#boxPlots
boxplot(Petal.Width ~ Species, data = iris, main = "Petal Width")
boxplot(Petal.Length ~ Species, data = iris, main = "Petal Length")

#Correlation Calculation/pearson
plot(iris.setosa$Sepal.Length, iris.setosa$Sepal.Width, pch = 1, xlab = "setosa Sepal Length", ylab = "setosa Sepal Width", col = 14)
cor(iris.setosa$Sepal.Length,iris.setosa$Sepal.Width, method = "pearson") #0.7425467 +ve correlation
plot(iris[,1:4], col=iris$Species) #exclude the species column
cor(iris[,1:4])

#=========================================== #playing around ==================#
#Convert species column into numerics
# d = iris
# d$Species = as.numeric(d$Species)
# cor(d)      #correct result/can use it and just ignore species numbers....
# corrplot(cor(d), method = "circle") # the right plot
#remove(d)

#Exporting as latex to pdf/summary table
#newobj = xtable()
#print.xtable(summary(iris), caption = "Summary statistic of iris data")
#xtable(summary(iris), caption = "Summary statistic of iris data")
#============================================================================#

dev.off()