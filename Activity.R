# Peer Assessment 1 - activity monitoring devices
# Goal - single R markdown document that can be processed by 
#        knitr and be transformed into an HTML file.

library(knitr)

# Load the data from your current working directory
dat <- read.csv("activity.csv", na.strings = "NA")

# Set the date column from a factor variable to type date
dat$date <- as.Date(dat$date,'%Y-%m-%d')

# Ignore the missing values in the dataset by adding a new
# data set (dat2) to exclude the missing values
dat2 <- na.omit(dat)

# 1. Calculate the total # of steps per day
steps_day <- tapply(dat2$steps, dat2$date, sum, na.rm = TRUE)

# 2. Creat a histogram of the total # of steps per day
# Note: dim(steps_day) = 53; this value (the number of days with
#       recorded values) will be used in slicing the histogram
hist(steps_day, breaks=53,
     main="Total Number of Steps per Day",
     xlab="Steps per Day",
     ylab="Number of Occurences")

# 3. Calculate and report the mean & median total steps per day
# Note: the # of steps/day is stored in the steps_day vector
ds_mean <- mean(steps_day)
ds_median <- median(steps_day)

# Next steps