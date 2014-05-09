

initial <- read.table("household_power_consumption.txt", sep=";", header=T, nrows=100)
View(initial)
classes <- sapply(initial, class)
classes

data <- read.table('household_power_consumption.txt', sep=";", header=T, na.string="?", colClasses = classes)
head(data)
summary(data) 

data1feb <- subset(data, data$Date == "1/2/2007")
head(data1feb)
summary(data1feb) 
dim(data1feb)

data2feb <- subset(data, data$Date == "2/2/2007")
head(data2feb)
summary(data2feb) 
dim(data2feb)

datafeb <- rbind(data1feb, data2feb)
head(datafeb)
summary(datafeb)
View(datafeb)


datafeb$TimeDate <- as.character(paste(datafeb$Date, datafeb$Time, sep=" "))
datafeb$TimeDate2 <- strptime(datafeb$TimeDate, format= "%d/%m/%Y %H:%M:%S")
as.POSIXct(datafeb$TimeDate2)
Sys.setlocale(category = "LC_ALL", locale = "C") # To set labels to English
View(datafeb)

png(file="Plot3.png",width=480, height=480)
plot(datafeb$TimeDate2, datafeb$Sub_metering_1,type="l", ylab="Energy sub metering", xlab="" )
lines(datafeb$TimeDate2, datafeb$Sub_metering_2, col="red")  
lines(datafeb$TimeDate2, datafeb$Sub_metering_3, col="blue")  
legend("topright", lty= 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

