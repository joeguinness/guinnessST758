

# John Chambers is the original S developer
quoteJohnChambers <- function(){
    print("Everything that exists is an object.")
    print("Everything that happens is a function call.")
}
quoteJohnChambers()  # calls the function
quoteJohnChambers    # prints information about it


# Corollary, functions are objects
quoteMelaniaTrump <- quoteJohnChambers  # copies the function
quoteMelaniaTrump()


# Functions are defined using the "function" function.
# The arguments to function() become the arguments to
# the function we are defining.
# A block of code in curly braces is executed when
# the function is called.
# You can also specify what is to be returned when the
# function is called.
myfun <- function(x,y){ # myfun is a function of x and y
    z <- x+y
    return(z)
}

# calling myfun returns the sum of its two arguments
myfun(2,3)

# By default, functions return whatever is evaluated last.
# So myfun can be shortened to
myfun <- function(x,y){
    x+y
}
myfun(2,3)

# one line functions can omit curly braces
myfun <- function(x,y) x + y
myfun(2,3)


# Functions can have default values. This function
# exponentiates the first argument to the second power,
# or returns the first argument, if 2nd not specified
myfun <- function(x, y = 1){
    # this is a really useful comment!
    x^y
}
myfun(2)
myfun(2,3)
myfun(y=3,x=2)  # unusual way to call it, but allowed
myfun(y=3,2)    # unusual way to call it, but allowed
myfun(3,2)      # not the same as myfun(y=3,2)
myfun(y=2)  # arguments without default must be specified
# x is required since it has no default value
# and the execution of the function requires x
# R also allows for partial matching of arguments,
# but I recommend against using this feature

# Since functions are objects, they can have attributes.
# One useful attribute is srcref, the source code
# for the function
attributes(myfun)
attr(myfun,"srcref")
myfun

# Wickham characterizes functions by their three parts
formals(myfun)       # the arguments
body(myfun)          # expressions that are evaluated
environment(myfun)   # what's an environment?

# Environments are a hierarchical organization of objects.
# Every R object is associated with an environment
# If an object is referenced, R searches the current
# environment, and if it's not found, then it searches
# in parent of the environment, and so on.
# This also applies to looking up functions!

# We'll cover this in more detail later, but for now,
# let's look at some examples for how this works
myfun <- function(x){
    print(x)
    x*y   
}
y <- pi
x <- 1         
z <- myfun(2)  # x gets masked by value in fxn environment
z                
print(x)       # prints value of x in R_GlobalEnv

# Another example
# variables from different environments can be accessed
# with the $ operator.
myfun <- function(x){
    e <- environment()  # get the function environment
    p <- parent.env(e)  # parent of function environment
    print(e$x)
    print(p$x)
}
x <- pi
myfun(2*pi)



# R does dynamic lookup for variables not in the
# function environment
x <- 7
myfun <- function(y) y*x   # x = 7 at function defn time
myfun(4)   # evaluates with x = 7
x <- 9
myfun(4)   # evaluates with x = 9
# We should avoid writing functions that operate this
# way because they can return different results when
# called with the same arguments


# the codetools library has a function 
# findGlobals to check for external dependencies
myfun1 <- function() x*x
myfun2 <- function(x) x*x
codetools::findGlobals(myfun1)
codetools::findGlobals(myfun2)
# This might help you find a bug one day


# R makes separate copies of objects, including functions
myfun1 <- function(x) x^2
myfun2 <- myfun1               # function(x) x^2
myfun1 <- function(x) sqrt(x)  # does NOT change myfun2
myfun1
myfun2
myfun1(9)
myfun2(9)
# might seem obvious, but other languages don't operate
# this way and caused a recent headache for me


# functions can be nested, but use with caution, 
# especially when combined with lexical scoping
# predict the output of a call to myfun1
myfun1 <- function(){
    x <- 11
    y <- 12
    z <- 13
    myfun2 <- function(){
        y <- 22
        z <- 23
        myfun3 <- function(){
            z <- 33
            print(c(x,y,z))
        }
        myfun3()
        print(c(x,y,z))
    }
    myfun2()
    print(c(x,y,z))
}
myfun1()
myfun2()
myfun3()


# I don't recommend this, but assigning a variables to
# existing function name does not completely override it
# Augmented Example from Advanced R
c(c <- 1, c = c)  # can assign inside of call to c()
c("lazy","dog")   # Still works as before
c[1]              # R uses context to evaluate this line
c[c]              # not clear what will happen
c                 # this clears it up

# NOT the same as
rm(c) # clear definition of c
c(c = c, c <- 1)


# Everything that happens is a function call
# Some operations don't look like function calls,
# but they are!
3 + 4
`+`(3,4)
v1 <- 7
`<-`(v2,7)
v1
v2
vec <- c(1,2)
vec[1] <- 2
vec
`[<-`(vec,2,4)  # sometimes useful in calls to apply
vec
obj <- 1:4
dim(obj) <- c(2,2)  # concise way of setting dimensions
obj
# roundabout way to define a 2x2 matrix
obj <- `dim<-`(1:4,c(2,2))    
obj

# comparison operators are functions
pi > 3 && pi < 4
`&&`(pi>3,pi<4)

# % % operators are functions, too
mat <- matrix(1:4,2,2)
vec <- c(0,1)
mat %*% vec
`%*%`(mat,vec)

# we can actually define our own.
`%@%` <- function(userid,domain){
    paste(userid,domain,sep="@")
}
"jsguinne" %@% "ncsu.edu"


# Functions can return only single objects
# But that object can be a list that contains
# many objects
# lm() is a good example 
# (fits a linear model with least squares)
y <- rnorm(10)
x <- 1:10
fit <- lm(y ~ x)
typeof(fit)
length(fit)
names(fit)
fit$coefficients
fit$residuals
attributes(fit)


# let's look at an example
summaryStats <- function( vec ){
    # this functin returns summary statistics of a vector
    mean_vec <- mean(vec)
    sd_vec <- sd(vec)
    range_vec <- range(vec)
    list(mean = mean_vec,    
                sd = sd_vec, 
                range = range_vec)  # A list is 1 object!
}
SS <- summaryStats(rnorm(10000))
SS$mean
SS$sd
SS$range


# in some situations, for example when doing a simulation
# study with lots of different parameter settings,
# it may make the code look cleaner and more readable
# if you put all of the settings in a data frame. do.call()
# allows you to pass all arguments at once to a function
normargs <- list(n = 1000, mean = 0, sd = 1)
simvals  <- do.call(rnorm,normargs)
hist(simvals)

sim_settings <- data.frame(n = rep(c(1e2,1e3,1e4),2),
                           mean = rep(0,6),
                           sd = rep(c(1,2),each=3) )
sim_settings

par(mfrow=c(2,3))
for(sim in 1:6){
    simvals <- do.call(rnorm,sim_settings[sim,])
    hist(simvals,xlim=c(-8,8), breaks = seq(-10,10,by=0.2))
}




# R has lazy evaluation, which means that arguments
# are only evaluated unless they are called upon 
# inside the function (Examples from Advanced R)
myfun <- function(x){
    10
}
myfun(stop("This is an error"))

# if the default value for an argument is the result of
# a function call, then that call happens in the 
# function's environment
myfun <- function(x = ls()){
    a <- 1
    x
}
myfun()
ls()



# Function definitions allow for a ... argument, which
# means that additional arguments can be passed
# This is used extensively in R, especially when arguments
# to a function are passed to other functions
?plot

myfun <- function(...){
    names(list(...))
}
myfun()  # same as names(list())
myfun(x=1,y=2,z=3)
?list # list is a function that takes in generic arguments
# ... makes documentation hard to read but it's used a lot



