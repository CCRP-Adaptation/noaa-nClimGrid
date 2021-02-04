# nClimGrid batch download
# ftp://ftp.ncdc.noaa.gov/pub/data/climgrid/

library()

# Initials
tar.dir <- "C:/Users/achildress/Documents/NOAA-data/" #location of tar.gz files
data.dir <- paste(tar.dir,"data",sep="/") #location for text files

# ### section to be filled in later downloading files to tar.dir

file_list<- list.files(path=tar.dir , pattern = "*.tar.gz", full.names = TRUE)
ldply(.data = file_list, .fun = untar, exdir = data.dir) #untar tarballs and save to data.dir



# create stack for each var by pattern - "prcp.alaska" [AK not for whole period]
pnt.list<-list.files(path=data.dir, pattern=".prcp.alaska") #list all files by var


# extract single year
data <- read.table(paste(data.dir,pnt.list,sep="/"))
colnames(data)=c("Lat","Lon","PrecipC")