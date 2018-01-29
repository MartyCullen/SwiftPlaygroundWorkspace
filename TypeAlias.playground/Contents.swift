//: Playground - noun: a place where people can play

import UIKit

typealias AudioSample = UInt16
let microphone = AudioSample.min

// good for defining your tuple types
typealias GridPoint = (Int, Int)
func enterPoint(grid: GridPoint) {
    print("You've entered, \(grid.0) and \(grid.1)")
}
enterPoint(grid: (4, 2))
