"""
[5SSD0] Julia programming assignment

The following are a series of exercises that 
"""

using Pkg
Pkg.activate(".")
Pkg.instantiate()

using LinearAlgebra
using Plots

"1.1 What is the type of an integer times a real-valued number?"

Q1_1 = #!TODO

"1.2 What is the type of the following variable"

a = "3"
Q1_2 = #!TODO

"2.1 Define a variable of type `Matrix`."

Q2_1 = #!TODO

"2.2 Calculate A times A transpose."

A = [3 2 1; 
     2 3 2; 
     1 2 3]
Q2_2 = #!TODO

"3. Broadcast the exponential function to each element in the following matrix."

B = [-1 -2 -3; 
      3  2  1]
Q3 = #!TODO

"4. Iterate over the elements of the following matrix and multiply them with their row and column index. Return the sum of these multiplications."

C = [1 2 3; 4 5 6]
Q4 = #!TODO

"5. Write a procedure to check if the given vector is sorted in increasing order."

e = [1 2 3 2]
Q5 = #!TODO

"6. Write a function `even()` that checks whether the given numbers are even (output argument should be of `BitMatrix` type)."

h = [1 2 3]
Q6 = #!TODO

"7.1 Create a scatterplot whose dots are size 10 and are green in colour"

U = randn(50,2)
Q7_1 = #!TODO

"7.2 Add a scatterplot whose dots are size 2."

V = randn(50,2)
Q7_2 = #!TODO
