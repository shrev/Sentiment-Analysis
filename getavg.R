getAvgFeatureVecs <- function(data)
{
  
  featureVecs = data.frame(matrix(ncol = 300, nrow = 0))
  
  for(i in 1:2)
  {
    string = data[i,1]
    list=strsplit(gsub("^ *|(?<= ) | *$", "",string, perl=T), split = " ")
    list=list[[1]]
    count=length(list)
    num=0
    average=0
    
    for(word in list)
    {
      if(is.element(word,rownames(vecModel)))
      {
        average = average + vecModel[word,]
        num=num+1
      }
    }
    
    average=average/num
    featureVecs = rbind(featureVecs, setNames(average,names(featureVecs)))
    
  }
  
  featureVecs
}