//: Playground - noun: a place where people can play

import UIKit

// Guard is a way to clean up preconditions instead of nested IF conditions
func getUnit() -> String {
    let joe = Person(name: "Joe")
    guard let apt = joe.apartment else {
        return "Not Found"
    }
    
    return apt.unit
}

//=== is identical to
//!== is not identical

// We can init multiple variables and incorporate an evaluation using a where clause
if let firstNumber = Int("4"), let secondNumber = Int("42") , firstNumber < secondNumber {
    print("\(firstNumber) < \(secondNumber)")
}

// Use defer to define work that needs to be done HOWEVER you exit the method
func simpleDefer() {
    defer {
        print("This happens at end")
    }
    print("This happens First")
}
simpleDefer()

// Here is a more useful example http://nshipster.com/guard-and-defer/
// The DEALLOC must be done for ALL EXIT conditions, now you only have to write it ONCE
// And it is written IMMEDIATELY FOLLOWING the alloc, so you do not have to search for it
func allocMemory(){
    let dataSize = Int(NI_MAXHOST)
    let destData = UnsafeMutablePointer<Int8>.allocate(capacity: dataSize)
    defer {
        destData.deallocate()
    }
    
    if false {
        return
    }
    
    return
}

