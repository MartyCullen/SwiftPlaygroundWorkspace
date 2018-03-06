//: Playground - noun: a place where people can play

import UIKit

// OPTIONALS stuff (pg56)
// A "nullable" variable
var optionalString: String? = nil
//var nonOptionalString: String = nil
// Because it is OPTIONAL (specified by question mark) the nil is allowed
// The second line will not compile

var alternateOptional: Optional<String>  // Since it is a struct, we can use this format as well (No ? required)
var optional2: String? = .none
var optional3 = Optional.some(7)


var greeting: String
if let name = optionalString {
    greeting = "Hello, \(name)"
}
// if the optional value is NIL, conditional is FALSE, and conditional code is NOT run

let informationGreeting = "Hi \(optionalString ?? "Default String")"
// You can specify a default value for an optional variable  (Nil-Coalescing Operator)

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
let explicitlyTyped :Int? = convertedNumber  // Note the questionMark indicating that this is an optional

if convertedNumber != nil {
    // Note the BANG - this is forced unwrapping since we know it is NOT null
    print("We definitely have an integer: \(convertedNumber!)")
}

// This is optional binding and note that the BANG is not needed like it was above
// We are using a temp var to store the value if it is not nil
if let actualNumber = Int(possibleNumber) {
    print("\(possibleNumber) has an integer value of \(actualNumber)")
} else {
    print("\(possibleNumber) could not be converted to an integer")
}

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}
class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    // This must be WEAK or we will have a retain cycle because the objects reference each other
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

// Optional Chaining
// Our person object has a name but not an Apartment (because it is an optional property)
let john = Person(name: "John")

// This would fail because we promised to have a value and it is nil
// let unit = john.apartment!.unit
// so we use Optional Chaining...
if let unit = john.apartment?.unit {
    print("John's apartment is unit \(unit)")
} else {
    print("Unable to retrieve the unit number.")
}


// Implicitly unwrapped optionals can be used to tell the compiler you PROMISE to have a value (like after initialization
// Country.capitalCity is not known when declared, but will be populated 3 lines later, se we add the BANG for the compiler
// Because it is implicitly unwrapped, we do not need to use the BANG when assigning it to a non-optional
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name:capitalName, country:self)
    }
}

class City{
    let name: String
    unowned let country: Country
    init(name:String, country:Country){
        self.name = name
        self.country = country
    }
}

// Nil coalescing Operator
// If a is not nil, unwrap it and use it, otherwise use b
// (a??b)
// a != nil ? a! : b
let defaultColor = "red"
var userDefinedColor: String?
var colorToUse = userDefinedColor ?? defaultColor


// GUARD

// Note: WHERE is no longer valid on a GUARD

func divide(dividend: Double?, by divisor: Double?) -> Double? {
    if dividend == .none {  // Could be worse - nested IFs
        return .none
    }
    
    if divisor == .none {
        return .none
    }
    
    if divisor == 0 {
        return .none
    }
    
    return dividend! / divisor!   // YIKES !!!!!!!!!!!
}

func divide2(dividend: Double?, by divisor: Double?) -> Double? {
    
    guard let dividend = dividend else {
        return .none
    }
    
    guard let divisor = divisor else {
        return .none
    }
    
    guard divisor != 0 else {
        return .none
    }
    
    return dividend / divisor
}

func divide3(dividend: Double?, by divisor: Double?) -> Double? {
    
    guard let dividend = dividend, let divisor = divisor, divisor != 0 else {
        return nil
    }
    
    return dividend / divisor
}

let upper: Double? = 25.0
let lower: Double? = 0.0

let x = divide(dividend: upper, by: lower)
let y = divide2(dividend: upper, by: lower)
let z = divide3(dividend: upper, by: lower)



