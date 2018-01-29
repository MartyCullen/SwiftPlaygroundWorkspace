//: Playground - noun: a place where people can play

import UIKit

// Unary
let x = !false

// Binary
let z = 1 + 2
let y = 5 % 2

// Ternary operator
let age = 16
age >= 18 ? print("You may enter") : print("No no") // "No no"

// nil coalescing
let newAge : Int? = nil
let safeAge = newAge ?? 18

// Custom Operator
enum GameAction {
    case Start
    case Pause
    case Stop
    case Restart(delay: Int)
}

func ==(lhs: GameAction, rhs: GameAction) -> Bool {
    switch (lhs, rhs) {
    case (.Start, .Start), (.Pause, .Pause), (.Stop, .Stop):
        return true
    case let (.Restart(lhsDelay), .Restart(rhsDelay)):
        return lhsDelay == rhsDelay
    default:
        return false
    }
}

GameAction.Start == GameAction.Stop
GameAction.Restart(delay: 6) == GameAction.Restart(delay: 10)
GameAction.Restart(delay: 6) == GameAction.Restart(delay: 6)

// If you get "operator implementation without matching operator declaration"
// https://stackoverflow.com/questions/35768889/implementing-and-operators-operator-implementation-without-matching-ope?rq=1
// you may need to add "infix operator _____"

// Swift has a set of predefined operators that perform different types of operations,
// such as arithmetic or logic. It also allows creating custom operators, either unary or binary.
// Define and implement a custom ^^ power operator with the following specifications:
// Takes two Ints as parameters
// Returns the first parameter raised to the power of the second
// Ignores potential overflow errors

infix operator ^^

func ^^(lhs: Int, rhs: Int) -> Int {
    let floatResult = pow(Decimal(lhs), rhs)
    let decimalResult = NSDecimalNumber(decimal: floatResult)
    
    return Int(truncating:decimalResult)
}


print(2^^2)

