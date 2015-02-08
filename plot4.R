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




#PLOT 4
png("plot4.png") #Initializing png graphics device

par(mfrow=c(2,2))
#Changing global plotting parameters
#To allow for 4 plots on one graphics device
#2 rows, 2 columns

#Same as PLOT 2
with(df_subset,plot(datetime,Global_active_power,
                    type="l",
                    ylab="Global Active Power (kilowatts)",
                    xlab=""))
#Plotting Global_active_power vs. datetime as line series
#y-axis label is "Global Active Power (kilowatts)"
#x-axis label is empty

#Voltage vs. time
with(df_subset,plot(datetime,Voltage,
                    type="l",
                    ylab="Voltage",
                    xlab="datetime"))
#Plotting voltage vs. time as line series
#y-axis label is "Voltage"
#x-axis label is "datetime"


#Same as PLOT 3 except for legend
with(df_subset,plot(datetime,Sub_metering_1,type="l",
                    col="black",
                    ylab="Energy sub metering",
                    xlab=""))
lines(df_subset$datetime,df_subset$Sub_metering_2,col="red")
lines(df_subset$datetime,df_subset$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd=1,
       bty="n", #No border for legend
       cex=0.85, #Resizing legend
       col=c("black","red","blue"))



#Global_reactive_power vs. time
with(df_subset,plot(datetime,Global_reactive_power,
                    type="l",
                    ylab="Global_reactive_power",
                    xlab="datetime"))


dev.off()
#END OF PLOT 4



