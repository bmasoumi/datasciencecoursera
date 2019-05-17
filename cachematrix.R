# A pair of functions that cache the inverse of a matrix
# Assumption: the provided matrix is always invertible
# You need matlib library to be able to use solve()
library(matlib)

# makeCacheMatrix() builds a set of functions and 
# returns the functions within a list to the parent environment.
# It creats a matrix object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
        I <- NULL
        set <- function(x){
                x <<- y
                I <<- NULL
        }
        get <- function() x
        setI <- function(inverse) I <<- inverse 
        getI <- function() I
        list(set = set, get = get, setI = setI, getI = getI)

}


# cacheSolve() attempts to retrieve an inverse matrix from the object passed in as the argument. 
# First, it calls the getI() function on the input object.
# If the result of !is.null(I) is FALSE, cacheSolve() gets the matrix from the input object, 
# calculates a solve(), uses the setI() function on the input object to set the inverse in the 
# input object, and then returns the inverse to the parent environment by printing 
# the I object.

cacheSolve <- function(x, ...) {
        I <- x$getI()
        if(!is.null(I)){
                message("getting cache data")
                return(I)
        }
        data <- x$get()
        I <- solve(data, ...)
        x$setI(I)
        I
}

# Test 1
A <- matrix( c(5, 1, 0,
               3,-1, 2,
               4, 0,-1), nrow=3, byrow=TRUE)
myA <- makeCacheMatrix(A)
cacheSolve(myA)
solve(A)
(cacheSolve(myA) == solve(A))
# > # Test 1
#         > A <- matrix( c(5, 1, 0,
#                          +                3,-1, 2,
#                          +                4, 0,-1), nrow=3, byrow=TRUE)
# > myA <- makeCacheMatrix(A)
# > cacheSolve(myA)
# [,1]    [,2]   [,3]
# [1,] 0.0625  0.0625  0.125
# [2,] 0.6875 -0.3125 -0.625
# [3,] 0.2500  0.2500 -0.500
# > solve(A)
# [,1]    [,2]   [,3]
# [1,] 0.0625  0.0625  0.125
# [2,] 0.6875 -0.3125 -0.625
# [3,] 0.2500  0.2500 -0.500
# > (cacheSolve(myA) == solve(A))
# getting cache data
# [,1] [,2] [,3]
# [1,] TRUE TRUE TRUE
# [2,] TRUE TRUE TRUE
# [3,] TRUE TRUE TRUE


# Test 2
B <- matrix(c(3,5,7,9),2,2)
myB <- makeCacheMatrix(B)
cacheSolve(myB)
(cacheSolve(myB) == solve(B))
> # Test 2
#         > B <- matrix(c(3,5,7,9),2,2)
# > myB <- makeCacheMatrix(B)
# > cacheSolve(myB)
# [,1]   [,2]
# [1,] -1.125  0.875
# [2,]  0.625 -0.375
# > (cacheSolve(myB) == solve(B))
# getting cache data
# [,1] [,2]
# [1,] TRUE TRUE
# [2,] TRUE TRUE




