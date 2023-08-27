setwd("~/Google Drive/Shared drives/KNP data & logistics/buffalo data/old files_july 2023/FLIR data/FLIR photos/TB Experiment/Monthly Monitoring")
list.files("~/Google Drive/Shared drives/KNP data & logistics/buffalo data/old files_july 2023/FLIR data/FLIR photos/TB Experiment/Distance Experiment (Day 30)")
files <- list.files("~/Google Drive/Shared drives/KNP data & logistics/buffalo data/old files_july 2023/FLIR data/FLIR photos/TB Experiment/Distance Experiment (Day 30)/26 July 2023 flir monthly/")
files

files <- list.files("~/Google Drive/Shared drives/KNP data & logistics/buffalo data/24July2023_buffalo_boma_project/1_Project Data/4_FLIR_data/Distance experiment", recursive = T)
path <- "~/Google Drive/Shared drives/KNP data & logistics/buffalo data/24July2023_buffalo_boma_project/1_Project Data/4_FLIR_data/Distance experiment"

library(exif)
library(tidyverse)
images <- files[str_detect(files, ".jpg")]
timestamps <- rep(NA, length(images))
for (i in 1:length(images)) {
  
  timestamps[i]<- read_exif(paste(path, images[i], sep="/"))$origin_timestamp
  
  if(i %% round(length(images)/10) == 1) print(paste0(round(i/length(images)*100),"%"))
  
}

date <- as.POSIXct(timestamps, format = "%Y:%m:%d %H:%M:%S")
day <- as.character(date(date))
hms <- format(as.POSIXct(date), format = '%H:%M:%S')

file.directory <- images
file.number.1 <- str_remove(str_remove(str_split(images, "/", simplify = T)[,1], ".jpg"),"FLIR")
file.number.2 <- str_remove(str_remove(str_split(images, "/", simplify = T)[,2], ".jpg"),"FLIR")

file.number <- ifelse(str_detect(file.number.1, "Distance"), file.number.2, file.number.1)

require(readxl)
df <- tibble(file.number,day,hms,file.directory)
write.csv(df,"DistanceFlirEntry.csv")

table(day)

table(diff(as.numeric(file.number)))


files <- list.files(recursive = T)
4119*4

16476*
path <- "~/Library/CloudStorage/GoogleDrive-will.rogers@yale.edu/Shared drives/KNP data & logistics/buffalo data/old files_july 2023/FLIR data/FLIR photos/TB Experiment/Monthly Monitoring"

library(exif)
library(tidyverse)
images <- files[str_detect(files, ".jpg")]
timestamps <- rep(NA, length(images))