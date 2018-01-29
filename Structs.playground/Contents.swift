//: Playground - noun: a place where people can play

import UIKit

//*** Structs pass by value and classes pass by reference
//*** Array and Dictionary are STRUCTS and pass by VALUE, so a COPY is passed
//*** Structs are 10k to 1M times faster than classes!
class HumanClass {
    var name: String
    init(name: String) {    // THIS CODE IS NEEDED IN THE CLASS (Would not be required for a struct)
        self.name = name
    }
}



// Swift will automatically create an init for you
struct HumanStruct {
    var name: String
    //    init(name: String) {    // THIS CODE IS NOT NEEDED IN THE STRUCT (Would be required for a class)
    //        self.name = name
    //    }
}

let humanClassObjectOne = HumanClass(name: "Bob")
let humanClassObjectTwo = humanClassObjectOne  // The two variables now point to the same shared memory space
humanClassObjectTwo.name = "Bobby"             // We are allowed to mutate a property on an immutable object
print(humanClassObjectOne.name) // Now ALSO Bobby

let humanStructObjectOne = HumanStruct(name: "Bob")
let humanStructObjectTwo = humanStructObjectOne   // TWO is now a COPY of ONE
// humanStructObjectTwo.name = "Bobby"            // Cant do this like we could with a class, it is IMMUTABLE becuase the STRUCT is
var humanStructObjectThree = humanStructObjectOne // THREE is also a COPY of ONE
humanStructObjectThree.name = "Bobby"
print(humanStructObjectOne.name)                  // Original is unmodified (still Bob)



struct Card {
    var rank: Rank
    var suit: Suit 
    
    //*** Structs do not have FINAL or CLASS types, only STATIC
    static var why = "Card games have been enjoyed for hundreds of years"  // This is a stored class property (info can be stored even though no instance has been created)
    static var computedProperty: Int {
        get {
            return 52
        }
        set {
            print("You have called the setter with \(newValue) but this always returns 52")
        }
    }
    
    static func hello() {
        print("Hello")
    }
    
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
    func fullDeck() -> [Card] {
        var result = [Card]()
        for rankNum in 1..<14  {
            for suitNum in 0..<4  {
                let cardRank = Rank(rawValue: rankNum)
                let cardSuit = Suit(rawValue: suitNum)
                
                let card = Card(rank: cardRank!, suit: cardSuit!) // need to unwrap the values here
                result.append(card)
            }
        }
        return result
    }
}

// Statics do not require an instantiated object
print(Card.computedProperty)
Card.computedProperty = 50
Card.hello()
Card.why
Card.why = "I DUNNO"
Card.why

let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDesc = threeOfSpades.simpleDescription()
var fullDeck = threeOfSpades.fullDeck()


// Most WTF use of an Enum I have ever seen - - how is this an ENUM????????
enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of Cheese")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
case let .failure(message):
    print("Failure... \(message)")
}

