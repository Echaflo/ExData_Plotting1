# loading libraries to work with tables, it is recommended only to work with the necessary information
# for the file can be too big for Ram memory usage,
# cargando librerias para trabajar con tablas, se recomienda solom trabajar con la informacion necesiaria 
# por el archivo  puede ser muyt grande para el usaop de memoria Ram, 

library("data.table")

# now it will give the path of the workspace the file from which the information will be extracted
#  ahora dara el path del espacio de trabajo el archivo del cual se estraera la informacion

#setwd("D:/UNIVERSIDAD/CURSOS ONLINE/COURSERA/JOHNS HOPKINS UNIVERSITY/Data Science Programa Especializado/CURSO 4 Exploratory Data Analysis/SEMANA 1/trabajo/exdata_data_household_power_consumption")


#Reads in data from file then subsets data for specified dates

# Now the job file will be read
# note that missing information will be displayed with the symbol.?

# Ahora se leera el archivo de trabajo
# tenga en cuenta que  la informacion faltante se mostrara con el simbolo  .?

HPC_power <- data.table::fread(input = "household_power_consumption.txt"
                               , na.strings="?"
)

# A cast will be made to prepare the reading of numerical data in scientific notation
#se hara una cast para peparar la lecturade datos numericos en notacion cientifica

HPC_power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

names(HPC_power)
head(HPC_power)
class(HPC_power$Global_active_power)

#The date column is cast to have the information in a standard format
#se hace un cast a la columna de la fecha para tener la informacion en un formato estandar


HPC_power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

names(HPC_power)
head(HPC_power)
class(HPC_power$dateTime)

HPC_power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
names(HPC_power)
head(HPC_power)
class(HPC_power$Date)



# Filter Dates for 2007-02-01 and 2007-02-02
# now the subset of data will be obtained only from the required dates.
# The operation is done on the new column, in addition to taking into account the dateTime period because now days and hours have been joined. 
# ahora se obtendra el subconjunto de datos solo de las fechas requeridas.
# la operacion se hace sobre la nueva columna, ademas de tener en cuenta el lapso de dateTime por que ahora se unieron dias y horas.


HPC_power <- HPC_power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
#HPC_power <- HPC_power[(dateTime >= "2007-02-01") & (dateTime <= "2007-02-02")]
#HPC_power <- HPC_power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-02")]

png("plot3.png", width=480, height=480)

# Plot 3
## now the graph with the information of the information subset is created.
## ahora se creal el grafico con la informacion del subconjunto de informacion.
plot(HPC_power[, dateTime], HPC_power[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(HPC_power[, dateTime], HPC_power[, Sub_metering_2],col="red")
lines(HPC_power[, dateTime], HPC_power[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
