#BIOS 731 Lecture 1 on Bayesian Computation
library(lattice)
library(mvtnorm)
my.cols = rgb(read.table(file="~/Dropbox/Code/C++/results/Rcode/my.heat.map"))

#Beta-Binomial 
example1.plot = function(x,n){
  z = seq(0.01,0.99,length=99)
  dz = dbeta(z,x+1,n+1-x)
  adz = dnorm(z,mean = x/n,sd=sqrt(x*(n-x)/n^3))
  plot(z,dz,type="l",main=paste("n = ",n,", x = ",x),lwd=2)
  lines(z,adz,col="red",lwd=2)
  legend("topright",c("Posterior","Normal Approximation"),lwd=2,lty=1)
}

par(mfcol=c(2,1),mar=c(2,2,2,2))
example1.plot(n=10,x=1)
example1.plot(n=100,x=10)

#simple linear regression

#simulate data
set.seed(200)
n = 100
alpha = 1
beta = 2
x = rnorm(n,mean=1,sd=1)
y = alpha+beta*x+rnorm(n,sd=1)

#compute the true posterior distribution 

#compute summary statistics

sum.x = sum(x)
sum.y = sum(y)
sum.x2 = sum(x*x)
sum.x.y = sum(x*y)

V = sum.x2*(n+1)-sum.x*sum.x
nu.alpha = (sum.x2+1)*sum.y-sum.x*sum.x.y
nu.beta = (n+1)*sum.x.y-sum.x*sum.y

#compute posterior mean and variance
post.mean = c(nu.alpha,nu.beta)/V
post.sigma = matrix(c(sum.x2+1,-sum.x,-sum.x,n+1),nrow=2,ncol=2)/V

#theta.sample = rmvnorm(100000,mean=post.mean,sigma=post.sigma)
#sum(apply(theta.sample^2,2,mean))


grids2D = as.matrix(expand.grid(seq(0,2,length=101),seq(1,3,length=101)))
post.density = dmvnorm(grids2D,mean=post.mean,sigma=post.sigma)
levelplot(post.density~grids2D[,1]+grids2D[,2],col.regions=my.cols,cuts=255,
          xlab=list(expression(alpha),cex=3),ylab=list(expression(beta),cex=3),
          main=list(paste("Ture Poseterior Density (n=",n,")",sep=""),cex=3),panel=function(...){
            panel.levelplot(...)
            lpoints(alpha, beta, 
                    pch="X",col="white",cex=3)
          })


#E(alpha^2+beta^2|Data)



#Define h function
h.fun = function(theta,x,y){
  alpha = theta[1]
  beta = theta[2]
  n = length(y)
  return((sum((y-alpha-beta*x)^2)+alpha^2+beta^2)/(2*n))
}

h.star.fun = function(theta,x,y){
  n = length(y)
  return(h.fun(theta,x,y) - log(sum(theta^2))/n)
}

#find alpha. and beta 

#first order approximation

theta.hat = optim(c(0.5,1),h.fun,method="Nelder-Mead",x=x,y=y)$par


sigma.hat.inv =1/n*matrix(c(n+1,sum.x,sum.x,sum.x2+1),nrow=2,ncol=2)
det.sigma.hat.sqrt = 1/sqrt(det(sigma.hat.inv))
#second order approximation 

theta.tilde = optim(c(0.5,1),h.star.fun,method="Nelder-Mead",x=x,y=y)$par

alpha.tilde = theta.tilde[1]
beta.tilde = theta.tilde[2]
sigma.tilde.inv = sigma.hat.inv+2/(n*sum(theta.tilde^2)^2)*matrix(c(alpha.tilde^2-beta.tilde^2,
                                                                    2*alpha.tilde*beta.tilde,
                                                                    2*alpha.tilde*beta.tilde,
                                                                    beta.tilde^2-alpha.tilde^2),
                                                                  nrow=2,ncol=2)
det.sigma.tilde.sqrt = 1/sqrt(det(sigma.tilde.inv))


(true.g.theta = sum(post.mean^2)+sum(diag(post.sigma)))
(first.g.theta = sum(theta.hat^2))
(second.g.theta = (det.sigma.tilde.sqrt*exp(-n*h.star.fun(theta.hat,x,y)))/(det.sigma.hat.sqrt*exp(-n*h.fun(theta.hat,x,y))))


#approximation to marginal densities

#true marginal density of beta


K = 1001
b = seq(0,4,length=K)
w = b[2]-b[1]

true.pi.beta = dnorm(b,mean=nu.beta/V,sd=(n+1)/V)

log.den = sapply(1:length(b),function(k) -n*h.fun(c((sum.y - b[k]*sum.x)/(n+1),b[k]),x,y))

#log.den =sapply(1:length(b),function(k) -n*h.fun(c(a[k],b[k]),x,y))

den = exp(log.den-max(log.den))
den = den/w/sum(den)

plot(b,den,type="l",ylim=c(0,max(den,true.pi.beta)),lwd=3,xlab=expression(beta),ylab="Density")
lines(b,true.pi.beta,col="red",lwd=3)
legend("topright",c("True","Approximated"),col=c("red","black"),lwd=3)





