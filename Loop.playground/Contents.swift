//: Playground - noun: a place where people can play

import UIKit

// Swift no longer supports the c-style for loop

var n=2
while n < 5 {
    n  += 1
    print(n)
}

var m = 0
repeat {
    m += 1
    print("Repeating")
} while m < 2

for i in 0...3 {
    print(i)
}

for i in 0..<4 {
    print(i)
}

