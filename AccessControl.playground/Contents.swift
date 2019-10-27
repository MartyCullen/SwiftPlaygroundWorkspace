//: Playground - noun: a place where people can play

import UIKit

// Access Control from most restrictive to least
// Five Levels: private, fileprivate, internal, public, open

// --------------- private
// Can oly be used inside this type or it's extensions in this file
// Used in singleton pattern to protect from creating another instance
// Limiting the scope helps reduce compile time

// another example
class Game { // BEGIN SCOPE (for number)
    // Private is only accesiblie in its scope
    private var number = 0
    
    var score: Int {
        return number
    }
    
    func increaseNumberByOne() {
        number += 1
    }
} // END SCOPE (for number)

//Game().number // Error
Game().score // Good

// Swift prior to 4 did not let you have access to private within an extension
class MyStatus {
    private var isHappy = true
}

extension MyStatus {
    func checkStatus() {
        print(isHappy)  // Private property available to us in extension now
    }
}

// Private Setter (so you don't need to have the internal private variable
class Human {
    private(set) var name: String // this property can only be mutated in it's scope
    init(enterName: String) {
        name = enterName
    }
}

let bob = Human(enterName: "Bob Lee")
//bob.name = "Bobby" // Error because we can not directly change the private name


// ------------- fileprivate
// Indicates that the type/class (etc) is only visible inside the enclosing file
// even if it is outside the type


// ------------- internal
// The DEFAULT access for everything else is INTERNAL - - Available throughout the "module"
// (For example, UIKit, etc are seperate modules and need to be included"


// ------------- public
// Allows you to use it
// PROHIBITS overriding


// ------------- open
// Allows you to override it
// Allows you to subclass it
// UIViewController is an OPEN class
// ViewDidLoad is an OPEN func
// Marking a class as open explicitly indicates that you’ve considered the impact of code from other modules using that class as a superclass,
//   and that you’ve designed your class’s code accordingly.
