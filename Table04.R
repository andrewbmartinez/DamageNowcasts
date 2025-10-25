#This code generates the results for Table 4 in the paper

rm(list=ls())
#Need to change current directory here to where ever package is saved
setwd("/Volumes/DRIVE1/BACKUP/Research/DamageNowcasts/ReplicationPackage")
library(readxl)

library(tidyverse)
library(lmtest)
library(sandwich)

dfA <- as.data.frame(subset(read_excel("Data/ActualDamages.xlsx", sheet="ActualDamages")) )
names(dfA) = c("year","name","cost")
dfA <- dfA[-c(42:46),c(1:3)]
dfA$cost <- dfA$cost/1000000000
dfA$count <- seq_len(nrow(dfA))

dfA2 <- read.csv(paste0("Data/RTmodpred.csv"))[,-c(1)]
names(dfA2) = c("rtA","qrtA1","qrtA2","qrtA3","qrtA4","qrtA5","qrtA6","qrtA7")

dfA$rtA <- dfA2$rtA/1000000000

dfe <- as.data.frame(c(0:30))
names(dfe) = c("Day")
dfea <- dfe
dfep <- dfe

dfe1 <- dfe
dfe2 <- dfe
dfe3 <- dfe
dfe4 <- dfe
dfe5 <- dfe

dfe6 <- dfe
dfe7 <- dfe
dfe8 <- dfe
dfe9 <- dfe
dfe10 <- dfe
dfe13 <- dfe
dfe14 <- dfe

dfea1 <- dfe
dfea2 <- dfe
dfea3 <- dfe
dfea4 <- dfe
dfea5 <- dfe

dfea6 <- dfe
dfea7 <- dfe
dfea8 <- dfe
dfea9 <- dfe
dfea10 <- dfe
dfea13 <- dfe
dfea14 <- dfe

dfep1 <- dfe
dfep2 <- dfe
dfep3 <- dfe
dfep4 <- dfe
dfep5 <- dfe

dfep6 <- dfe
dfep7 <- dfe
dfep8 <- dfe
dfep9 <- dfe
dfep10 <- dfe
dfep13 <- dfe
dfep14 <- dfe

list <- read.csv(paste0("Data/slist.csv"))
ns <- nrow(list)

tablefunc <- function(sstart,send) {

for(n in sstart:send){ 
  #n <- 22
  df <- as.data.frame(subset(read_excel("Data/RealtimeCommercialNowcasts.xlsx", sheet=list[n,])) )
  df <- df[,-c(3,ncol(df))]
  if(nrow(df)<31){
    d <- 31 - nrow(df)
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
  df$rt <- dfA[dfA$count==n,]$rt

  if((!"CoreLogic"%in%names(df))==FALSE){
    names(df)[names(df) == 'CoreLogic'] <- 'EQECAT'
  }  
  if((!"KCC"%in%names(df))==TRUE){
    df$KCC <- NA
  }
  if((!"Accuweather"%in%names(df))==TRUE){
    df$ACU <- NA
  }
  if((!"Verisk"%in%names(df))==FALSE){
    names(df)[names(df) == 'Verisk'] <- 'AIR'
  }    
  if((!"AIR"%in%names(df))==TRUE){
    df$AIR <- NA
  }  
  if((!"RMS"%in%names(df))==TRUE){
    df$RMS <- NA
  } 
  if((!"EQECAT"%in%names(df))==TRUE){
    df$EQECAT <- NA
  } 
  if((!"Kinetic"%in%names(df))==FALSE){
    names(df)[names(df) == 'Kinetic'] <- 'ENKI'
  } 
  if((!"ENKI"%in%names(df))==TRUE){
    df$ENKI <- NA
  }  

  df$KCC <- df$KCC/1000000000
  df$AIR <- df$AIR/1000000000
  df$RMS <- df$RMS/1000000000
  df$EQECAT <- df$EQECAT/1000000000
  df$ENKI <- df$ENKI/1000000000
  
  df$rt <- dfA[dfA$count==n,]$rt
  df$act <- dfA[dfA$count==n,]$cost

  df$ea1 <- (df$act-df$av1)^2
  df$erm <- (df$act-df$RMS)^2
  df$ekc <- (df$act-df$KCC)^2
  df$ert <- (df$act-df$rt)^2
  df$eai <- (df$act-df$AIR)^2
  df$eeq <- (df$act-df$EQECAT)^2
  df$een <- (df$act-df$ENKI)^2
  
  df$ert2 <- (df$act-df$rt)^2
  df$ert3 <- (df$act-df$rt)^2
  df$ert4 <- (df$act-df$rt)^2
  df$ert5 <- (df$act-df$rt)^2
  df$ert7 <- (df$act-df$rt)^2   
  
#in millions to prevent issues with logs
  df$lea1 <- abs(log(df$act*1000)-log(df$av1*1000))
  df$lerm <- abs(log(df$act*1000)-log(df$RMS*1000))
  df$lekc <- abs(log(df$act*1000)-log(df$KCC*1000))
  df$lert <- abs(log(df$act*1000)-log(df$rt*1000))
  df$leai <- abs(log(df$act*1000)-log(df$AIR*1000))
  df$leeq <- abs(log(df$act*1000)-log(df$EQECAT*1000))
  df$leen <- abs(log(df$act*1000)-log(df$ENKI*1000))

  df$lert2 <- abs(log(df$act*1000)-log(df$rt*1000))
  df$lert3 <- abs(log(df$act*1000)-log(df$rt*1000))
  df$lert4 <- abs(log(df$act*1000)-log(df$rt*1000))
  df$lert5 <- abs(log(df$act*1000)-log(df$rt*1000))  
  df$lert7 <- abs(log(df$act*1000)-log(df$rt*1000))    
  
  df$aea1 <- abs(df$act-df$av1)
  df$aerm <- abs(df$act-df$RMS)
  df$aekc <- abs(df$act-df$KCC)
  df$aert <- abs(df$act-df$rt)
  df$aeai <- abs(df$act-df$AIR)
  df$aeeq <- abs(df$act-df$EQECAT)
  df$aeen <- abs(df$act-df$ENKI)  
  
  df$aert2 <- df$aert
  df$aert3 <- df$aert
  df$aert4 <- df$aert
  df$aert5 <- df$aert  
  df$aert7 <- df$aert  

# use this to drop missing to align samples
  if(nrow(subset(df, is.na(erm)==TRUE))>0){
    df[is.na(df$erm)==TRUE,]$ert <- NA
    df[is.na(df$aerm)==TRUE,]$aert <- NA
    df[is.na(df$lerm)==TRUE,]$lert <- NA    
  }
  if(nrow(subset(df, is.na(ekc)==TRUE))>0){
    df[is.na(df$ekc)==TRUE,]$ert2 <- NA
    df[is.na(df$aekc)==TRUE,]$aert2 <- NA
    df[is.na(df$lekc)==TRUE,]$lert2 <- NA    
  }  
  if(nrow(subset(df, is.na(eai)==TRUE))>0){
    df[is.na(df$eai)==TRUE,]$ert3 <- NA
    df[is.na(df$aeai)==TRUE,]$aert3 <- NA
    df[is.na(df$leai)==TRUE,]$lert3 <- NA    
  }  
  
  if(nrow(subset(df, is.na(eeq)==TRUE))>0){
    df[is.na(df$eeq)==TRUE,]$ert4 <- NA
    df[is.na(df$aeeq)==TRUE,]$aert4 <- NA
    df[is.na(df$leeq)==TRUE,]$lert4 <- NA    
  } 
  if(nrow(subset(df, is.na(een)==TRUE))>0){
    df[is.na(df$een)==TRUE,]$ert5 <- NA
    df[is.na(df$aeen)==TRUE,]$aert5 <- NA
    df[is.na(df$leen)==TRUE,]$lert5 <- NA    
  }   
  
  if(nrow(subset(df, is.na(ea1)==TRUE))>0){
    df[is.na(df$ea1)==TRUE,]$ert7 <- NA
    df[is.na(df$aea1)==TRUE,]$aert7 <- NA
    df[is.na(df$lea1)==TRUE,]$lert7 <- NA    
  } 
  dfe1[[paste0("s",n)]] <- df$ert
  dfe2[[paste0("s",n)]] <- df$erm
  dfe3[[paste0("s",n)]] <- df$ekc
  dfe4[[paste0("s",n)]] <- df$eai
  dfe5[[paste0("s",n)]] <- df$eeq
  dfe9[[paste0("s",n)]] <- df$een
  dfe13[[paste0("s",n)]] <- df$ea1  
  
  dfe6[[paste0("s",n)]] <- df$ert2
  dfe7[[paste0("s",n)]] <- df$ert3
  dfe8[[paste0("s",n)]] <- df$ert4
  dfe10[[paste0("s",n)]] <- df$ert5  
  dfe14[[paste0("s",n)]] <- df$ert7 
  
  dfea1[[paste0("s",n)]] <- df$aert
  dfea2[[paste0("s",n)]] <- df$aerm
  dfea3[[paste0("s",n)]] <- df$aekc
  dfea4[[paste0("s",n)]] <- df$aeai
  dfea5[[paste0("s",n)]] <- df$aeeq
  dfea9[[paste0("s",n)]] <- df$aeen
  dfea13[[paste0("s",n)]] <- df$aea1   
  
  dfea6[[paste0("s",n)]] <- df$aert2
  dfea7[[paste0("s",n)]] <- df$aert3
  dfea8[[paste0("s",n)]] <- df$aert4
  dfea10[[paste0("s",n)]] <- df$aert5  
  dfea14[[paste0("s",n)]] <- df$aert7    
  
  dfep1[[paste0("s",n)]] <- df$lert
  dfep2[[paste0("s",n)]] <- df$lerm
  dfep3[[paste0("s",n)]] <- df$lekc
  dfep4[[paste0("s",n)]] <- df$leai
  dfep5[[paste0("s",n)]] <- df$leeq
  dfep9[[paste0("s",n)]] <- df$leen
  dfep13[[paste0("s",n)]] <- df$lea1  
  
  dfep6[[paste0("s",n)]] <- df$lert2
  dfep7[[paste0("s",n)]] <- df$lert3
  dfep8[[paste0("s",n)]] <- df$lert4
  dfep10[[paste0("s",n)]] <- df$lert5
  dfep14[[paste0("s",n)]] <- df$lert7

}
  
  ed2 <-round(aggregate(row~1, aggregate(row ~ col, as.data.frame(which(!is.na(dfe2[,-c(1)]), arr.ind = TRUE)), min) ,mean),2)
  ed3 <-round(aggregate(row~1, aggregate(row ~ col, as.data.frame(which(!is.na(dfe3[,-c(1)]), arr.ind = TRUE)), min) ,mean),2)
  ed4 <-round(aggregate(row~1, aggregate(row ~ col, as.data.frame(which(!is.na(dfe4[,-c(1)]), arr.ind = TRUE)), min) ,mean),2)
  ed5 <-round(aggregate(row~1, aggregate(row ~ col, as.data.frame(which(!is.na(dfe5[,-c(1)]), arr.ind = TRUE)), min) ,mean),2)
  ed9 <-round(aggregate(row~1, aggregate(row ~ col, as.data.frame(which(!is.na(dfe9[,-c(1)]), arr.ind = TRUE)), min) ,mean),2)
  ed13 <-round(aggregate(row~1, aggregate(row ~ col, as.data.frame(which(!is.na(dfe13[,-c(1)]), arr.ind = TRUE)), min) ,mean),2)


  dfe1 <- na.locf(dfe1,fromLast=TRUE, na.rm=FALSE)
  dfe2 <- na.locf(dfe2,fromLast=TRUE, na.rm=FALSE)
  dfe3 <- na.locf(dfe3,fromLast=TRUE, na.rm=FALSE)
  dfe4 <- na.locf(dfe4,fromLast=TRUE, na.rm=FALSE)
  dfe5 <- na.locf(dfe5,fromLast=TRUE, na.rm=FALSE)
  dfe6 <- na.locf(dfe6,fromLast=TRUE, na.rm=FALSE)
  dfe7 <- na.locf(dfe7,fromLast=TRUE, na.rm=FALSE)
  dfe8 <- na.locf(dfe8,fromLast=TRUE, na.rm=FALSE)
  dfe9 <- na.locf(dfe9,fromLast=TRUE, na.rm=FALSE)
  dfe10 <- na.locf(dfe10,fromLast=TRUE, na.rm=FALSE)


  dfea1 <- na.locf(dfea1,fromLast=TRUE, na.rm=FALSE)
  dfea2 <- na.locf(dfea2,fromLast=TRUE, na.rm=FALSE)
  dfea3 <- na.locf(dfea3,fromLast=TRUE, na.rm=FALSE)
  dfea4 <- na.locf(dfea4,fromLast=TRUE, na.rm=FALSE)
  dfea5 <- na.locf(dfea5,fromLast=TRUE, na.rm=FALSE)
  dfea6 <- na.locf(dfea6,fromLast=TRUE, na.rm=FALSE)
  dfea7 <- na.locf(dfea7,fromLast=TRUE, na.rm=FALSE)
  dfea8 <- na.locf(dfea8,fromLast=TRUE, na.rm=FALSE)
  dfea9 <- na.locf(dfea9,fromLast=TRUE, na.rm=FALSE)
  dfea10 <- na.locf(dfea10,fromLast=TRUE, na.rm=FALSE)

  
  dfep1 <- na.locf(dfep1,fromLast=TRUE, na.rm=FALSE)
  dfep2 <- na.locf(dfep2,fromLast=TRUE, na.rm=FALSE)
  dfep3 <- na.locf(dfep3,fromLast=TRUE, na.rm=FALSE)
  dfep4 <- na.locf(dfep4,fromLast=TRUE, na.rm=FALSE)
  dfep5 <- na.locf(dfep5,fromLast=TRUE, na.rm=FALSE)
  dfep6 <- na.locf(dfep6,fromLast=TRUE, na.rm=FALSE)
  dfep7 <- na.locf(dfep7,fromLast=TRUE, na.rm=FALSE)
  dfep8 <- na.locf(dfep8,fromLast=TRUE, na.rm=FALSE)
  dfep9 <- na.locf(dfep9,fromLast=TRUE, na.rm=FALSE)
  dfep10 <- na.locf(dfep10,fromLast=TRUE, na.rm=FALSE)

  dfe <- cbind(t(dfe13[6,])-t(dfe14[6,]))
  dfe <- cbind(dfe,t(dfe1[1,])-t(dfe2[1,]))
  dfe <- cbind(dfe,t(dfe4[1,])-t(dfe7[1,]))
  dfe <- cbind(dfe,t(dfe5[1,])-t(dfe8[1,]))
  dfe <- cbind(dfe,t(dfe3[1,])-t(dfe6[1,]))
  dfe <- as.data.frame(cbind(dfe,t(dfe9[1,])-t(dfe10[1,])))

  
  
  pvals = c(NA,NA,NA,NA,NA,NA)
  pvals = rbind(pvals,pvals)
  pvals = rbind(pvals,c(NA,NA,NA,NA,NA,NA))
  for(mod in 1:6){ 
    ddif <- as.data.frame(subset(dfe[,mod],is.na(dfe[,mod])==FALSE))
    names(ddif) = c("dif")
    estim <-lm(dif~1,ddif)
    pvals[1,mod] <- coeftest(estim, vcov.=vcovHC(estim, type = "HC3"))[,4]
  }
  

  dfea <- cbind(t(dfea13[6,])-t(dfea14[6,]))
  dfea <- cbind(dfea,t(dfea1[1,])-t(dfea2[1,]))
  dfea <- cbind(dfea,t(dfea4[1,])-t(dfea7[1,]))
  dfea <- cbind(dfea,t(dfea5[1,])-t(dfea8[1,]))
  dfea <- cbind(dfea,t(dfea3[1,])-t(dfea6[1,]))
  dfea <- as.data.frame(cbind(dfea,t(dfea9[1,])-t(dfea10[1,])))


  for(mod in 1:6){ 
    ddif <- as.data.frame(subset(dfea[,mod],is.na(dfea[,mod])==FALSE))
    names(ddif) = c("dif")
    estim <-lm(dif~1,ddif)
    pvals[2,mod] <- coeftest(estim, vcov.=vcovHC(estim, type = "HC3"))[,4]
  }  
  
  dfep <- cbind(t(dfep13[6,])-t(dfep14[6,]))
  dfep <- cbind(dfep,t(dfep1[1,])-t(dfep2[1,]))
  dfep <- cbind(dfep,t(dfep4[1,])-t(dfep7[1,]))
  dfep <- cbind(dfep,t(dfep5[1,])-t(dfep8[1,]))
  dfep <- cbind(dfep,t(dfep3[1,])-t(dfep6[1,]))
  dfep <- as.data.frame(cbind(dfep,t(dfep9[1,])-t(dfep10[1,])))
  

  for(mod in 1:6){ 
    ddif <- as.data.frame(subset(dfep[,mod],is.na(dfep[,mod])==FALSE))
    names(ddif) = c("dif")
    estim <-lm(dif~1,ddif)
    pvals[3,mod] <- coeftest(estim, vcov.=vcovHC(estim, type = "HC3"))[,4]
  }    

  dfe1$av <- sqrt(rowMeans(dfe1[,-c(1)], na.rm=TRUE))
  dfe1$n <- sum(dfe1[1,-c(1)]/dfe1[1,-c(1)],na.rm=TRUE)
  dfe2$av <- sqrt(rowMeans(dfe2[,-c(1)], na.rm=TRUE))
  dfe2$n <- sum(dfe2[1,-c(1)]/dfe2[1,-c(1)],na.rm=TRUE)
  dfe3$av <- sqrt(rowMeans(dfe3[,-c(1)], na.rm=TRUE))
  dfe3$n <- sum(dfe3[1,-c(1)]/dfe3[1,-c(1)],na.rm=TRUE)
  dfe4$av <- sqrt(rowMeans(dfe4[,-c(1)], na.rm=TRUE))
  dfe4$n <- sum(dfe4[1,-c(1)]/dfe4[1,-c(1)],na.rm=TRUE)
  dfe5$av <- sqrt(rowMeans(dfe5[,-c(1)], na.rm=TRUE))
  dfe5$n <- sum(dfe5[1,-c(1)]/dfe5[1,-c(1)],na.rm=TRUE)
  dfe6$av <- sqrt(rowMeans(dfe6[,-c(1)], na.rm=TRUE))
  dfe7$av <- sqrt(rowMeans(dfe7[,-c(1)], na.rm=TRUE))
  dfe8$av <- sqrt(rowMeans(dfe8[,-c(1)], na.rm=TRUE))
  dfe9$av <- sqrt(rowMeans(dfe9[,-c(1)], na.rm=TRUE))
  dfe9$n <- sum(dfe9[1,-c(1)]/dfe9[1,-c(1)],na.rm=TRUE)
  dfe10$av <- sqrt(rowMeans(dfe10[1,-c(1)], na.rm=TRUE))
  dfe13$av <- sqrt(rowMeans(dfe13[6,-c(1)], na.rm=TRUE))
  dfe13$n <- sum(dfe13[6,-c(1)]/dfe13[6,-c(1)],na.rm=TRUE)
  dfe14$av <- sqrt(rowMeans(dfe14[6,-c(1)], na.rm=TRUE))

  
  dfea1$av <- rowMeans(dfea1[,-c(1)], na.rm=TRUE)
  dfea2$av <- rowMeans(dfea2[,-c(1)], na.rm=TRUE)
  dfea3$av <- rowMeans(dfea3[,-c(1)], na.rm=TRUE)  
  dfea4$av <- rowMeans(dfea4[,-c(1)], na.rm=TRUE)  
  dfea5$av <- rowMeans(dfea5[,-c(1)], na.rm=TRUE)  
  dfea6$av <- rowMeans(dfea6[,-c(1)], na.rm=TRUE) 
  dfea7$av <- rowMeans(dfea7[,-c(1)], na.rm=TRUE) 
  dfea8$av <- rowMeans(dfea8[,-c(1)], na.rm=TRUE)
  dfea9$av <- rowMeans(dfea9[,-c(1)], na.rm=TRUE)
  dfea10$av <- rowMeans(dfea10[,-c(1)], na.rm=TRUE)
  dfea13$av <- rowMeans(dfea13[6,-c(1)], na.rm=TRUE)
  dfea14$av <- rowMeans(dfea14[6,-c(1)], na.rm=TRUE)

  dfep1$av <- rowMeans(dfep1[,-c(1)], na.rm=TRUE)
  dfep2$av <- rowMeans(dfep2[,-c(1)], na.rm=TRUE)
  dfep3$av <- rowMeans(dfep3[,-c(1)], na.rm=TRUE)  
  dfep4$av <- rowMeans(dfep4[,-c(1)], na.rm=TRUE)  
  dfep5$av <- rowMeans(dfep5[,-c(1)], na.rm=TRUE)  
  dfep6$av <- rowMeans(dfep6[,-c(1)], na.rm=TRUE)  
  dfep7$av <- rowMeans(dfep7[,-c(1)], na.rm=TRUE)  
  dfep8$av <- rowMeans(dfep8[,-c(1)], na.rm=TRUE) 
  dfep9$av <- rowMeans(dfep9[,-c(1)], na.rm=TRUE) 
  dfep10$av <- rowMeans(dfep10[,-c(1)], na.rm=TRUE) 
  dfep13$av <- rowMeans(dfep13[6,-c(1)], na.rm=TRUE)
  dfep14$av <- rowMeans(dfep14[6,-c(1)], na.rm=TRUE)

  
  dfep1 <- dfep1[,c(1,ncol(dfep1))]
  
  dfep1$r1rms <-  dfe2$av/dfe1$av
  dfep1$r2rms <-  dfea2$av/dfea1$av
  dfep1$r3rms <-  dfep2$av/dfep1$av
  
  dfep1$r1kcc <-  dfe3$av/dfe6$av
  dfep1$r2kcc <-  dfea3$av/dfea6$av
  dfep1$r3kcc <-  dfep3$av/dfep6$av
  
  dfep1$r1air <-  dfe4$av/dfe7$av
  dfep1$r2air <-  dfea4$av/dfea7$av
  dfep1$r3air <-  dfep4$av/dfep7$av
  
  dfep1$r1eqe <-  dfe5$av/dfe8$av
  dfep1$r2eqe <-  dfea5$av/dfea8$av
  dfep1$r3eqe <-  dfep5$av/dfep8$av
  
  dfep1$r1enk <-  dfe9$av/dfe10$av
  dfep1$r2enk <-  dfea9$av/dfea10$av
  dfep1$r3enk <-  dfep9$av/dfep10$av
  
  dfep1$r1av1 <-  dfe13$av/dfe14$av
  dfep1$r2av1 <-  dfea13$av/dfea14$av
  dfep1$r3av1 <-  dfep13$av/dfep14$av
  

  dfep1 <- dfep1[c(1),-c(2)]
  dfep1$nrms <- dfe2[1,]$n
  dfep1$nkcc <- dfe3[1,]$n
  dfep1$nair <- dfe4[1,]$n
  dfep1$neqe <- dfe5[1,]$n
  dfep1$nenk <- dfe9[1,]$n
  dfep1$nav1 <- dfe13[1,]$n
  
  dfep1$drms <- ed2
  dfep1$dkcc <- ed3
  dfep1$dair <- ed4
  dfep1$deqe <- ed5
  dfep1$denk <- ed9
  dfep1$dav1 <- ed13
  
  
pvals  
table <- as.data.frame(c("Average","Moodys","Verisk","CoreLogic","KCC","Enki"))
names(table) = c("model")

table$num <- NA
table$rmse <- NA
table$mae <- NA
table$mape <- NA

table[1,c(2:5)] <- t(c((dfep1[,25]-1),round(dfep1[,c(17:19)],2)))
table[2,c(2:5)] <- t(c((dfep1[,20]-1),round(dfep1[,c(2:4)],2)))
table[5,c(2:5)] <- t(c((dfep1[,21]-1),round(dfep1[,c(5:7)],2)))
table[3,c(2:5)] <- t(c((dfep1[,22]-1),round(dfep1[,c(8:10)],2)))
table[4,c(2:5)] <- t(c((dfep1[,23]-1),round(dfep1[,c(11:13)],2)))
table[6,c(2:5)] <- t(c((dfep1[,24]-1),round(dfep1[,c(14:16)],2)))




for(i in 1:ncol(pvals)){
  for(n in 1:nrow(pvals)){
    if(pvals[n,i]<0.01){
      table[i,n+2] <- paste0(table[i,n+2],"**")
    } else if(pvals[n,i]<0.05){
      table[i,n+2] <- paste0(table[i,n+2],"*")
    } else if(pvals[n,i]<0.1){
      table[i,n+2] <- paste0(table[i,n+2],"+")
    } else {
      table[i,n+2] <- paste0(table[i,n+2]) 
    }
  }
}

table
}

t1 <- tablefunc(1,ns)
t2 <- tablefunc(1,21)
t3 <- tablefunc(22,ns)

paste0("full sample")
t1
paste0("2002-2012")
t2
paste0("2013-2013")
t3

