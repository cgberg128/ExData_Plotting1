library(dplyr)
library(lubridate)
library(data.table)
#These 3 libraries are required


#Dataset downloaded from the following link:
#http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip


setwd("C:/Users/cberi/Desktop/Development_Time/Coursera Courses/Johns Hopkins Data Science/Exploratory Data Analysis/Assignments/#1")
#Change working directory to where the "household_power_consumption.txt"
#file is located


df <- fread("household_power_consumption.txt",header=TRUE)
#Reading in our data quickly using fread function from data.table package
df_subset <- df  %>% 
  filter(Date=="1/2/2007" | Date=="2/2/2007") %>%
  mutate(datetime=as.POSIXct(strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),"GMT"),
         Global_active_power = as.numeric(Global_active_power),
         Sub_metering_1 = as.numeric(Sub_metering_1),
         Sub_metering_2 = as.numeric(Sub_metering_2),
         Sub_metering_3 = as.numeric(Sub_metering_3),
         Global_reactive_power = as.numeric(Global_reactive_power),
         Voltage = as.numeric(Voltage),
         Global_intensity = as.numeric(Global_intensity))
#Subsetting our data to filter on data from either Feb 1,2007 or Feb 2, 2007
#Changing many variables to numeric type for plotting purposes


#PLOT 3
png("plot3.png") #Initializing png graphics device
with(df_subset,plot(datetime,Sub_metering_1,type="l",
                    col="black",
                    ylab="Energy sub metering",
                    xlab=""))
#Initializing plot of sub_metering_1 data vs. datetime
lines(df_subset$datetime,df_subset$Sub_metering_2,col="red")
#Adding red line series for Sub_metering_2 data
lines(df_subset$datetime,df_subset$Sub_metering_3,col="blue")
#Adding blue line series for Sub_metering_3_data
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd=1,
       col=c("black","red","blue"))
#Adding legend in top right
#So user can clearly tell which data represents which sub_metering series

dev.off() #Turning graphics device off
#END OF PLOT 3

