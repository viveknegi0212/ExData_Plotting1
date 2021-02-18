
#read data and convert class of date variable specific
data_file <- read.csv("./power_data/household_power_consumption.txt", na.strings = "?",
                      header = TRUE, sep = ";", comment.char = "", check.names = F,
                      nrows = 2075259, quote = "\"")
data_file$Date <- as.Date(data_file$Date, format = "%d/%m/%Y")

#subset data and remove old data_file
required_data <- subset(data_file, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_file)

#create posixct variable
datetime <- paste(as.Date(required_data$Date), required_data$Time)
required_data$Datetime <- as.POSIXct(datetime)

#plot data
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(required_data,{
        plot(Global_active_power~Datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~Datetime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
        })


#save to png
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
