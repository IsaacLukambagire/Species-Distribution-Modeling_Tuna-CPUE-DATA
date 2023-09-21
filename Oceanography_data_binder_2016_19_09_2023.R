#################################### Year 2016 ####################################################
# daily oceanographic data bind together                                                          #
# 9 parameters  Temperature, Salinity and Currents from 0-150 (14 depth layers)                   #
# SSH, Chl a, MLD                                                                                 #  
# Data source CMEMS global data 0.25 degree resolution,daily product                              #
# Chlorophyll a and zsd from globcolour project 25 km merged satellite 8 day                      #
# 8 day chl a data stored in seperate nc file for each day                                        #
# output resolution 0.25 degree                                                                   #
# 04/11/2021                                                                                      #
#      modified 06/11/2021                                                                        #
# last modified 19/09/2023   conversion of sst                                                                     #
# (c) Sudheera Gunasekara                                                                         #
# R version 4.2.2                                    #
################################################################################################### 
rm(list=ls())

library(rhdf5)
library(tidyr)
library(dplyr)
library(RCurl)
library(R.utils)
library(RNetCDF)

# set working directory
setwd("G:/MLSDM/cmems/")

#---------------------------------------------------------------SSC--------------------------------------------------------
  sst_file <- paste("cmems_mod_glo_bgc_my_0.25_P1D-m_1695032142110.nc",sep="")
  nct <- open.nc(sst_file, Write=False)
  print.nc(nct)
  lat <- var.get.nc(nct,"latitude")
  lon<- var.get.nc(nct,"longitude")
  latlon <- list(lat=lat,lon=lon)
  latlongrid <- expand.grid(latlon)
  oxy<-var.get.nc(nct,"o2")
  chl<-var.get.nc(nct,"chl")
  #dim(oxy)
  t <-var.get.nc(nct,"time")
  tim <- as.POSIXlt(t*3600,origin="1950-01-01 00:00:00")
  tims <- substring(tim, 1,10)
  tail(tim)
  length(t)
  depth <- var.get.nc(nct,"depth")
  close.nc(nct)
  
  for (i in 1:length(tims)) {
  # sst has 14 depths and 365 days
  # select day i
    #i=1
  latlongrid <- expand.grid(latlon)
  o2 <-oxy[,,i]
  latlongrid$oxy <- c(t(unlist(o2)))
  chla <-chl[,,i]
  latlongrid$chl <- c(t(unlist(chla)))
  
   # save file
  #s.date <- ded <-as.Date(i-1, origin = "2016-01-01")
  save.file <- paste("G:/MLSDM/cmems/chl/",tims[i], ".csv", sep="" )
  write.csv(latlongrid, file=save.file,row.names = F)
  print(tims[i])
  
  } 
  

 rm(lat, lon, latlon,latlongrid, chl, chla,oxy,o2,t,nct,depth) 
  #-----------------Euphotic depth-------------------------------------------------------
  ssh_file <- paste("cmems_mod_glo_bgc_my_0.083deg-lmtl_PT1D-i_1695033616709.nc",sep="")
  nch <- open.nc(ssh_file, Write=False)
  print.nc(nch)
  lat <- var.get.nc(nch,"latitude")
  lon<- var.get.nc(nch,"longitude")
  # round lat and lon to bring values to common grid with other data in 0.25 degree resolution
  lon = round(lon,2)
  lat = round(lat,2)
  
  latlon <- list(lat=lat,lon=lon)
  latlongrid <- expand.grid(latlon)
  zeua<-var.get.nc(nch,"zeu")
  zeua <- (zeua*0.00169017113209159)+65.1601775904383
  #"seconds since 1970-01-01 00:00:00"
  t <-var.get.nc(nch,"time")
  tim <- as.POSIXlt(t,origin="1970-01-01 00:00:00")
  tail(tim)
  tims <- substring(tim, 1,10)
  tail(tim)
  length(t)
  close.nc(nch)
  
  for (i in 1:length(tims)) {
  zeu <-zeua[,,i]
  latlongrid <- expand.grid(latlon)
  latlongrid$zeu <- c(t(unlist(zeu)))
    # save file
  # save file
  #s.date <- ded <-as.Date(i-1, origin = "2016-01-01")
  save.file <- paste("G:/MLSDM/cmems/ed/",tims[i], ".csv", sep="" )
  write.csv(latlongrid, file=save.file,row.names = F)
  print(tims[i])
  
  } 
  
  
  ###### merge Chlorophyll, Oxygen level and Euphotic depth together
  chlpath <- "G:/MLSDM/cmems/chl/2016/"
  chl.files <- list.files(chlpath, full.names = T)
  length(chl.files)
  
  edpath <- "G:/MLSDM/cmems/ed/2016/"
  ed.files <- list.files(edpath, full.names = T)
  length(ed.files)
  
  for (i in 1:366) {
    
    ed <- read.csv(ed.files[i])
    #head(ed)
    chl <- read.csv(chl.files[i])
    #head(chl)
    
    GC <- merge(ed,chl, by=c("lat","lon"))
    #dim(GC)
    #head(GC)
    save.file <- paste("G:/MLSDM/cmems/ocg/",substring(ed.files[i],24,33), ".csv", sep="" )
    write.csv(GC, file=save.file,row.names = F)
    print(substring(ed.files[i],24,33))
    #View(GC)
    rm(ed,chl,GC)
    
    
  }
  
  ### 2017 2018 2019
  
  chlpath <- "G:/MLSDM/cmems/chl/2019/"
  chl.files <- list.files(chlpath, full.names = T)
  length(chl.files)
  
  edpath <- "G:/MLSDM/cmems/ed/2019/"
  ed.files <- list.files(edpath, full.names = T)
  length(ed.files)
  
  for (i in 1:365) {
    
    ed <- read.csv(ed.files[i])
    #head(ed)
    chl <- read.csv(chl.files[i])
    #head(chl)
    
    GC <- merge(ed,chl, by=c("lat","lon"))
    #dim(GC)
    #head(GC)
    save.file <- paste("G:/MLSDM/cmems/ocg/2019/",substring(ed.files[i],24,33), ".csv", sep="" )
    write.csv(GC, file=save.file,row.names = F)
    print(substring(ed.files[i],24,33))
    #View(GC)
    rm(ed,chl,GC)
    }

  
  ocg.files <- list.files("G:/MLSDM/cmems/ocg/2016/")
  #length(ocg.files)
  
  
  