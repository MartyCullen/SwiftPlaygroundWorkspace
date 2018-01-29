//: Playground - noun: a place where people can play

import UIKit

// SWITCH stuff (pg7/146)
let veg = "red pepper"
switch veg {
case "celery":
    print("Ewww")
case "cuke":
    print("ughhh")
case let x where x.hasSuffix("pepper"):
    print("spicy")
default:
    print("other")
}
// NO BREAK REQUIRED
//No implicit fall through but can use explicit fallthrough

