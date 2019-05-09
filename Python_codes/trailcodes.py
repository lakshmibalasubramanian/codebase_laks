#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jan 22 11:29:21 2019

@author: lakshmibalasubramanian
"""
#This is a hello world command
print("hello world")

#this is a function to add two numbers
def add(x,y):
    sum=x+y
    return sum

#This is to get the two inputs from the user as integer
x= int(input("Enter the first number:"))
y = int(input("Enter the second number:"))

#This is to do the summation of two number by calling above function
print("Summation of two numbers is: ", add(x,y))


#This is to initialise an array as integer [giving "i"]; Printing the length of the array
from array import array
int_arr = array("i", [2,5,7,9,12,34,45,65,75,20,14])
print("the array size is ",len(int_arr))


#This is a function to find a given number in an array (int_arr)
def find_number(num):
    if num in int_arr:
        print("YES")
    else:
        print("NO")
    
#Getting the number to check if it is present in the array list that already existing by using the above function "find_number"
num=int(input("Enter an number to check:"))
find_number(num)


#if num in int_arr:
 #   print("YES")
#else:
 #   print("No")
    

def inclusive_range(start,end):
    return range(start,end+1)

for i in inclusive_range(3,10):
    if i %2 ==0:
        print(i)

import numpy as np
A = np.array([[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15]])
print(A)

