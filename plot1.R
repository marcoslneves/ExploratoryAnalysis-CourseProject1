##########################################################################################################
## Coursera Exploratory Analysis Course Project 1 - Plot 1
## Marcos Neves - 12/11/2016
##########################################################################################################

#Download the zip 
if(!file.exists("./data")){
    dir.create("./data")
}

zip_path <- "./data/exdata_data_household_power_consumption.zip"
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists(zip_path)){
    download.file(file_url, destfile=zip_path, method="curl")
} 

if (!file.exists("household_power_consumption.txt")) { 
    ## unzip the file
    unzip(zipfile=zip_path, exdir="./data")
}

data_filename <- "./data/household_power_consumption.txt"
data_clean_filename <- "./data/household_power_consumption_clean.txt"

## check for clean version of household_power_consumption dataset (2880 rows instead of 2 075 259 rows)
if (!file.exists(data_clean_filename)) { 

    #read just one row to get colnames and information about colClasses to help to reag a big file
    data_single_row <- read.table(data_filename, nrow = 1, sep=";", stringsAsFactors=FALSE, header = TRUE, dec=".")
    data_raw_colnames <- names(data_single_row)
    data_raw_colclasses <- c(rep("character", 2), rep("numeric", 7))
    
    print("OUT")
    #read the entire file with some information like colnames and colclass can help it be faster
    data_raw <- read.table(data_filename, header=TRUE, sep=";", col.names = data_raw_colnames, colClasses = data_raw_colclasses, stringsAsFactors=FALSE, dec=".", na.strings = "?")
    data_bydate <- subset(data_raw, Date %in% c("1/2/2007","2/2/2007"))
    
}else{
    # read the clean version filtered by "1/2/2007","2/2/2007"
    data_bydate <- read.table(file = data_clean_filename, header=TRUE, sep=";",  stringsAsFactors=FALSE, dec=".", na.strings = "?")
}


# create a png device
png("plot1.png", width=480, height=480)
# plot
par(mfrow = c(1,1))
with(data_bydate, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
#close device
dev.off()