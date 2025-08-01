# Test Script for Matrix Caching Functions
# This script demonstrates and tests the makeCacheMatrix and cacheSolve functions

# Source the functions (assuming they're in cachematrix.R)
# source("cachematrix.R")

# Test 1: Basic functionality with a 2x2 matrix
cat("=== Test 1: Basic 2x2 Matrix ===\n")
test_matrix1 <- matrix(c(2, 1, 5, 3), 2, 2)
print("Original matrix:")
print(test_matrix1)

# Create cached matrix object
cached_matrix1 <- makeCacheMatrix(test_matrix1)

# First call to cacheSolve - should compute inverse
cat("\nFirst call to cacheSolve (should compute):\n")
inverse1 <- cacheSolve(cached_matrix1)
print(inverse1)

# Second call to cacheSolve - should retrieve from cache
cat("\nSecond call to cacheSolve (should use cache):\n")
inverse2 <- cacheSolve(cached_matrix1)
print(inverse2)

# Verify the inverse is correct
cat("\nVerification (should be identity matrix):\n")
verification1 <- test_matrix1 %*% inverse1
print(round(verification1, 10))

cat("\n" , rep("=", 50), "\n")

# Test 2: Testing with a 3x3 matrix
cat("=== Test 2: 3x3 Matrix ===\n")
test_matrix2 <- matrix(c(1, 0, 5, 2, 1, 6, 3, 4, 0), 3, 3)
print("Original matrix:")
print(test_matrix2)

cached_matrix2 <- makeCacheMatrix(test_matrix2)

cat("\nFirst call (should compute):\n")
inverse3 <- cacheSolve(cached_matrix2)
print(inverse3)

cat("\nSecond call (should use cache):\n")
inverse4 <- cacheSolve(cached_matrix2)

# Verify
cat("\nVerification (should be identity matrix):\n")
verification2 <- test_matrix2 %*% inverse3
print(round(verification2, 10))

cat("\n" , rep("=", 50), "\n")

# Test 3: Testing the set function (changing the matrix)
cat("=== Test 3: Changing Matrix with set() ===\n")
cached_matrix3 <- makeCacheMatrix(matrix(c(1, 2, 3, 4), 2, 2))

# Get first inverse
cat("First matrix inverse:\n")
first_inverse <- cacheSolve(cached_matrix3)
print(first_inverse)

# Change the matrix using set()
cat("\nChanging matrix using set() function...\n")
new_matrix <- matrix(c(4, 3, 3, 2), 2, 2)
cached_matrix3$set(new_matrix)
print("New matrix:")
print(cached_matrix3$get())

# Get inverse of new matrix (should compute, not use old cache)
cat("\nGetting inverse of new matrix (should compute, not cache):\n")
new_inverse <- cacheSolve(cached_matrix3)
print(new_inverse)

# Second call should now use cache for the new matrix
cat("\nSecond call for new matrix (should use cache):\n")
cached_new_inverse <- cacheSolve(cached_matrix3)

cat("\n" , rep("=", 50), "\n")

# Test 4: Performance demonstration
cat("=== Test 4: Performance Demonstration ===\n")
# Create a larger matrix for performance testing
large_matrix <- matrix(rnorm(100*100), 100, 100)
# Make it more likely to be invertible
large_matrix <- large_matrix + diag(100) * 10

cached_large <- makeCacheMatrix(large_matrix)

cat("Computing inverse of 100x100 matrix...\n")
start_time <- Sys.time()
inv_large1 <- cacheSolve(cached_large)
end_time <- Sys.time()
cat("Time for first computation:", end_time - start_time, "\n")

cat("Retrieving cached inverse...\n")
start_time <- Sys.time()
inv_large2 <- cacheSolve(cached_large)
end_time <- Sys.time()
cat("Time for cached retrieval:", end_time - start_time, "\n")

cat("\nAll tests completed successfully!\n")