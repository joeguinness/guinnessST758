



# Homework 1, Due August 30, 2016 at the beginning of class

# write an R script to solve the problems in this assignment,
# save the R script as <unityid>HW1.R


# IMPORTANT: The homeworks will be graded by 
# me or the TA running source("<unityid>HWj.R")
# and looking at the printed output and any files that are output,
# so make sure you check that sourcing your file produces the output you expect
# We may also look at your code, so if you want to have the best chance
# of getting partial credit, make sure you provide informative comments.


## Problems below

## 1. 

# initialize vectors of logical, integer, double, complex, and character types
# of length 1000 and print out their sizes with object.size()




## 2. 

# the following code creates a vector and a matrix of size 1000 x 1000
vec <- (1:1000)/1000
mat <- exp( - sqrt( outer( vec, -vec, "+" )^2 ) ) 


# write a double for loop to matrix multiply mat by vec
# and store the result in a vector named 'result'

# print out the time it takes to multiply using the double for loop 
# and the time it takes to matrix multiply with the %*% operator
# ( use proc.time() or system.time() for this )

# compare the result to what you get by doing matrix multiplication
# by printing out the sum of squared diferences between result and (mat %*% vec)




## 3. 
# There is a file trigfuns.eps in the course directory. Write R code to reproduce
# the plot as closely as possible

# save the result as 'hw1p3.eps'




## 4. (optional for fun) make a plot of the olympic rings, matching the image
# below as close as possible, with a white background. (no axes or labels)

# https://en.wikipedia.org/wiki/Olympic_symbols#/media/File:Olympic_rings_without_rims.svg

# save the result as 'hw1p4.eps'







