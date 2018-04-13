master_file<-read.table('C:/Users/Adi/Documents/Research/6-Data/Twitter Data/201712/master.txt',
                        sep="\t",check.names = F,colClasses = "character",stringsAsFactors = F,header=F)
coln<-c("ticker"	,"date"	,"raw-s"	,"raw-s-mean"	,"raw-volatility"	,"raw-score"	,"s"	,"s-mean"	,"s-volatility"	,"s-score"	,"s-volume"	,"sv-mean"	,"sv-volatility"	,"sv-score","s-dispersion"	,"s-buzz"	,"s-delta"	,"center-date"	,"center-time"	,"center-time-zone")
colnames(master_file)<-coln

times<-unique(master_file$date)


for(t in times)
{
  print(t)
  filen<-gsub(" ","_",t)
  filen<-gsub(":","-",filen)
  temp<-subset(master_file,date==t)
  temp<-temp[-c(2,18:20)]
  write.table(temp,paste0("C:/Users/Adi/Documents/Research/6-Data/Twitter Data/sma_history_tw_15m_equities_20180101_20180228/date/",filen,".txt"),sep="\t",row.names = F,quote=F)
}