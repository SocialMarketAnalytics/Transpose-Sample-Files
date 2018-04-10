dir.create("~/Research/6-Data/Twitter Data/date/")
path<-"~/Research/6-Data/Twitter Data/date/"

folders<-list.dirs("~/Research/6-Data/Twitter Data/K2/",recursive = F)
for (fold in folders)
{
  dates<-read.table(paste0(fold,"/AAPL.txt"),skip=5,header=T,sep="\t")
  dates<-dates$date
  dates<-as.character(dates)
  dates<-gsub(" ","_",dates)
  dates<-gsub(":","-",dates)
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
    
    dates<-temp[2]
    
    for(j in 1:nrow(dates))
    {
      #print(dates$temp[j])
      temp2<-data.frame()
      temp2<-subset(temp,date==dates$date[j])
      path2<-gsub(" ","_",dates$date[j])
      path2<-gsub(":","-",path2)
      temp2<-temp2[-c(2,18:20)]
      tryCatch({
        write.table(temp2,paste0(path,path2,"/",basename(f)),sep="\t",row.names = F,quote=F)
      },error=function(e){})
    }
  }  
}