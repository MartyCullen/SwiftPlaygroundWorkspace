//: Playground - noun: a place where people can play

import UIKit

func greet(_ person:String, on day:String) -> String {
    return "Hello \(person), today is \(day)."
}
// NOTE: underscore indicating NO label, and ON indicating label different from "day"
// Format: func yourFunction(externalParameterName localParameterName :Type, ....)
greet("John", on:"Wednesday")


// Can take multiple input params and return multiple values (result is a tuple)
func callStats(numbers: Int...) -> (min: Int, max: Int, sum: Int) {
    return (1, 2, 3)
}
let result = callStats(numbers: 7)
print("Minimum: \(result.min)")

// Can pass a function as a parameter (closures)
func greetAll(people: [String], process: (String, String) -> String){
    
}

//Argument labels for Params Pg179
//Variadic params pg181
//Params are CONSTANTS BY DEFAULT pg182

