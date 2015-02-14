# Peer Assessment 1 - activity monitoring devices

# Load & preprocess the data
dat <- read.csv("activity.csv", na.strings = "NA")
dat$date <- as.Date(dat$date,'%Y-%m-%d')

# ignore the missing values in the dataset
dat2 <- na.omit(dat)

# 1. Calculate the total # of steps / day
steps_day <- tapply(dat2$steps, dat2$date, sum, na.rm = TRUE)

# 2. Creat a histogram of the total # of steps / day
# Note: dim(steps_day) = 53; this value (the number of days with
#       recorded values) will be used in slicing the histogram
hist(steps_day, breaks=53,
     main="Total Number of Steps per Day",
     xlab="Steps per Day",
     ylab="Number of Occurences")

# 3. Calculate and report the mean & median total steps / day
# Note: the # of steps/day is stored in the steps_day vector
ds_mean <- mean(steps_day)
ds_median <- median(steps_day)
