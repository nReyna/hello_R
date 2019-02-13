# hello_R
This repository is meant to hold a few simple R code examples, some may be translations from Python codes (from my gitHub).

The [first_file](https://github.com/nReyna/hello_R/blob/master/Clustering%20Example.R) I looked at was a clustereing example using the [Iris_dataset](https://archive.ics.uci.edu/ml/datasets/iris)

The dataset was cleaned and scaled to avoid introducing bias to our model as well as to accounting for large values helps avoid the curse of dimensionality.

The initial fit of the data was with 3 clusters as we knew before hand there were this many labels.
```{R}
fitK <- kmeans(num_data, 3)
```
We then visualized the clusters based on the different features
[data_iris](https://github.com/nReyna/hello_R/blob/master/Iris_3Clusters.pdf)

Focus on 2 features to see cluster overlap
[sepal_length_versus_sepal_width](https://github.com/nReyna/hello_R/blob/master/Iris_LvsW_K3.pdf)

Created an [Elbow_plot](https://github.com/nReyna/hello_R/blob/master/ElbowPlot_SSE.pdf) to see the amount of squared error reduced as we increased the number of clusters. 

```{R}
wss <- (nrow(num_data)-1)*sum(apply(num_data, 2, var))
for (i in 2:10)
  wss[i] <- sum(kmeans(num_data,i)$withinss)

plot(1:10, wss, type = 'b',main = "Sum of Squared Error (Elbow plot)", 
     xlab = "# of clusters", ylab = 'Within Group Sum of Squares')
```

