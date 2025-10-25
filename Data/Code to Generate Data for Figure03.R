#This code generates the data necessary for Figure 3

rm(list=ls())
#Need to change current directory here to where ever package is saved
setwd("/Volumes/DRIVE1/BACKUP/Research/DamageNowcasts/ReplicationPackage")
library(readxl)
library(tidyverse)

dfA <- as.data.frame(subset(read_excel("Data/ActualDamages.xlsx", sheet="ActualDamages")) )
names(dfA) = c("year","name","cost")
dfA <- dfA[-c(42:46),]
dfA$cost <- dfA$cost/1000000000
dfA$count <- seq_len(nrow(dfA))

dfA2 <- read.csv(paste0("Data/RTmodpred.csv"))[,-c(1)]
names(dfA2) = c("rtA","qrtA1","qrtA2","qrtA3","qrtA4","qrtA5","qrtA6","qrtA7")

dfA$rtA <- dfA2$rtA/1000000000
dfA$qrt3 <- dfA2$rtA/1000000000

dfe <- as.data.frame(c(0:30))
names(dfe) = c("Day")

dfa1 <- dfe
dfa3 <- dfe

dfea <- dfe
dfep <- dfe

dfe1 <- dfe
dfe3 <- dfe

dfea1 <- dfe
dfea3 <- dfe

dfep1 <- dfe
dfep3 <- dfe

list <- read.csv(paste0("Data/slist.csv"))
ns <- nrow(list)

datcode <- function(start,end) {
for(n in start:end){ 
  df <- as.data.frame(subset(read_excel("Data/RealtimeCommercialNowcasts.xlsx", sheet=list[n,])) )
  df <- df[,-c(3,ncol(df))]
  if(nrow(df)<31){
    d <- 32 - nrow(df)
    for(i in 1:d){
      dfx <- df[nrow(df),] 
      dfx$Day <-  dfx$Day+1
      df <- rbind(df,dfx)
    }
  }
  if(nrow(df)>31){
    df <- df[-c(32:nrow(df)),]
  }
  if(ncol(df)>3){
    df$av1 <- rowMeans(df[,-c(1,2)], na.rm=TRUE)/1000000000
  } else {
    df$av1 <- df[,-c(1,2)]/1000000000
  }
  
  df$act <- dfA[dfA$count==n,]$cost  
  df$qrt3 <- dfA[dfA$count==n,]$rtA 

  df$ea1 <- (df$act-df$av1)^2
  df$ert <- (df$act-df$qrt3)^2
  df$lea1 <- abs(log(df$act*1000)-log(df$av1*1000))
  df$lert <- abs(log(df$act*1000)-log(df$qrt3*1000))

  df$aea1 <- abs(df$act-df$av1)
  df$aert <- abs(df$act-df$qrt3)

  if(nrow(subset(df, is.na(ea1)==TRUE))>0){
  
    df[is.na(df$ea1)==TRUE,]$ert <- NA
    df[is.na(df$aea1)==TRUE,]$aert <- NA
    df[is.na(df$lea1)==TRUE,]$lert <- NA    
      
  }

  dfa1[[paste0("a",n)]] <- df$rt
  dfa3[[paste0("a",n)]] <- df$act  
  
  dfe1[[paste0("s",n)]] <- df$ert
  dfe3[[paste0("s",n)]] <- df$ea1  
  
  dfea1[[paste0("s",n)]] <- df$aert
  dfea3[[paste0("s",n)]] <- df$aea1
  
  dfep1[[paste0("s",n)]] <- df$lert
  dfep3[[paste0("s",n)]] <- df$lea1
  
  
}

  dfe1$av <- sqrt(rowMeans(dfe1[,-c(1)], na.rm=TRUE))
  dfe3$av <- sqrt(rowMeans(dfe3[,-c(1)], na.rm=TRUE))  

  dfea1$av <- rowMeans(dfea1[,-c(1)], na.rm=TRUE)
  dfea3$av <- rowMeans(dfea3[,-c(1)], na.rm=TRUE)
  
  dfep1$av <- rowMeans(dfep1[,-c(1)], na.rm=TRUE)
  dfep3$av <- rowMeans(dfep3[,-c(1)], na.rm=TRUE)
  

  dfep1$r1 <-  dfe3$av/dfe1$av
  dfep1$r2 <-  dfea3$av/dfea1$av
  dfep1$r3 <-  dfep3$av/dfep1$av

  
  dfep1 <- dfep1[,c(1,ncol(dfep1)-2,ncol(dfep1)-1,ncol(dfep1))]
  dfep1 <- dfep1[c(1:10),]
  dfep1
}
  
dath1 <- datcode(1,21)
dath2 <- datcode(22,ns)

write.csv(dath1,"Data/data_h1.csv") 
write.csv(dath2,"Data/data_h2.csv") 
  