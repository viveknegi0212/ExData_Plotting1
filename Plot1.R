#unzip the downloaded files in a folder
unzip("./exdata_data_household_power_consumption.zip", exdir = "./power_data")

#read data and convert class of date variable spcific
data_file <- read.csv2("./power_data/household_power_consumption.txt", na.strings = "?",
                       header = TRUE, sep = ";", comment.char = "", check.names = F,
                       nrows = 2075259, quote = "\"")
data_file$Date <- as.Date(data_file$Date, format = "%d/%m/%Y")

#subset data and remove old data_file
required_data <- subset(data_file, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_file)

datetime <- paste(as.Date(required_data$Date), required_data$Time)
required_data$Datetime <- as.POSIXct(datetime)

#plot histogram and copy into png device
hist(as.numeric(required_data$Global_active_power), main = "Global Active power", 
     xlab = "Global active power (kilowatts)",
     ylab = "Frequency", col="Red")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
