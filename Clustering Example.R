# Will expirement with classic iris data set the k-means algorithm

# read in Iris data set (did not save as CSV)
data_iris = read.delim('Iris.data', header = FALSE, sep = ',')


# append coherent/descriptive names to variables (columns)
colnames(data_iris) <- c("sepal_length", "sepal_width", 
                         "petal_length", "petal_width",
                         "class")
# Verify data visually
View(data_iris)

# create a copy of our data set and 
# remove our categorical variable (Class)
num_data = data_iris
num_data$class <- NULL

# only numerical data
View(num_data)

# can also view plots of the data set
## plot(num_data)

# Scale data to avoid introducing bias to our model 
# also for large values helps avoid the curse of dimensionality
num_data <- scale(num_data)

fitK <- kmeans(num_data, 3)


# visualize the clusters based on the different features
plot(data_iris, col = fitK$cluster)

# Focus on 2 features to see cluster overlap
plot(data_iris[c('sepal_length', 'sepal_width')], col = fitK$cluster)
