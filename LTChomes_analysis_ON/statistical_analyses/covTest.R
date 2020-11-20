set.seed(1234)
x=matrix(rnorm(100*10),ncol=10)
x=scale(x,TRUE,TRUE)/sqrt(99)
beta=c(4,rep(0,9))
y=x%*%beta+.4*rnorm(100)

#Gaussian
a=lars(x,y)
covTest(a,x,y)

#EN
a=lars.en(x,y,lambda2=1)
covTest(a,x,y)

#logistic
y=1*(y>0)

a=lars.glm(x,y,family="binomial")
covTest(a,x,y)

x=matrix(rnorm(100*10),ncol=10)
x=scale(x,TRUE,TRUE)/sqrt(99)

x[,2]

#logistic
y=5*x[,2]+rnorm(100)
y=1*(y>0)
a=lars.glm(x,y,family="binomial")

covTest(a,x,y)
