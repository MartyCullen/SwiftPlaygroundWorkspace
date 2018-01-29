//: Playground - noun: a place where people can play

import UIKit

var array = ["one", "two", "three"]
array[1] = "toast"
print(array)

var emptyArray = [String]()
var anotherArray = [String](["Sue", "Alice"])           // Alternate syntax for creating an array
var oneMoreArray: Array<String> = Array()               // Array is a struct, so this works too
var newArray: Array<String> = Array(["Frank", "Jorge"]) // We can fill this way too
emptyArray = []                                         // Clearing out an array

// Arrays are actually structs
var aOne = ["Bob"]
var aTwo = aOne // Creates a new COPY of the array object
aTwo.append("Tony")
print(aOne)    // Still just Bob in the original

