dir.create("~/Data/StockTwits Data/date/")
path<-"~/Data/StockTwits Data/date/"

folders<-list.dirs("~/Data/StockTwits Data/",recursive = F)[10:12]
for (fold in folders)
{
  dates<-read.table(paste0(fold,"/AAPL.txt"),skip=5,header=T,sep="\t")
  dates<-dates$center.date
  dates<-as.character(dates)
  dates<-dates[!duplicated(dates)]
  for (i in 1:length(dates))
  {
    print(dates[i])
    dir.create(paste0(path,dates[i]))
    
  }  
}


library(tools)
for(fold in folders)
{
  files<-list.files(fold,full.names = T)
   
  for(f in files)
  {
    print(file_path_sans_ext(basename(f)))
    temp<-data.frame()
    temp<-read.table(f,sep="\t",check.names = F,colClasses = "character",stringsAsFactors = F,header=T,skip=5)
    
    temp$temp<-as.character(as.Date(temp$date,format="%Y-%m-%d %H:%M:%S"))
    dates<-temp[!duplicated(temp$temp),][21]
        
    for(j in 1:nrow(dates))
    {
      #print(dates$temp[j])
      temp2<-data.frame()
      temp2<-subset(temp,temp==dates$temp[j])
      temp2<-temp2[-c(21)]
      tryCatch({
      write.table(temp2,paste0(path,dates$temp[j],"/",basename(f)),sep="\t",row.names = F,quote=F)
      },error=function(e){})
    }
  }  
}