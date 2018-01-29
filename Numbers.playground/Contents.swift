//: Playground - noun: a place where people can play

import UIKit

// NUMBER stuff (pg44)
// Int, Int8, Int16, Int32, Int64, UInt8...
// Doube, Float
let binary = 0b100001
let octal = 0o21
let hex = 0x1f

print("Max Int = \(Int.max)")

// Ints (and doubles, etc) are actually structs
var iOne = 7
var iTwo = iOne // Creates a new COPY of the Int object
iTwo = 100
print(iOne)    // Still 7 in the original

