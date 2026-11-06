#BIOS 731 Lecture 2 on Bayesian Computation

##########################################################
#Directly sample from posterior distribution
##########################################################

#simulate data
mu = 5
sigma = 3
n = 10000
y = rnorm(n,mean=mu,sd=sigma)

N = 10000
sigma2_draws = (n-1)*var(y)/rchisq(N,df=n-1)
mu_draws = rnorm(N,mean=mean(y),sd=sqrt(sigma2_draws))
hist(mu_draws,breaks=50,prob=TRUE)

# predictive probability 
cc = 5
pred_y = pnorm(cc,mean=mu_draws,sd=sqrt(sigma2_draws),lower.tail=FALSE)
mean(pred_y)


##########################################################
#Grid approximation
##########################################################

#Define prior
triangle.prior = function(x) {
  if ((x >= 0) && (x < 0.25))
     8 * x
   else if ((x >= 0.25) && (x <= 1))
     8/3 - 8 * x/3
   else 0
}

#Plot the prior
xx = seq(0,1,length=100)
plot(xx,triangle.prior(xx),type="l") # not correct


#Define prior for vector input
triangle.prior.vec =  function(x) {  
  y = rep(0,length=length(x))
  idx = which((x >= 0) & (x < 0.25))
  y[idx] = 8*x[idx]
  idx = which((x >= 0.25) & (x <= 1))
  y[idx] = 8/3 - 8 * x[idx]/3
  return(y)
}

#Plot the prior
plot(xx,triangle.prior.vec(xx),type="l")

#Define the unnormalized postrior
posterior.function = function(theta, n, y) {
   return((theta^y) * (1 - theta)^(n - y) * triangle.prior.vec(theta))
}

#1. Setup grid points
m = 100
grid.points = seq(from = 0, to = 1, length.out = m)

k = (grid.points[2]-grid.points[1]) # grid width

#2. Evaluate the unnormalized posterior
unnormal.post.ord = posterior.function(theta = grid.points,n = 5, y = 2)
plot(xx,unnormal.post.ord,type="l")

#3. find the normalizing constant and normalized postrior.

normal.constant = k*sum(unnormal.post.ord)
normal.post.ord  = unnormal.post.ord/normal.constant
plot(xx,normal.post.ord,type="l")

# We can directly sample from the unnomarlized posterior using 
# function sample()

set.seed(12345)
posterior_sample <- sample(grid.points, 
                               size = 10000, 
                               replace = TRUE,
                               prob = unnormal.post.ord)

#pdf(file="/Users/jkang30/Dropbox/Emory/Teaching/BIOS731/Slides/fig2_1.pdf",width=8,height=6)
hist(posterior_sample,prob=TRUE,xlim=c(0,1),border="lightblue",
     col="lightblue",xlab=expression(pi),main="Posterior Sample")
box()
lines(xx,normal.post.ord,col="red",lwd=3)
lines(xx,triangle.prior.vec(xx),col="blue",lwd=3)
#legend("topleft",c("Prior","Posterior"),lwd=3,col=c("blue","red"))
#dev.off()


#####################################################
#Importance sampling
#####################################################

h.fun = function(x){
  return(x*(1-x))
}

g.fun = function(x,y,n){
  return(dbeta(x,y+1,n+1-y))
}

weight.fun = function(x,y,n){
  return(posterior.function(x,n,y)/g.fun(x,y,n))
}

sample.g = function(N,y,n){
  return(rbeta(N,y+1,n+1-y))
}

sample.posterior = function(N,y,n,m = 100){
  grid.points = seq(from = 0, to = 1, length.out = m)
  unnormal.post.ord = posterior.function(theta = grid.points,n = n, y=y)
  posterior_sample <- sample(grid.points, 
                             size = N, 
                             replace = TRUE,
                             prob = unnormal.post.ord)
  return(posterior_sample)
}



y = 1 
n = 1000
N = 100
theta = sample.g(N,y,n)
weights = weight.fun(theta,y,n)
(importance.sample.estimate = sum(h.fun(theta)*weights)/sum(weights))
theta1 = sample.posterior(N,y,n)
(direct.sample.estimate = mean(h.fun(theta1)))


#####################################################
# Rejection sampling
#####################################################
f.x =  function(x) {  
  y = rep(0,length=length(x))
  idx = which((x >= 0) & (x < 0.25))
  y[idx] = 8*x[idx]
  idx = which((x >= 0.25) & (x <= 1))
  y[idx] = 8/3 - 8 * x[idx]/3
  return(y)
}

g.x = function(x){
  y = rep(0,length=length(x))
  idx = which((x<=1)&(x>=0))
  y[idx] = 1
  return(y)
}

M = 2

plot(xx,f.x(xx),type="l",ylim=c(0,4),ylab="Density",xlab="x",col="red"
     ,lwd=3)
lines(xx,M*g.x(xx),col="blue",lwd=3)
#legend("topleft",c("Mg(x)","f(x)"),col=c("blue","red"),lwd=3)
#dev.off()


rejection.sample = function(N,M=2){
   n.draws = 0
   draws = rep(NA,length=N)
   k = 0
   while (n.draws < N) {
    k = k+1
    x.c <- runif(1, 0, 1)
    accept.prob <- f.x(x.c)/(M * g.x(x.c))
    u <- runif(1, 0, 1)
    if (accept.prob >= u) {
       n.draws <- n.draws + 1
       draws[n.draws] <- x.c
    }
   }
   return(list(draws=draws,accept_rate = N/k))
}

#pdf(file="/Users/jkang30/Dropbox/Emory/Teaching/BIOS731/Slides/fig2_2.pdf",width=8,height=6)
M = 2
x_sample = rejection.sample(10000,M=M)

hist(x_sample$draws,prob=TRUE,xlim=c(0,1),border="lightblue",
     col="lightblue",xlab="x",main=sprintf("Rejection Sampling (M = %d, accept rate = %.2f)",M,x_sample$accept_rate),
     ylim=c(0,4))
box()
lines(xx,f.x(xx),col="red",lwd=3)
lines(xx,M*g.x(xx),col="blue",lwd=3)
#legend("topleft",c("Mg(x)","f(x)"),lwd=3,col=c("blue","red"))
#dev.off()

#####################################################
# Weighted Bootstrap
#####################################################


weighted.bootstrap = function(N,a,b) {
  theta.star = rbeta(N,a,b)
  weights = f.x(theta.star)/dbeta(theta.star,a,b)
  draws= sample(theta.star,N,replace=TRUE,prob=weights)
  return(draws)
}

g1.x =function(x,a,b){
  return(dbeta(x,a,b))
}

N = 10000
a = 0.5
b = 0.5
#pdf(file="/Users/jkang30/Dropbox/Emory/Teaching/BIOS731/Slides/fig2_3.pdf",width=8,height=6)
draws = weighted.bootstrap(N,a=a,b=b)
hist(draws,prob=TRUE,xlim=c(0,1),border="lightblue",
     col="lightblue",xlab="x",main="Weighted Bootstrap",
     ylim=c(0,4))
box()
lines(xx,f.x(xx),col="red",lwd=3)
lines(xx,g1.x(xx,a,b),col="blue",lwd=3)
#legend("topleft",c("g(x)","f(x)"),lwd=3,col=c("blue","red"))
#dev.off()
length(unique(draws))



