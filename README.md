# hello_R
This repository is meant to hold a few simple R code examples, some may be translations from Python codes (from my gitHub).

1) The [first_file](https://github.com/nReyna/hello_R/blob/master/Clustering%20Example.R) I looked at was a clustereing example using the [Iris_dataset](https://archive.ics.uci.edu/ml/datasets/iris)

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


2) This [second_file]() 
focuses on the use of hypothesis testing to analyze Click Through Rate (CTR) for a subset of data from the New York Times website. 
Here we define, _CTR_ as the number of clicks a user makes per impression that is made upon the user. 

We are going to determine if there is statistically significant difference between the mean CTR for the following groups:
  1) Signed in users v.s. Not signed in users
  
  2) Male v.s. Female

A default _significance level_ for $\alpha$ = 0.05 will be used.

We start our analysis of the data by looking over the distributions for each of the variables:
```{R}
hist(df$Age,         col = 'blue')
hist(df$Gender,      col = 'blue')
hist(df$Impressions, col = 'blue')
hist(df$Signed_In,   col = 'blue')
hist(df$Clicks,      col = 'blue')
hist(df$CTR,         col = 'blue')
```
Then as we split the dataset into a) users who are signed in and b) not signed in we again look over the histograms to see 
if there are any drastic changes. 

One such change is that we do not know user's Age nor Gender when they arc not signed in. So the historgrams offer no insight.
```{R}
hist(df_not_SignedIn$Age,         col = 'red')
hist(df_not_SignedIn$Gender,      col = 'red') 
```

Applying a _Welch Two Sample t-test_ where:
$H_0$: The means of users signed in is equal to that of users _not_ signed in.

$H_a$: The difference in the means is not equal to 0

```{R}
t.test(df_SignedIn$CTR, df_not_SignedIn$CTR)
```
we find that the 
**p-value < 2.2e-16 < $\alpha$**

with such a small p-value we would REJECT the null hypothesis.

To try and explore hypothesis testing based on Gender we look at the users which are signed in. 
```{R}
df_F = df_SignedIn[df_SignedIn[ ,"Gender"] == 0, ]
df_M = df_SignedIn[df_SignedIn[ ,"Gender"] == 1, ]
```
Then our hypothesis become

$H_0$: The mean CTR for Male users that signed in is equal to that of the Female usersthat are signed in.

$H_a$: The difference in the means is not equal to 0
```{R}
t.test(df_F$CTR, df_M$CTR)
```
again we find a p-value that is less than our significance level and we REJECT the null hypothesis.

However, we should also note that the difference in the means here is rather small, 
```{R}
mean(df_F$CTR) -  mean(df_M$CTR) = 0.0007034879.
```

