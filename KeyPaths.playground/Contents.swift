//: Playground - noun: a place where people can play

import UIKit

// Keypaths added in Swift 4 to allow more dynamic access like we had in ObjC
// Key paths essentially let us reference any instance property as a separate value.
// As such, they can be passed around, used in expressions, and enable a piece of code
//   to get or set a property without actually knowing which exact property its working with.
// https://www.swiftbysundell.com/articles/the-power-of-key-paths-in-swift/

struct Developer {
    var platform: Platform
    var information: Information
}

enum Platform {
    case iOS
    case android
}

struct Information {
    var name, strengths, motivation: String
}

let robInformation = Information(name: "Rob", strengths: "Zenness", motivation: "Change the world")
let bobInformation = Information(name: "Bob", strengths: "Dryness", motivation: "None")

let rob = Developer(platform: .android, information: robInformation)
let bob = Developer(platform: .iOS, information: bobInformation)

rob.information.name // "Rob"
bob.information.name // "Bob"

// Direct use of keypath
let bobPlatform = bob[keyPath: \Developer.platform] // iOS
let bobName = bob[keyPath: \Developer.information.name] // 'Bob"

// can use a variable for theKeyPath
let informationKeyPath = \Developer.information
let bobInfo = bob[keyPath: informationKeyPath]
let robInfo = rob[keyPath: informationKeyPath]

// You can also build up the KeyPath
let nameKeyPath = informationKeyPath.appending(path: \.name)
bob[keyPath: nameKeyPath] // "Bob"
rob[keyPath: nameKeyPath] // "Rob"

