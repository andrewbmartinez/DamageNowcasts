# This code replicates Table 1 in the paper

rm(list=ls())
#Need to change current directory here to where ever package is saved
setwd("/Volumes/DRIVE1/BACKUP/Research/DamageNowcasts/ReplicationPackage")
library(tidyverse)

# Loading the cleaned real time vintages dataset from Billion Dollar disasters - This has been discontinued 
data <- read_csv(paste0("Data/NOAA_BDD_Realtime_Vintages_Damages.csv")) 
data_final <- data[,c(1,24,25)]
data_final$price <- data_final$Latest/data_final$LatestR

data <- data[,-c(3:4,24,25)]
data$x <- NA

count <- NA

for(n in 1:nrow(data)){
  count <- 0
  for(j in 3:ncol(data)){
    if( is.na(data[[n,j]])==FALSE & count!=1 ){
      data[n,]$x <- data[[n,j]]  
      count <- 1
    }
  }
}

data <- data[-c(1:284),c(1:2,22)]
data_final <- data_final[-c(1:284),]
data$latestR <- data_final$LatestR
data$p <- data_final$price
data$x <- data$x/data$p
data$r <- data$latestR - data$x


table <- as.data.frame(c("RMSD","SD"))
names(table) = c("metrics")
table$ad_bil <- NA
table$ad_nsr <- NA
table$tc_bil <- NA
table$tc_nsr <- NA 
table$od_bil <- NA
table$od_nsr <- NA

test <- data
data <- test

table[1,3] <- round(sqrt(mean(data$r)^2+var(data$r))/sqrt(mean(data$latestR)^2+var(data$latestR))*100,1)
table[2,3] <- round(sqrt(var(data$r))/sqrt(var(data$latestR))*100,1)

table[1,2] <- round(sqrt(mean(data$r)^2+var(data$r))/1000,2)
table[2,2] <- round(sqrt(var(data$r))/1000,2)

data <- test
data <- subset(test, Disaster=="Tropical Cyclone")

table[1,5] <- round(sqrt(mean(data$r)^2+var(data$r))/sqrt(mean(data$latestR)^2+var(data$latestR))*100,1)
table[2,5] <- round(sqrt(var(data$r))/sqrt(var(data$latestR))*100,1)

table[1,4] <- round(sqrt(mean(data$r)^2+var(data$r))/1000,2)
table[2,4] <- round(sqrt(var(data$r))/1000,2)

data <- test
data <- subset(test, Disaster!="Tropical Cyclone")

table[1,7] <- round(sqrt(mean(data$r)^2+var(data$r))/sqrt(mean(data$latestR)^2+var(data$latestR))*100,1)
table[2,7] <- round(sqrt(var(data$r))/sqrt(var(data$latestR))*100,1)


table[1,6] <- round(sqrt(mean(data$r)^2+var(data$r))/1000,2)
table[2,6] <- round(sqrt(var(data$r))/1000,2)

table

