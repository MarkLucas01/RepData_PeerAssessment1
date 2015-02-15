# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data

```r
# Load the data from your current working directory
dat <- read.csv("activity.csv", na.strings = "NA")

# Set the date column from a factor variable to type date
dat$date <- as.Date(dat$date,'%Y-%m-%d')

# Ignore the missing values in the dataset by adding a new data set (dat2) to 
# exclude the missing values
dat2 <- na.omit(dat)
```

## What is mean total number of steps taken per day?

```r
# 1. Calculate the total # of steps per day
steps_day <- tapply(dat2$steps, dat2$date, sum, na.rm = TRUE)

# 2. Creat a histogram of the total # of steps per day
# Note: dim(steps_day) = 53; this value (the number of days with recorded values) 
# will be used in slicing the histogram; in other words 1 bar on the hist = 1 day
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

## Inputting missing values

```r
# 1. Calculate and report the total number of missing values in the dataset (i.e. the 
#    total number of rows with NAs)
sum(is.na(dat) == TRUE)
```

```
## [1] 2304
```

```r
# 2. Devise a strategy for filling in all of the missing values in the dataset. The 
#    strategy does not need to be sophisticated. For example, you could use the 
#    mean/median for that day, or the mean for that 5-minute interval, etc.

# Strategy = the missing data can be replaced with the average # steps across the set;
#           replacing NAs with 37.3826 in a new data set 

# 3. Create a new dataset that is equal to the original dataset but with the missing 
#    data filled in.

dat3 <- dat
dat3[is.na(dat3)] <- mean(dat2$steps)

# 4. Make a histogram of the total number of steps taken each day and Calculate and 
#    report the mean and median total number of steps taken per day. Do these values 
#    differ from the estimates from the first part of the assignment? What is the 
#    impact of imputing missing data on the estimates of the total daily number of steps?

# Note: unique(dat3$date) = 61; this value (the number of days) will be used in slicing 
#       the histogram; in other words 1 bar on the hist = 1 day

steps_day_w_replaced_nas <- tapply(dat3$steps, dat3$date, sum)
hist(steps_day_w_replaced_nas, breaks=61,
     main="Total Number of Steps per Day",
     xlab="Steps per Day",
     ylab="Number of Occurences")
```

![](PA1_template_files/figure-html/total_missing-1.png) 

```r
# The mean and median for this dataset [NAs replaced with 37.3826] follows...
ds3_mean <- mean(steps_day_w_replaced_nas)
ds3_mean
```

```
## [1] 10766.19
```

```r
ds3_median <- median(steps_day_w_replaced_nas)
ds3_median
```

```
## [1] 10766.19
```

```r
# These values had a very small variation from the original dataset, which were...
ds_mean
```

```
## [1] 10766.19
```

```r
ds_median
```

```
## [1] 10765
```

```r
# The reason for the very small impact to the new dataset is due to the stratedgy of using
# mean from the original dataset to replace NAs; resulting in a more normalized dataset
```


## Are there differences in activity patterns between weekdays and weekends?
