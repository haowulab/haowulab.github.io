#Lecture 3

#######################################################
# Gibbs Sampler
##############################

#observed data
y = c(5, 1, 5, 14, 3, 19, 1, 1, 4, 22)
t = c(94, 16, 63, 126, 5, 31, 1, 1, 2, 10)
rbind(y, t)

#Define starting values for beta (we only need to define beta here
#because we will draw lambda first and it only depends on beta and
#other given values).

beta.cur = 1

# Draw lambda from its full conditional (we’re drawing all the lambda_i s
# as a block because they all only depend on beta and not each
# other).

lambda.update = function(alpha, beta, y, t) {
 rgamma(length(y), y + alpha, t + beta)
}

# Draw beta from its full conditional, using lambda

beta.update = function(alpha, gamma, delta, lambda, y) {
   rgamma(1, length(y) * alpha + gamma, delta + sum(lambda))
}

#Repeat using most updated values until we get M draws.
#Optional burn-in and thinning.
#Make it into a function.

gibbs = function(n.sims, beta.start, alpha, gamma, delta,
                     y, t, burnin = 0, thin = 1) {
   beta.draws <- matrix(NA, nrow=n.sims,ncol=1)
   lambda.draws <- matrix(NA, nrow = n.sims, ncol = length(y))
   beta.cur <- beta.start
   for (i in 1:n.sims) {
     lambda.cur <- lambda.update(alpha = alpha, beta = beta.cur,y = y, t = t)
     beta.cur <- beta.update(alpha = alpha, gamma = gamma,delta = delta, lambda = lambda.cur, y = y)
     if (i > burnin & (i - burnin)%%thin == 0) {
       lambda.draws[(i - burnin)/thin, ] <- lambda.cur
       beta.draws[(i - burnin)/thin] <- beta.cur
       }
     }
   return(list(lambda.draws = lambda.draws, beta.draws = beta.draws))
 }


#Posterior simulation

posterior <- gibbs(n.sims = 10000, beta.start = 1, alpha = 1.8, 
                   gamma = 0.01, delta = 1, y = y, t = t)

#Summary statistics
colMeans(posterior$lambda.draws)
mean(posterior$beta.draws)

apply(posterior$lambda.draws, 2, sd)
sd(posterior$beta.draws)


#######################################################
# The Metropolis-Hastings Algorithm
#######################################################
# Sample Gamma Distribution
#######################################################


theta.update.random.walk = function(theta.cur, shape, rate, cand.sd) {
  theta.can = rnorm(1, mean = theta.cur, sd = cand.sd)
  accept.prob = dgamma(theta.can, shape = shape, rate = rate)/dgamma(theta.cur,shape = shape, rate = rate)
  if (runif(1) <= accept.prob)
    return(theta.can)
  else return(theta.cur)
}

theta.update.indep = function(theta.cur, shape, rate) {
  theta.can = rnorm(1, mean = shape/rate, sd = sqrt(shape/rate^2))
  accept.prob = dgamma(theta.can, shape = shape, rate = rate)/dgamma(theta.cur,shape = shape, rate = rate)
  if (runif(1) <= accept.prob)
    return(theta.can)
  else return(theta.cur)
}



mh.gamma = function(n.sims, start, burnin, shape, rate,method="random.walk",cand.sd=NULL) {
   theta.cur = start
   draws = c()
   
   if(method=="random.walk"){
     for (i in 1:n.sims) {
       theta.cur = theta.update.random.walk(theta.cur, shape = shape,rate = rate,cand.sd=cand.sd)
       draws[i] = theta.cur
     }
   }
   
   if(method=="independent"){
     for (i in 1:n.sims) {
       theta.cur = theta.update.indep(theta.cur, shape = shape,rate = rate)
       draws[i] = theta.cur
     }
   }
   
   return(draws[(burnin + 1):n.sims])
}

shape = 1.7
rate = 4.4
mh.draws = mh.gamma(10000, start = 1, burnin = 0, shape = shape, rate = rate, 
                    method="random.walk",cand.sd=2)

# mh.draws = mh.gamma(10000, start = 1, burnin = 0, shape = shape, rate = rate, 
#                     method="independent")


#trace plot
plot(mh.draws,type="l")
hist(mh.draws,prob=TRUE,ylim=c(0,2))
box()
xx = seq(0.001,3,length=1000)
lines(xx,dgamma(xx,shape=shape,rate=rate),col="red",lwd=3)


