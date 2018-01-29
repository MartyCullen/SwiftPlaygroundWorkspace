//: Playground - noun: a place where people can play

import UIKit

let const = "My Constant"
var str = "Hello, playground \(const)"
let str2 = String(format:"/user/%@", const)
print("My constant is = \(const) and my string is \(str2)")

var emptyString = ""  // or String() works just as well for empty string
if emptyString.isEmpty { // NOTE the .isEmpty method
    print("EmptyString")
}
emptyString += "Some text" // Easy concatenation
let count = emptyString.count // NOTE no longer need the "characters" before count

let this = "word"
let that = "word"
if this == that {
    print("same")
}

// Strings are actually structs
var sOne = "Bob"
var sTwo = sOne // Creates a new COPY of the string object
sTwo = "Tony"
print(sOne)    // Still Bob in the original

