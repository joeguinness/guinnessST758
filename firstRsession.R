

# hashes are for comments    #commentyourcode

# commands can be typed directly into the console
# better practice is to create a text file
# convention is to name R files with the .R suffix

# important to figure out where we are
getwd()
setwd("/Users/jsguinne/Documents/teaching/ST758_2016/guinnessST758")



# assign variables with the assignment operator `<-`
x <- 7.3

# typing in a variable prints it out
x

# this is the same as
print(x)

# mathematical expressions
cos(x)
x^2
x+2
x*9.01
log(x)   # natural log of x
log2(x)  # log base 2
log10(x)
exp(x)   # e^x

# create vectors
1:10
y <- 1:10
y <- seq(0.1,1,by=0.1)  # sequence of numbers separated by .1 from .1 to 1
length(y)
?seq                    # get help on a function
help(seq)
apropos("seq")
example(seq)
rep(0,5)
rep(1:4,5)
rep(1:4,each=5)

# subset vectors with square brackets
y[1]
y[10]
y[1:4]
y[-1]          # -1 gives all but the first entry
#y(1)           # y is not a function, so can't use () 

# create matrices
mat1 <- matrix(1:6,2,3)               # default is column major order
mat1
mat2 <- matrix(1:6,2,3,byrow=TRUE)    # can override with byrow=TRUE
mat2
# subset with two indices separated by a comma
mat1[2,3]
# R supports linear indexing as well (in column major ordering)
mat1[2]
mat2[3]

# use array() function to create higher-dimensional arrays
arr <- array(1:8,c(2,2,2))
?array

# concatenation with c() function
c(x,y)
c(1,2,5,0)
c(y,c(x,8))




## control flow of a program -----------------------------------------

# if else statements, enclose conditional statements in curly brackets
if( x < 7 ){
    print("x is less than 7")
} else { 
    print("x is not less than 7")
}

# When there is only one line per statement, this can be shortened to
if( x < 7 ) print("x is less than 7") else print("x is not less than 7")


## for loops -----------------------------------------------------------

# loop over values in y and do something each time
for( j in y ){
    print( x+j )
}

# shorter version
for(j in y) print(x+j)

# or loop over the integers 1 through the length of y and subset y
for(j in 1:length(y)) print(x+y[j])

# you should avoid using "j in 1:length(y)" because the output is not what
# we expect if length(y) is 0. Then it's "for(j in 1:0)"

randvec <- rnorm(10)                     # generate 10 normals
largevals <- randvec[ randvec > 2 ]      # extract values larger than 2
for(j in 1:length(largevals)){           # loop over the large values
    print(largevals[j])                  # print out each one
}

# better practice is to use seq(along = largevals)
# returns numeric(0) if largevals has length 0
randvec <- rnorm(10)                     # generate 10 normals
largevals <- randvec[ randvec > 2 ]      # extract values larger than 2
for(j in seq(along=largevals)){           # loop over the large values
    print(largevals[j])                  # print out each one
}


## while loops ---------------------------------------------------------

# I try to use these sparingly because they can lead to infinite loops

# this one exits in finite time with probability 1
randomsum <- 0
while( randomsum < 3 ){
    randomsum <- randomsum + rnorm(1)
    print(randomsum)
}




# an entire script can be run with the source() command
# don't uncomment this!
# source("firstRsession.R")
# source quits if there is an error
# only prints statements that explicitly use print() command
# source() also operates in a different environment. This is important
# because it ignores all local variables (we will cover this later), so 
# will more closely replicate with would happen in a "clean" R session,
# as if someone else opened your code in a new R session and ran it




