library("data.table")

# now it will give the path of the workspace the file from which the information will be extracted
#  ahora dara el path del espacio de trabajo el archivo del cual se estraera la informacion

##setwd("D:/UNIVERSIDAD/CURSOS ONLINE/COURSERA/JOHNS HOPKINS UNIVERSITY/Data Science Programa Especializado/CURSO 4 Exploratory Data Analysis/SEMANA 1/git/ExData_Plotting1")


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

# names(HPC_power)
# head(HPC_power)
# class(HPC_power$Global_active_power)


#The date column is cast to have the information in a standard format
#se hace un cast a la columna de la fecha para tener la informacion en un formato estandar


HPC_power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# names(HPC_power)
# head(HPC_power)
# class(HPC_power$Date)

# Filter Dates for 2007-02-01 and 2007-02-02
# now the subset of data will be obtained only from the required dates.
# ahora se obtendra el subconjunto de datos solo de las fechas requeridas.

HPC_power <- HPC_power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# now prepare the file and format in which the graph will be displayed.
# ahora se prepara al archivo y formato en cual sera desplegladop el grafico.

png("plot1.png", width=480, height=480)

## Plot 1
## now the graph with the information of the information subset is created.
## ahora se creal el grafico con la informacion del subconjunto de informacion.
hist(HPC_power[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()