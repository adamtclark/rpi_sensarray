error
rm(list=ls())
setwd("~/Dropbox/Projects/083_SensorNetwork/src/rpi_sensarray/rprog/")
dayofyearlookup<-cumsum(c(0,31,28,31,30,31,30,31,31,30,31,30))
doplot = TRUE

### functions
# smooth function
windowsize = 20

smoothfun = function(x, window = 5) {
  if(is.null(dim(x))) {
    xout = numeric(length(x))
    for(i in 1:length(x)) {
      sq = (i-window):(i+window)
      sq = sq[sq>0 & sq<=length(x)]
      xout[i] = mean(x[sq], na.rm=T)
    }
  } else {
    xout = matrix(nrow = nrow(x), ncol = ncol(x))
    for(i in 1:nrow(x)) {
      sq = (i-window):(i+window)
      sq = sq[sq>0 & sq<=nrow(x)]
      xout[i,] = colMeans(x[sq,], na.rm=T)
    }
  }
  xout
}


### load data
timedat = read.table("../data/time_data_rpz_008.txt", header = F, sep = ";")
air_humtempdat = read.table("../data/air_humtemp_data_rpz_008.txt", header = F, sep = ";")
soil_tempdat = read.table("../data/soil_temp_data_rpz_008.txt", header = F, sep = ";")
soil_moistdat = read.table("../data/soil_moist_data_rpz_008.txt", header = F, sep = ";", fill = TRUE)

## air data
head(air_humtempdat)
colnames(air_humtempdat) = c("date", "Temp1", "Hum1", "Temp2", "Hum2")
air_humtempdat$Temp1 = as.numeric(gsub("AT01: ", "", air_humtempdat$Temp1, fixed=TRUE))
air_humtempdat$Hum1 = as.numeric(gsub("AH01: ", "", air_humtempdat$Hum1, fixed=TRUE))
air_humtempdat$Temp2 = as.numeric(gsub("AT02: ", "", air_humtempdat$Temp2, fixed=TRUE))
air_humtempdat$Hum2 = as.numeric(gsub("AH02: ", "", air_humtempdat$Hum2, fixed=TRUE))

air_humtempdat$year = as.numeric(substr(air_humtempdat$date, 1, 4))
air_humtempdat$month = as.numeric(substr(air_humtempdat$date, 6, 7))
air_humtempdat$day = as.numeric(substr(air_humtempdat$date, 9, 10))
air_humtempdat$hour = as.numeric(substr(air_humtempdat$date, 12, 13))
air_humtempdat$minute = as.numeric(substr(air_humtempdat$date, 15, 16))
air_humtempdat$second = as.numeric(substr(air_humtempdat$date, 18, 19))

air_humtempdat$dayofyear = dayofyearlookup[air_humtempdat$month]+air_humtempdat$day+air_humtempdat$hour/24+air_humtempdat$minute/24/60+air_humtempdat$second/24/60/60

# plot example
if(doplot) {
  par(mfrow=c(2,2), mar=c(2,4,2,1), oma = c(2,0,2,0))
  matplot(air_humtempdat$dayofyear, smoothfun(air_humtempdat[,c("Temp1", "Temp2")], window = windowsize),
          type = "l", xlab = "Day of Year", ylab = "Air Temperature, °C")
  axis(3, at=seq(min(air_humtempdat$dayofyear), max(air_humtempdat$dayofyear), length=8), air_humtempdat$hour[seq(1, nrow(air_humtempdat), length=8)])
  #mtext(side = 3, text = "Hour", line = 2.4)
  
  matplot(air_humtempdat$dayofyear, smoothfun(air_humtempdat[,c("Hum1", "Hum2")], window = windowsize),
          type = "l", xlab = "Day of Year", ylab = "Air Humidity, %")
  axis(3, at=seq(min(air_humtempdat$dayofyear), max(air_humtempdat$dayofyear), length=8), air_humtempdat$hour[seq(1, nrow(air_humtempdat), length=8)])
  #mtext(side = 3, text = "Hour", line = 2.4)
  mtext(side = 3, text = "Hour of Day", line = 0.5, outer = TRUE)
  mtext(side = 1, text = "Day of Year", line = 0.5, outer = TRUE)
}


## soil temp data
head(soil_tempdat)
colnames(soil_tempdat) = c("date", "Temp1", "Temp2", "Temp3")
soil_tempdat$Temp1 = as.numeric(substr(soil_tempdat$Temp1, 17,21))
soil_tempdat$Temp2 = as.numeric(substr(soil_tempdat$Temp2, 17,21))
soil_tempdat$Temp3 = as.numeric(substr(soil_tempdat$Temp3, 17,21))

soil_tempdat$year = as.numeric(substr(soil_tempdat$date, 1, 4))
soil_tempdat$month = as.numeric(substr(soil_tempdat$date, 6, 7))
soil_tempdat$day = as.numeric(substr(soil_tempdat$date, 9, 10))
soil_tempdat$hour = as.numeric(substr(soil_tempdat$date, 12, 13))
soil_tempdat$minute = as.numeric(substr(soil_tempdat$date, 15, 16))
soil_tempdat$second = as.numeric(substr(soil_tempdat$date, 18, 19))

soil_tempdat$dayofyear = dayofyearlookup[soil_tempdat$month]+soil_tempdat$day+soil_tempdat$hour/24+soil_tempdat$minute/24/60+soil_tempdat$second/24/60/60

# plot example
if(doplot) {
  #par(mfrow=c(1,1), mar=c(4,4,4,1))
  matplot(soil_tempdat$dayofyear, smoothfun(soil_tempdat[,c("Temp1", "Temp2", "Temp3")], window = windowsize),
          type = "l", xlab = "Day of Year", ylab = "Soil Temperature, °C")
  axis(3, at=seq(min(soil_tempdat$dayofyear), max(soil_tempdat$dayofyear), length=8), soil_tempdat$hour[seq(1, nrow(soil_tempdat), length=8)])
  #mtext(side = 3, text = "Hour", line = 2.4)
}

## soil moist data
head(soil_moistdat)
colnames(soil_moistdat) = c("date", "Moist1", "Moist2")
soil_moistdat$Moist1 = as.numeric(gsub("C01: ", "", soil_moistdat$Moist1, fixed=TRUE))
soil_moistdat$Moist2 = as.numeric(gsub("C02: ", "", soil_moistdat$Moist2, fixed=TRUE))

soil_moistdat$year = as.numeric(substr(soil_moistdat$date, 1, 4))
soil_moistdat$month = as.numeric(substr(soil_moistdat$date, 6, 7))
soil_moistdat$day = as.numeric(substr(soil_moistdat$date, 9, 10))
soil_moistdat$hour = as.numeric(substr(soil_moistdat$date, 12, 13))
soil_moistdat$minute = as.numeric(substr(soil_moistdat$date, 15, 16))
soil_moistdat$second = as.numeric(substr(soil_moistdat$date, 18, 19))

soil_moistdat$dayofyear = dayofyearlookup[soil_moistdat$month]+soil_moistdat$day+soil_moistdat$hour/24+soil_moistdat$minute/24/60+soil_moistdat$second/24/60/60

# rough callibration
soil_moistdat$Moist1perc = (soil_moistdat$Moist1-310)/(620-310)*100
soil_moistdat$Moist2perc = (soil_moistdat$Moist2-310)/(620-310)*100


# plot example
if(doplot) {
  #par(mfrow=c(1,1), mar=c(4,4,4,1))
  #matplot(soil_moistdat$dayofyear, smoothfun(soil_moistdat[,c("Moist1perc", "Moist2perc")], window = windowsize),
  matplot(soil_moistdat$dayofyear, smoothfun(soil_moistdat[,c("Moist2perc")], window = windowsize),
          type = "l", xlab = "Day of Year", ylab = "Soil Moisture, %")
  axis(3, at=seq(min(soil_moistdat$dayofyear), max(soil_moistdat$dayofyear), length=8), soil_moistdat$hour[seq(1, nrow(soil_moistdat), length=8)])
  #mtext(side = 3, text = "Hour", line = 2.4)
}

