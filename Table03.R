# This code replicates Table 3 in the paper

rm(list=ls())
#Need to change current directory here to where ever package is saved
setwd("/Volumes/DRIVE1/BACKUP/Research/DamageNowcasts/ReplicationPackage")

library(readxl)
library(tidyverse)
library(lmtest)
library(sandwich)

senstivity <- function(DatSource,InfoSource,NUM) {
dfA <- as.data.frame(subset(read_excel("Data/ActualDamages.xlsx", sheet="ActualDamages")) )
names(dfA) = c("year","name","cost","emdat","insur")
dfA <- dfA[-c(42:46),]
dfA$cost <- dfA$cost/1000000000
dfA$emdat <- dfA$emdat/1000000000
dfA$insur <- dfA$insur/1000000000
dfA$count <- seq_len(nrow(dfA))

dfA2 <- read.csv(paste0("Data/RTmodpred.csv"))[,-c(1)]
names(dfA2) = c("rtA","qrtA1","qrtA2","qrtA3","qrtA4","qrtA5","qrtA6","qrtA7")

dfA$rtA <- dfA2$rtA/1000000000
dfA$qrtA1 <- dfA2$qrtA1/1000000000
dfA$qrtA2 <- dfA2$qrtA2/1000000000
dfA$qrtA3 <- dfA2$qrtA3/1000000000
dfA$qrtA4 <- dfA2$qrtA4/1000000000
dfA$qrtA5 <- dfA2$qrtA5/1000000000
dfA$qrtA6 <- dfA2$qrtA6/1000000000
dfA$qrtA7 <- dfA2$qrtA7/1000000000

dfe <- as.data.frame(c(0:30))
names(dfe) = c("Day")


dfe1 <- dfe
dfe3 <- dfe

list <- read.csv(paste0("Data/slist.csv"))
ns <- nrow(list)
for(n in 1:ns){ 
  
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
  df$act <- dfA[dfA$count==n,c(DatSource)]  #change here.  // cost / emdat insur
  df$qrt3 <- dfA[dfA$count==n,c(InfoSource)]

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
  
  dfe1[[paste0("s",n)]] <- df$ert
  dfe3[[paste0("s",n)]] <- df$ea1  
  
  
}
if(NUM==TRUE){
  ncol(dfe1[!sapply(dfe1, function(x) all(is.na(x)))])-1
} else{

  ddif <- as.data.frame(t(dfe3[c(6),-c(1)])-t(dfe1[c(6),-c(1)]))
  names(ddif) = c("dif")
  estim <-lm(dif~1,ddif)
  
  dfe1$av <- sqrt(rowMeans(dfe1[,-c(1)], na.rm=TRUE))
  dfe3$av <- sqrt(rowMeans(dfe3[,-c(1)], na.rm=TRUE))
  
  
  r1 <-  dfe3$av/dfe1$av
  if(coeftest(estim, vcov.=vcovHC(estim, type = "HC3"))[4]<0.01){
    paste0(round(r1[[6]],2),"**")
  } else if(coeftest(estim, vcov.=vcovHC(estim, type = "HC3"))[4]<0.05){
    paste0(round(r1[[6]],2),"*")  
    } else if(coeftest(estim, vcov.=vcovHC(estim, type = "HC3"))[4]<0.10){
      paste0(round(r1[[6]],2),"+")        
    } else {
      paste0(round(r1[[6]],2))        
    }
}
}  
  
table <- as.data.frame(c("NOAA","EMDAT Total","EMDAT Insured"))
names(table) = c("Data Source")
table$num <- NA
table$rt <- NA
table$haz_rai <- NA
table$haz_sur <- NA
table$haz_bot <- NA 
table$vul_hou <- NA
table$vul_inc <- NA
table$vul_bot <- NA
table$all <- NA
  
table[1,2] <- senstivity("cost","rtA",TRUE)
table[2,2] <- senstivity("emdat","rtA",TRUE)
table[3,2] <- senstivity("insur","rtA",TRUE)

table[1,3] <- senstivity("cost","rtA",FALSE)
table[2,3] <- senstivity("emdat","rtA",FALSE)
table[3,3] <- senstivity("insur","rtA",FALSE)

table[1,4] <- senstivity("cost","qrtA4",FALSE)
table[2,4] <- senstivity("emdat","qrtA4",FALSE)
table[3,4] <- senstivity("insur","qrtA4",FALSE)

table[1,5] <- senstivity("cost","qrtA5",FALSE)
table[2,5] <- senstivity("emdat","qrtA5",FALSE)
table[3,5] <- senstivity("insur","qrtA5",FALSE)

table[1,6] <- senstivity("cost","qrtA1",FALSE)
table[2,6] <- senstivity("emdat","qrtA1",FALSE)
table[3,6] <- senstivity("insur","qrtA1",FALSE)

table[1,7] <- senstivity("cost","qrtA7",FALSE)
table[2,7] <- senstivity("emdat","qrtA7",FALSE)
table[3,7] <- senstivity("insur","qrtA7",FALSE)

table[1,8] <- senstivity("cost","qrtA6",FALSE)
table[2,8] <- senstivity("emdat","qrtA6",FALSE)
table[3,8] <- senstivity("insur","qrtA6",FALSE)

table[1,9] <- senstivity("cost","qrtA2",FALSE)
table[2,9] <- senstivity("emdat","qrtA2",FALSE)
table[3,9] <- senstivity("insur","qrtA2",FALSE)

table[1,10] <- senstivity("cost","qrtA3",FALSE)
table[2,10] <- senstivity("emdat","qrtA3",FALSE)
table[3,10] <- senstivity("insur","qrtA3",FALSE)

table