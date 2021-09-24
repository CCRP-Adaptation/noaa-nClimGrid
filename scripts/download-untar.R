##############################################################################
###   nClimGrid batch download  ##############################################
##############################################################################

# Downloads NOAA ClimGrid files from FTP and stores on external hard drive
# https://www.ncei.noaa.gov/pub/data/climgrid/

# Each user will store these files locally for faster retrieval than downloading each time

library(HelpersMG)
library(plyr)

rm(list=ls())

# Initials
data.url <- "https://www.ncei.noaa.gov/pub/data/climgrid/" #site location of tar.gz
files.list <- read.csv("./nClimGrid-files_0121-0821.csv",header=F) #csv w/ files to download
# if updating, copy newest files from data.url and paste in new csv, then add to complete list


tar.dir <- "D:/temp/" #location to save tar.gz files
data.dir <- "D:/nClimGrid/" #location for text files

# # downloading files to tar.dir -- commented out because already run

url.list<-paste(data.url,files.list[1:nrow(files.list),],sep="")
setwd(tar.dir)
wget(as.character(url.list, mode="wb"))

 # Extract tarballs
file_list<- list.files(path=tar.dir , pattern = "*.tar.gz", full.names = TRUE)
ldply(.data = file_list, .fun = untar, exdir = data.dir) #untar tarballs and save to data.dir

do.call(file.remove, list(list.files(tar.dir, full.names = TRUE)))
