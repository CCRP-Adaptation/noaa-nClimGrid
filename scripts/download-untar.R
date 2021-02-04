# nClimGrid batch download
# ftp://ftp.ncdc.noaa.gov/pub/data/climgrid/

library(sf)
library(raster)
library(dplyr)
library(rgdal)
library(plyr)
library(HelpersMG)

rm(list=ls())

# Initials
data.url <- "ftp://ftp.ncdc.noaa.gov/pub/data/climgrid/"
files.list <- read.csv("./nClimGrid-files.csv",header=F)
tar.dir <- "D:/temp/" #location to save tar.gz files
data.dir <- "D:/nClimGrid/" #location for text files

# downloading files to tar.dir
url<-paste(data.url,files.list[1,],sep="")
setwd(tar.dir)
wget(as.character(url, mode="wb"))

# Extract tarballs
file_list<- list.files(path=tar.dir , pattern = "*.tar.gz", full.names = TRUE)
ldply(.data = file_list, .fun = untar, exdir = data.dir) #untar tarballs and save to data.dir



# create stack for each var by pattern - "prcp.alaska" [AK not for whole period]
pnt.list<-list.files(path=data.dir, pattern=".prcp.alaska") #list all files by var


# extract single year
data <- read.table(paste(data.dir,pnt.list,sep="/"))
colnames(data)=c("Lat","Lon","PrecipC")