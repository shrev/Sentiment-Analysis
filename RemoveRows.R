removeRows<-function(x,vec)
{
  for(i in vec )
  {
    x=x[,-grep(i,colnames(x))]
  }
  x
}