
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
plot(required_data$Global_active_power ~ required_data$Datetime,
     type="l", ylab="Global Active Power (kilowatts)", xlab="")
                        
#save to png
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
