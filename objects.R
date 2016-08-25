

# R objects and Data Structures

# the typeof() function determines the type of variable
# that sits inside of R objects

typeof(NULL)
typeof(TRUE)
typeof(3L)    # *L is an integer type
typeof(3)
typeof(3:4)   # the : operator returns integers, not double
typeof(3i)
typeof("3")
typeof( function(x) x )

# there are a set of functions of the form is.*() for testing
# the type of object

is.integer(3)
is.integer(3L)
is.double(pi)
is.character("seven")
is.numeric(TRUE)

# there is also an is() function that operates as follows
is(3,"integer")
is(3L,"integer")
is(pi,"character")


# R also has native support for missing values
NA
typeof(NA)

# There are actually several types of NA values.
# we'll cover coercion later, but this shows that
# an NA can be an integer (or double, complex, or character)
NA_integer_
NA_real_
NA_complex_
NA_character_

# the mode() function and storage.mode() functions
# do something similar, but not quite the same
# (R has some legacy functions)

# We can initialize objects of specific types 
# with the vector() function (puts in a default value)

vector()
int_vec <- vector( mode = "integer", length = 10 )
dub_vec <- vector( mode = "double", length = 10 )
str_vec <- vector( mode = "character", length = 10 )

# there are other ways to initialize vectors
rep(0L,10)
rep(0,10)
rep("",10)
c(1,2,3,4)         # c() is for combine or concatenate

# we use length() to figure out how many entries are in the vector
length(rep(0,10))
length( c("a","ab","abc") )

# vectors can have named entires
heights <- c(jenny = 165, evan = 188, emma = 173)


# The vector is the most basic data type in R 
# (there is no "constant" or "scalar" type)
# we think of a vector as a one-dimensional array
# vectors come in two forms: 
# atomic: all entries have the same type
# list: entries are allowed to have different types
# A LIST IS A VECTOR IN R

# there are multiple ways to subset an atomic vector
vec <- sort(rnorm(3))
vec

vec[1]                       # first entry
vec[2:3]                     # second and third entry
vec[-1]                      # everything but the first entry
vec[c(FALSE,TRUE,TRUE)]      # second and third using logical vector
vec[ vec < 0 ]               # the object vec < 0 is logical type 
heights[1]
heights[heights < 180]
heights["evan"]              # named vectors subset with names
heights[c("jenny","emma")]
heights[c(1,1,2,2,3)]        # we can repeat indices
heights[c(2,1,3)]            # or put them in different orders 



# since lists are vectors, they can be initialized with vector()
list_vec <- vector( mode = "list", length = 10 )
typeof(list_vec)

# we can also "coerce" from one type to another using as.*() functions
heights_list <- as.list( heights )
heights_list

# lists can also be named or not named
# and can be subset in multiple ways

heights$jenny              # this gives an error
heights_list$jenny
heights_list[2]            # this returns a list of length one
heights_list[[2]]          # double brackets returns the contents of the entry
heights_list["jenny"]      # can use the names also
heights_list[["jenny"]]
heights_list$"evan"          # the $ operator may use quotes


# entries of a list can be of any type, even another list!
list_vec[[1]] <- heights
list_vec[[2]] <- heights_list

# we can subset of a list in one line
list_vec[[1]][3]
list_vec[[2]][3]
typeof(list_vec[[1]][3])
typeof(list_vec[[2]][3])

# lists can contain functions
somefuns <- list( function(x) x, function(x) x^2 )
typeof( somefuns )
typeof( somefuns[1] )
typeof( somefuns[[2]] )
someotherfuns <- c( function(x) x, function(x) x^2 )

# use identical() to test of two objects are the same
all.equal( somefuns, someotherfuns )   # test for equality
identical( somefuns, someotherfuns )   # more strict test for equality
# for fun, figure out why they are not identical (what's different?) I have no idea



# since entries of atomic vectors must all have the same type,
# there are rules for coercing the entries to be of the same type
# there is an ordering to the complexity of types in R
# logical < integer < double < complex < character 

typeof( c(NA,TRUE,1L) )
typeof( c(NA,TRUE,1L,1) )
typeof( c(NA,TRUE,1L,1,1i) )
typeof( c(NA,TRUE,1L,1,1i,"1") )

intvec  <- c(NA,TRUE,1L)
dubvec  <- c(NA,TRUE,1L,1)
compvec <- c(NA,TRUE,1L,1,1i)
charvec <- c(NA,TRUE,1L,1,1i,"1")

intvec[1]
dubvec[1]
identical( intvec[1], dubvec[1] )

# since coercion happens without throwing an error or warning,
# it is often a source of silent bugs, so be careful about this

# coercion can also be done explicity with the as.*() family of functions
as.logical(c(0,1,2,3))
as.integer(c(TRUE,8.9))
as.character(c(TRUE,FALSE,pi))

# or with the as() function, which operates like the is() function
as(c(0,1,2,3.7),"logical")
as(c(TRUE,8.9),"integer")
as(c(TRUE,FALSE,pi),"character")




# vectors can have attributes, which can usefully serve as metadata
# but do not need to have any
# use the attributes() functions to list them
attributes(1:10)
attributes(heights)
attributes(heights_list)
attributes(list_vec)

# we see that the heights objects has a "names" attribute
# we access the attribute with the attr() function
?attr
attr(heights,"names")

# there is also a function names() that pulls out the names attribute
names(heights)

# we can also set arbitrary attributes
is.vector(heights)
attr(heights,"units") <- "centimeters"
is.vector(heights)
attributes(heights)
attr(heights,"date measured") <- "July 30, 2016"
attr(heights,"date measured") <- 7
attributes(heights)
heights_bak <- heights                     # make a backup so we can restore
attributes(heights) <- NULL
heights
heights <- heights_bak

# there is a function str() for printing out summaries of objects
str(heights)
str(heights_list)


# R has a special data structure called a factor, which has
# an attribute called levels
# factors hold categorical information

# initialize with factor() function
vec_fac <- factor(c(1,3,4),levels=c(1,2,3,4))
attributes(vec_fac)
is.atomic(vec_fac)
is.factor(vec_fac)
otherfac <- as.factor(c(1,3,4))         # coerce with as.factor
levels(otherfac)                        # check levels with levels()
levels(otherfac) <- c(1,2,3,4)          # also use to assign

# the above an instance of an assignment function
# note that the assignment lines do not quite fit the syntax
# that we've been using so far. We'll cover this more later


# R also has a notion for higher-dimensional objects
# matrices are two-dimensional objects
# initialize with the matrix() function
mat1 <- matrix(data = 1:6, nrow = 3, ncol = 2)  # same as matrix(1:6,3,2)
mat1
mat2 <- matrix(1:6,nrow=2,ncol=3)
mat2

# if the length of 'data' is less than the number of entries, 
# recycling of data is used
# useful for initializing with some default value
matrix(0,2,3)
matrix(1:2,2,3)
matrix(1:3,3,2)
matrix(1:3,2,3)
matrix(NA,3,3)
matrix("placeholder string",2,2)
# be careful with recycling. Recycling is done without 
# issuing a warning, so it can be a source of silent bugs

# we subset matrices with square brackets, specifying position in row,column
mat1[1,2]
mat1[,1]          # all entries of first column (coerced to vector)
mat1[2,]          # all entires of second row   (coerced to vector)
mat1[2,,drop=FALSE]   # to override vector coercion
mat1[3]           # can also do linear indexing

# matrices have a dim attribute
attributes(mat2)
attr(mat2,"dim") <- c(6,1)
mat2

# there is a special operator %*% for matrix multiplication
# this is very common source of errors, especially for 
# people migrating from matlab to R
mat1 %*% c(1,0)
mat1 %*% c(1,0,1)       # error because dimensions don't match up
mat1 * c(1,0)           # NOT MATRIX MULTIPLICATION! recycling of c(0,1) is used

# we can also take a transpose
mat1
t(mat1)

# and vectors can be coerced to matrices
t(t(1:4))           # coerces a vector object to a matrix object
as.matrix(1:4)


# there are also n-dimensional arrays. initialize with array()
?array
array(0,c(2,2,3))
arr1 <- array(1:12,c(2,2,3))
arr1[1,1,1]
arr1[6]


# a two-dimensional array IS A MATRIX, can do matrix multiplication 
identical( matrix(0,2,2), array(0,c(2,2)) )
array(1:4,c(2,2)) %*% c(1,1)



# lastly, we have the data frame object
# a data frame is sort of like a list, in that it consists
# of objects of different types. A data frame has the additional
# requirement that all objects must be atomic vectors of the same
# length. They differ from lists because they can be subset with two indices

# columns are given default names if no names are specified
data.frame( c("apples","oranges","pears","plums"), c(0.5,0.6,0.4,0.9)  )
fruit_data <- data.frame( fruit = c("apples","oranges","pears","plums"), price = c(0.5,0.6,0.4,0.9)  )
fruit_data


# subsetting can be done with the indices (as in a matrix)
fruit_data[3,1]           # see that characters are coerced to factors by default

# or by using the $ operator with the column names, 
# which returns the atomic vecotr, which in turn can be subset
fruit_data$fruit
fruit_data$fruit[3]
