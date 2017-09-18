clearHtml<-function(data)
{
  for(i in 1:10)
  {
    t= data[i,3]
    print(t)
    data[i,3]=gsub("<.*?>", "", noquote(gsub("\"", "",t)))
  }
  data
}

clearHtml<-function(data)
{
  for(i in 1:25000)
  {
    t= data[i,2]
    data[i,2]=gsub("<.*?>", "", noquote(gsub("\"", "",t)))
  }
  data
}