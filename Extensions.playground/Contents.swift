//: Playground - noun: a place where people can play

import UIKit

// We can even extend an integer
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

extension Int: ExampleProtocol {
    // We cant do "cuteName" because you can not add properties that require storage of new information (no stored properties)
    // You can only work with the info that is already there
    //var cuteName: String = "Integers are a way to store numbers without a decimal"
    
    // But we can add some functionality...
    var simpleDescription: String {
        return "The number \(self)"
    }
    var squared: Int {
        return self * self
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)
print(4.squared)

struct Bob {
    var name = "Bob"
    var skill = "Work"
    
    init() {}
}

extension Bob {
    // A computed property
    var description: String {
        let myName = self.name
        let mySkill = self.skill // object.name
        return "I'm \(myName), I know \(mySkill)"
    }
    
    // An alternate initializer
    init(enterSkill: String) {
        self.skill = enterSkill
        print("You've entered a new skill")
    }
    
    // A subscript for easy access of the skill
    subscript(mySkill: String) -> String {
        return "\(mySkill) is your secret weapon"
    }
}

let sneaky = Bob(enterSkill:"Ninja")
print(sneaky)
print(sneaky["Poker"])

