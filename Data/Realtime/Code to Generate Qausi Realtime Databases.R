rm(list=ls())

last_nm <- 51 

#Need to change current directory here to where ever package is saved
setwd("/Volumes/DRIVE1/BACKUP/Research/DamageNowcasts/ReplicationPackage")

final <- read.csv(paste0("Data/Realtime/Storm",last_nm,".csv"))

for(n in 1:last_nm){ 
  df1 <- read.csv(paste0("Data/Realtime/Storm",n,".csv"))
  df2 <- df1
  df3 <- df1
  df4 <- df1
  df5 <- df1
  df6 <- df1
  df7 <- df1
  
  df1[,c(11,12)] <- final[c(1:nrow(df1)),c(11,12)] # all hazards
  df2[,c(3:9,35)] <- final[c(1:nrow(df2)),c(3:9,35)] #all vulnerabilities
  df3[,c(3:9,11:12,35)] <- final[c(1:nrow(df3)),c(3:9,11:12,35)] #all
  df4[,c(11)] <- final[c(1:nrow(df1)),c(11)] # rain
  df5[,c(12)] <- final[c(1:nrow(df1)),c(12)] # surge
  df6[,c(3,5:9,35)] <- final[c(1:nrow(df2)),c(3,5:9,35)]   #income
  df7[,c(4)] <- final[c(1:nrow(df1)),c(4)] #housing
 
  write.csv(df1,paste0("Data/Realtime/QRT1/Storm",n,".csv"), row.names=FALSE,na='') 
  write.csv(df2,paste0("Data/Realtime/QRT2/Storm",n,".csv"), row.names=FALSE,na='') 
  write.csv(df3,paste0("Data/Realtime/QRT3/Storm",n,".csv"), row.names=FALSE,na='')   
  write.csv(df4,paste0("Data/Realtime/QRT4/Storm",n,".csv"), row.names=FALSE,na='')   
  write.csv(df5,paste0("Data/Realtime/QRT5/Storm",n,".csv"), row.names=FALSE,na='')   
  write.csv(df6,paste0("Data/Realtime/QRT6/Storm",n,".csv"), row.names=FALSE,na='')   
  write.csv(df7,paste0("Data/Realtime/QRT7/Storm",n,".csv"), row.names=FALSE,na='')   
}
