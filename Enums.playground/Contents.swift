//: Playground - noun: a place where people can play

import UIKit

// Enums get much of their behavior from STRUCTs

// Can you define an enumeration with raw values like this? Why?
// enum Edges : (Double, Double) {
//    case TopLeft = (0.0, 0.0)
//    case TopRight = (1.0, 0.0)
//    case BottomLeft = (0.0, 1.0)
//    case BottomRight = (1.0, 1.0)
// }
// No, you cannot. A raw value type must:
//   - Conform to the Equatable protocol
//   - Be literal convertible from any of the following types:
//          Int, String, Character
//

// Also, Enums can not have a rawValue AND and Associated Type

public enum Rank: Int {
    case ace = 1  // set the initial value to ONE instead of the default of ZERO
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.ace
let aceRawValue = ace.rawValue // use rawValue to access the underlying value of the enum
let ten = Rank(rawValue: 10)  // Create an enum using it's raw value (Result is an OPTIONAL)

public enum Suit: Int {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .clubs:
            return "clubs"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        }
    }
    
    func color() -> String{
        switch self {
        case .spades:
            return "black"
        case .clubs:
            return "black"
        case .hearts:
            return "red"
        case .diamonds:
            return "red"
        }
    }
}

let hearts = Suit.hearts
let heartsDesc = hearts.simpleDescription()
let heartsColor = hearts.color()

// -------------- Extension
extension Suit {
    init() {
        self = Suit.init(rawValue: Int(arc4random_uniform(4)))!  // I used BANG because I should always get (0-3) and that should always be a valid suit
    }
}
let aSuit = Suit()
let bSuit = Suit()
let cSuit = Suit()


// -------------- Associated Value
// Enums with Associated Type can not have a rawValue
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qr(String)
}

var myQRCode = Barcode.qr("https://google.com")
var myUPCCode = Barcode.upc(2, 76529, 94534, 9)
if case let Barcode.qr(value) = myQRCode {
    print("This is a QR Code with value \(value)")
}
if case let Barcode.upc(numberSystem, manufacturer, product, check) = myUPCCode {
    print("We got a UPC Code")
    print("  numbersystem:", numberSystem)
    print("  manufaturer:",manufacturer)
    print("  product:",product)
    print("  check:",check)
}

// CASE is prefereable to the IFs above (notice we only neded ONE let)
switch myQRCode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qr(productCode):
    print("QR code: \(productCode).")
}

// -------------- MUTATING
enum MealProcess: String {
    case breakfast, lunch , dinner
    
    var description: String {
        return self.rawValue
    }
    
    // NOTE: the MUTATING prefix
    mutating func nextMeal() {
        print("Time to move on from \(self.description)")
        
        switch self {
        case .breakfast:
            self = .lunch
        case .lunch:
            self = .dinner
        case .dinner:
            self = .breakfast
        }
        
        print("I had a nice \(self.description)")
    }
}

var currentMeal = MealProcess.breakfast
currentMeal.nextMeal()
currentMeal.nextMeal()

// -------------- Failable Init (optional) & Static Func
enum AppleDevices: String {
    case iWatch, iPhone, iMac, MacPro
    
    init?(name: String) {
        if name == "iWatch" {
            self = .iWatch
        } else {
            return nil
        }
    }
    
    static func getProduct(name: String) -> AppleDevices? {
        return AppleDevices(rawValue: name)
    }
    
}

// -------------- Nested
enum Wearable {
    enum WearableType: Int {
        case headgear
        case armor
        case footwear
    }
    enum Weight: Int {
        case light
        case medium
        case heavy
    }
    enum Material: Int {
        case cloth
        case leather
        case iron
        case steel
    }
    
    case item(name: String, type: WearableType, weight: Weight, material: Material)
    
    
    func getDescription() -> String {
        switch self {
        case let .item(name, type, weight, material) :
            return "You have a \(name) as \(type) made of \(weight) \(material)"
        }
    }
}

let myArmor = Wearable.item(name: "Plate Mail", type: .armor, weight: .heavy, material: .steel)
let myFootwear = Wearable.item(name: "Hat", type: .headgear, weight: .light, material: .cloth)
print(myArmor.getDescription())
print(myFootwear.getDescription())

// -------------- Conform to PROTOCOLS
protocol LifeSpan {
    var numberOfHearts: Int { get }
    mutating func increaseHeart(by: Int) // heart +1
    mutating func getAttacked(damage: Int) // heart -1
}

enum Player: LifeSpan {
    case dead
    case alive(currentHeart: Int)
    
    var numberOfHearts: Int {
        switch self {
        case .dead: return 0
        case let .alive(numberOfHearts): return numberOfHearts
        }
    }
    
    mutating func increaseHeart(by: Int) {
        switch self {
        case .dead:
            self = .alive(currentHeart: by)
        case let .alive(numberOfHearts):
            self = .alive(currentHeart: numberOfHearts + by)
        }
    }
    
    mutating func getAttacked(damage: Int) {
        switch self {
        case .alive(let numberOfHearts):
            let newHealth = numberOfHearts - damage
            if newHealth <= 0 {
                self = .dead
            } else {
                self = .alive(currentHeart: newHealth)
            }
        case .dead:
            break
        }
    }
}

var state = Player.dead // .dead
state.increaseHeart(by: 3)  // 1
state.numberOfHearts // 3
state.getAttacked(damage: 2)  // 1
state.getAttacked(damage: 1) // 0, .dead
state.numberOfHearts // 0

// -------------- Custom Operators
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

// ------------- Indirect / Recursion
indirect enum ArithmeticExpressions {
    case number(Int)
    case addition(ArithmeticExpressions, ArithmeticExpressions)
    case multiplication(ArithmeticExpressions, ArithmeticExpressions)
}

func evaluate(_ expression: ArithmeticExpressions) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

let thingy = ArithmeticExpressions.addition(.number(7), .multiplication(.number(3), .number(2)))
evaluate(thingy)

// ------------- Generic Enums
enum Information<T, U> {
    case name(T)
    case website(T)
    case age(U)
}

// Information.name("Bob")  // Can not infer what TYPE is used for U
Information<String, Int>.name("Bob")

// ------------- Error Handling with Enums (insted of throws and do-try)
enum HTTPError {
    case notFound404
    case forbidden403
}

enum ResultType<T> {
    case success(T)
    case failure(HTTPError)
}


let success = ResultType.success("JSON, Image")
let failure: ResultType<Any> = ResultType.failure(.notFound404)

func findSubDomain(subdomain: String) -> ResultType<String> {
    // Switch Statement
    switch subdomain {
    case "business":
        return ResultType.failure(.forbidden403)
    case "data":
        return ResultType.success("Found data")
    default:
        return ResultType.failure(.notFound404)
    }
}

let result = findSubDomain(subdomain: "data")
switch result {
case let .success(subDomainName):
    print(subDomainName)
case let .failure(errorType):
    switch errorType {
    case .notFound404:
        print("Not Found: 404")
    case .forbidden403:
        print("Not Allowed: 403")
    }
}
