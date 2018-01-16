path<-"C:/Users/Adi/Documents/Research/6-Data/Twitter Data/Activity/date/"

folders<-list.dirs("Research/6-Data/Twitter Data/Activity",recursive = F)[2:7]
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
  
  print(fold)
  for(f in files)
  {
    #f<-files[1]
    print(file_path_sans_ext(basename(f)))
    
    temp<-data.frame()
    temp<-read.table(f,sep="\t",check.names = F,colClasses = "character",stringsAsFactors = F,header=T,skip=5)
    
    temp$temp<-as.character(as.Date(temp$date,format="%Y-%m-%d %H:%M:%S"))
    dates<-temp[!duplicated(temp$temp),][ncol(temp)]
    #temp<-temp[-c(21)]
    
    for(j in 1:nrow(dates))
    {
      #print(dates$temp[j])
      temp2<-data.frame()
      temp2<-subset(temp,temp==dates$temp[j])
      temp2<-temp2[-c(ncol(temp))]
      tryCatch({
      write.table(temp2,paste0(path,dates$temp[j],"/",basename(f)),sep="\t",row.names = F,quote=F)
      },error=function(e){})
    }
  }  
}