# I will use hypothesis testing to analyze Click Through Rate (CTR) 
# on the New York Times website. 
# 
# CTR is defined as the number of clicks a user makes per impression 
# that is made upon the user. 
# 
# We are going to determine if there is statistically significant 
# difference between the mean CTR for the following groups:
#   1) Signed in users v.s. Not signed in users
#   2) Male v.s. Female
# 
# default significance level for \alpha = 0.05 will be used

# Read in the data set
df <- read.csv('nyt1.csv')

head(df,2)

# Boolean mask to find obs. where Impression not 0
# == df[df[,3] != 0,]
df = df[df[ ,"Impressions"] != 0, ]

df$CTR <- as.numeric(df$Clicks / df$Impressions)

head(df, 20)

# Look over the distributions of the variables
hist(df$Age,         col = 'blue')
hist(df$Gender,      col = 'blue')
hist(df$Impressions, col = 'blue')
hist(df$Signed_In,   col = 'blue')
hist(df$Clicks,      col = 'blue')
hist(df$CTR,         col = 'blue')

df_SignedIn     = df[df[ ,"Signed_In"] == 1, ]
df_not_SignedIn = df[df[ ,"Signed_In"] == 0, ]

# proportion of users signed in
length(df_SignedIn[ ,1]) / length(df[ ,1])


# Look over distributions of our new data frames
# do not need to look at distribution of SignedIn
# since we have already split the data on it
hist(df_SignedIn$Age,         col = 'green')
hist(df_SignedIn$Gender,      col = 'green')
hist(df_SignedIn$Impressions, col = 'green')
hist(df_SignedIn$Clicks,      col = 'green')
hist(df_SignedIn$CTR,         col = 'green')

# we do not know the Age & Gender b/c not signedIn
hist(df_not_SignedIn$Age,         col = 'red')
hist(df_not_SignedIn$Gender,      col = 'red') 

hist(df_not_SignedIn$Impressions, col = 'red')
hist(df_not_SignedIn$Clicks,      col = 'red')
hist(df_not_SignedIn$CTR,         col = 'red')

head(df_not_SignedIn, 3)

Mu_SignedIn = mean(df_SignedIn$CTR)
Mu_not_SnIn = mean(df_not_SignedIn$CTR)

t.test(df_SignedIn$CTR, df_not_SignedIn$CTR)

# Welch Two Sample t-test
# 
# df_SignedIn$CTR (x) and df_not_SignedIn$CTR (y)
#
# t = -55.376, df = 196540, p-value < 2.2e-16
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -0.01460037 -0.01360217
# 
# sample estimates:
#   mean of x  mean of y 
# 0.01425364 0.02835491 


# with such a small p-value we would reject the null hypothesis as there is
# statistically significant evidence to say that the means are in fact not equal



# == == == == == == == == == == == == == == == == == == == == == == == == == ==
# Gender is only known for the SignedIn users so we 
# will create subsets from that data set
df_F = df_SignedIn[df_SignedIn[ ,"Gender"] == 0, ]
df_M = df_SignedIn[df_SignedIn[ ,"Gender"] == 1, ]

# proportion of Female users signed in
length(df_F[ ,1]) / length(df_SignedIn[ ,1])

t.test(df_F$CTR, df_M$CTR)
# df_F$CTR and df_M$CTR
# 
# t = 3.2898, df = 314940, p-value = 0.001003
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   0.0002843637 0.0011226120
# 
# sample estimates:
#   mean of x  mean of y 
# 0.01462201 0.01391852 

# with such a small p-value we would reject the null hypothesis as there is
# statistically significant evidence to say that the means are in fact not equal
# however, we should also not that the difference in the means here is rather small
# mean(df_F$CTR) -  mean(df_M$CTR) = 0.0007034879

mean(df_F$CTR) -  mean(df_M$CTR)
