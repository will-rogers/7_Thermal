setwd("G:/Shared drives/KNP data & logistics/buffalo data/old files_july 2023/FLIR data/FLIR photos/TB Experiment")
path <- "G:/Shared drives/KNP data & logistics/buffalo data/11Aug2023_buffalo_boma_project/1_Project Data/4_FLIR_data"
files <- list.files(path, recursive = T)

list.of.packages <- c(
  "foreach",
  "doParallel",
  "ranger",
  "palmerpenguins",
  "tidyverse",
  "kableExtra"
)

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

if(length(new.packages) > 0){
  install.packages(new.packages, dep=TRUE)
}

#loading packages
for(package.i in list.of.packages){
  suppressPackageStartupMessages(
    library(
      package.i, 
      character.only = TRUE
    )
  )
}

parallel::detectCores()
n.cores <- parallel::detectCores() - 1
my.cluster <- parallel::makeCluster(
  n.cores, 
  type = "PSOCK"
)

print(my.cluster)


doParallel::registerDoParallel(cl = my.cluster)
foreach::getDoParRegistered()
foreach::getDoParWorkers()
library(pdftools)
library("exiftoolr")
library(tidyverse)
images <- files[str_detect(files, ".jpg")]
timestamps <- rep(NA, length(images))

x <- foreach(
  i = 1:length(images), 
  .combine = 'c',
  .packages = "exiftoolr"
) %dopar% {
  exif_read(paste(path, images[i], sep="/"))$FileModifyDate
}
timestamps <- x

parallel::stopCluster(cl = my.cluster)

date <- as.POSIXct(timestamps, format = "%Y:%m:%d %H:%M:%S")
day <- as.character(date(date))
hms <- format(as.POSIXct(date), format = '%H:%M:%S')

file.directory <- images
file.number.1 <- str_remove(str_remove(str_split(images, "/", simplify = T)[,1], ".jpg"),"FLIR")
file.number.2 <- str_remove(str_remove(str_split(images, "/", simplify = T)[,2], ".jpg"),"FLIR")

file.number <- ifelse(str_detect(file.number.1, "Distance"), file.number.2, file.number.1)

require(readxl)
df <- tibble(file.number,day,hms,file.directory)
write.csv(df,"C:/Users/roger/OneDrive/Documents/GitHub/7_Thermal/FlirPhotos.csv")

files[which(str_detect(files, ".pdf"))]

table(diff(as.numeric(file.number)))


files <- list.files(recursive = T)
4119*4

16476*
path <- "~/Library/CloudStorage/GoogleDrive-will.rogers@yale.edu/Shared drives/KNP data & logistics/buffalo data/old files_july 2023/FLIR data/FLIR photos/TB Experiment/Monthly Monitoring"

library(exif)
library(tidyverse)
images <- files[str_detect(files, ".jpg")]
timestamps <- rep(NA, length(images))