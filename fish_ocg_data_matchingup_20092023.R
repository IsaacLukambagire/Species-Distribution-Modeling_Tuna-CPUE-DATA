rm(list=ls())

library(tidyr)
library(dplyr)
library(RCurl)
library(R.utils)

#### read logbook csv file with lat, lon and parameter
#data<- read.csv("logbook2016/2016_fish_data_0.25.csv", header=TRUE, stringsAsFactors=FALSE)
# fisheries and exsisting oceanography data
data<- read.csv("G:/MLSDM/Data/YFT/2016_2019_fish_as_bob.csv", header=TRUE, stringsAsFactors=FALSE)
names(data)
str(data)
#gear <-data$Catch_Type


data$fdate <- as.Date(data$fdate)
head(data$fdate)
data$year <- substring(data$fdate,1,4)

dlist <- format(seq(as.Date("2019-01-01"), as.Date("2019-12-31"), by="days"), format="%Y-%m-%d")
#i=1

for (i in 1:365){
fday = dlist[i]
# select catch data from day i
D <- data[data$fdate==fday,]
head(D)

# read oceanography data

o.path <- "G:/MLSDM/cmems/ocg/2019/"
#o.list <- list.files(o.path,pattern = ".csv")

o.file <- paste(o.path,fday,".csv", sep="")
odata <-read.csv(o.file,  header=TRUE, stringsAsFactors=FALSE)
names(odata)

# merge fishery data and oceanography data based on date and the location

mdata <- D %>% inner_join(odata, by=c("lat","lon"))
dim(mdata)
#View(mdata)

# save file

save.file <- paste("G:/MLSDM/outputs/mdata/",fday, ".csv", sep="" )
write.csv(mdata, file=save.file,row.names = F)
print(fday)

} # end

#####------------------------------- bind daily files to a year file -----------------

f.path <- "G:/MLSDM/outputs/mdata/"
all.files <- list.files(path=f.path,full.names=T,pattern="csv")

new.data <- NULL
for(i in all.files){
  #i=all.files[1]
  in.data <- read.csv(i)
  if (is.null(new.data)) {
    new.data =in.data
  } 
  else {new.data = rbind(new.data, in.data)
  
  }
  
  cat(paste(i, ", ", sep=""))
} 

head(new.data)
dim(new.data)
#View(new.data)

save.file <- paste("G:/MLSDM/outputs/mdata/", "2016_2019_fish_ocg_data_updated.csv", sep="" )
write.csv(new.data, file=save.file,row.names = F)
