#Code to reproduce Figure A3

rm(list=ls())
#Need to change current directory here to where ever package is saved
setwd("/Volumes/DRIVE1/BACKUP/Research/DamageNowcasts/ReplicationPackage")
library(readxl)
library(tidyverse)

dfA <- as.data.frame(subset(read_excel("Data/ActualDamages.xlsx", sheet="ActualDamages")) )
names(dfA) = c("year","name","cost")
dfA <- dfA[-c(42:46),c(1:3)]
dfA$cost <- dfA$cost/1000000000
dfA$count <- seq_len(nrow(dfA))

dfe <- as.data.frame(c(0:30))
names(dfe) = c("Day")
dfp <- dfe

df1 <- dfe

list <- read.csv(paste0("Data/slist.csv"))
ns <- nrow(list)
for(n in 1:ns){ 
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
  
  for(j in 3:ncol(df)){
    dfe <- cbind(dfe, abs( (dfA[dfA$count==n,]$cost - (df[,j]/1000000000)) ) )  
    dfp <- cbind(dfp, abs( (dfA[dfA$count==n,]$cost - (df[,j]/1000000000))/dfA[dfA$count==n,]$cost ) )     
  }
}  
df1$me <- apply(dfe[,-c(1)], 1, FUN=mean, na.rm=TRUE)
df1$q50 <- apply(dfe[,-c(1)], 1, quantile,probs=0.50, na.rm=TRUE)
df1$q33 <- apply(dfe[,-c(1)], 1, quantile,probs=0.32, na.rm=TRUE)
df1$q66 <- apply(dfe[,-c(1)], 1, quantile,probs=0.68, na.rm=TRUE)

df1 <- df1[-c(1,22:31),]

df1$zero <- 0

gx <- ggplot()
gx <- gx + geom_line(df1, mapping=aes(y=zero, x=Day), color="black" , size=0.5, linetype="dotted" ) 
gx <- gx + theme_classic()
gx <- gx + theme(axis.text.x=element_text(size=15), axis.text.y=element_text(size=15))
gx <- gx + geom_line(df1, mapping=aes(y=q50, x=Day, color="A"), lwd=1)
gx <- gx + geom_line(df1, mapping=aes(y=q33, x=Day, color="C"), linetype="dotted", lwd=0.8)
gx <- gx + geom_line(df1, mapping=aes(y=q66, x=Day), color="Red", linetype="dotted", lwd=0.8)
gx <- gx + scale_color_manual(name="", labels = c("Median Absolute Error","Range (32-68 Percentile)"), values= c("Blue","Red"))
gx <- gx +   theme(plot.caption=element_text(hjust=0),
                   plot.title = element_text(size=6, hjust=0.5, family="Times", colour = "black"),
                   axis.title.x = element_text(size=16, family="Times", colour = "black"),
                   axis.title.y = element_text(size=16, family="Times", colour = "black"),                           
                   axis.text.y = element_text(size=16, family="Times", colour = "black"),
                   axis.text.x = element_text(size=16, family="Times", colour = "black"),
                   axis.ticks.length = unit(-0.15,"cm"),
                   legend.title=element_blank(),
                   legend.text=element_text(size=15, family="Times", colour = "black"),
                   legend.background = element_rect(fill="transparent", colour=NA, size=0),
                   legend.position = c(0.65, 1.05),
                   legend.justification = c(0, 1))
gx <- gx + xlab("Days After Landfall") + ylab("Billions of Dollars")
gx <- gx + scale_y_continuous(limits = c(0,12), expand=c(0,0))                                              
gx <- gx + scale_x_continuous(breaks = seq(1, 20, 2), lim = c(1, 20),  expand = c(0,0))
gx

ggsave(
  filename = "FigureA3.pdf",
  plot = gx,
  width = 8,  # Chosen width
  height = 3, # Chosen height
  units = "in" # Chosen units
)