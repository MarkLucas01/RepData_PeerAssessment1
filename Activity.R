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

### What is mean total number of steps taken per day?

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

### What is the average daily activity pattern?

# 1. Time series plot: 5-minute interval (x-axis) and the 
#     average number of steps taken,
#     averaged across all days (y-axis) 
interval_avg_step <- aggregate(steps ~ interval, dat2, FUN=mean)
plot(interval_avg_step$interval, interval_avg_step$steps, type='l',
     main='Average Daily Activity - Time Series Plot',
     xlab='5 Minute Interval', ylab='Number of Steps')

# 2. Which 5-minute interval, on average across all the days
#    in the dataset, contains the maximum number of steps?
interval_avg_step[which(interval_avg_step$steps == max(interval_avg_step$steps)),]

