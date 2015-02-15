# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data

```r
# Load the data from your current working directory
dat <- read.csv("activity.csv", na.strings = "NA")

# Set the date column from a factor variable to type date
dat$date <- as.Date(dat$date,'%Y-%m-%d')

# Ignore the missing values in the dataset by adding a new
# data set (dat2) to exclude the missing values
dat2 <- na.omit(dat)
```

## What is mean total number of steps taken per day?

```r
# 1. Calculate the total # of steps per day
steps_day <- tapply(dat2$steps, dat2$date, sum, na.rm = TRUE)

# 2. Creat a histogram of the total # of steps per day
# Note: dim(steps_day) = 53; this value (the number of days with
#       recorded values) will be used in slicing the histogram
hist(steps_day, breaks=53,
     main="Total Number of Steps per Day",
     xlab="Steps per Day",
     ylab="Number of Occurences")
```

![](PA1_template_files/figure-html/steps_day-1.png) 

```r
# 3. Calculate and report the mean & median total steps per day
# Note: the # of steps/day is stored in the steps_day vector
ds_mean <- mean(steps_day)
ds_median <- median(steps_day)

# The mean steps per day is...
ds_mean
```

```
## [1] 10766.19
```

```r
# The median steps per day is...
ds_median
```

```
## [1] 10765
```

## What is the average daily activity pattern?

```r
# 1. Time series plot: 5-minute interval (x-axis) and the 
#     average number of steps taken,
#     averaged across all days (y-axis) 
interval_avg_step <- aggregate(steps ~ interval, dat2, FUN=mean)
plot(interval_avg_step$interval, interval_avg_step$steps, type='l',
     main='Average Daily Activity - Time Series Plot',
     xlab='5 Minute Interval', ylab='Number of Steps')
```

![](PA1_template_files/figure-html/activity_time_series-1.png) 

```r
# 2. Which 5-minute interval, on average across all the days
#    in the dataset, contains the maximum number of steps?
interval_avg_step[which(interval_avg_step$steps == max(interval_avg_step$steps)),]
```

```
##     interval    steps
## 104      835 206.1698
```

## Inputing missing values



## Are there differences in activity patterns between weekdays and weekends?
