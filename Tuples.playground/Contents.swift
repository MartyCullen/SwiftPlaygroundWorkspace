//: Playground - noun: a place where people can play

import UIKit

// Create
let http404Error = (404, "Not Found") // without element names
let http200Status = (statusCode:200, description: "OK")
// Access
print(http404Error.0)
print(http200Status.description)

func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")

