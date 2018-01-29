//: Playground - noun: a place where people can play

import UIKit

// Functions are a kind of closure called "Global Closures"
var numbers = [20, 19, 7, 12]
let mappedNumbers = numbers.map({
    (number: Int) -> Int in
    let result = 3*number
    return result
})
print(mappedNumbers)

let sortedNumbers2 = numbers.sorted{ $0 > $1 }
print(sortedNumbers2)

//*** Closure Format { (paramaters) -> returnType in statements }
//*** let closure: () -> () = { () in print("standard \(c)") }
//*** func usesClosure(num: Int, closure: (() -> ()){ }

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
// let reverseNames = names.sorted(by: closure)                                         // We want something like this
// let reverseNames = names.sorted(by: { (paramaters) -> returnType in statements })    // Which expands to this
// We want a comparator that takes 2 strings and returns a boolean indicating comparison result
let reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in              // and looks like this when filled in
    return s1 > s2
})


//If you are a jackass and want the least number of characters in your code you can take a statement that makes sense and make it harder to read as shown
// Define the method signature of our closure
var combine: (String, String) -> String

// Define the closure in a simple clear way
combine = {
    a, b -> String in
    return a + b
}
combine("Hello", "World")

// Then you can put the heading and body on one line and remove the RETURN key word
combine = {
    a,b -> String in a + b
}
combine("This ", "That")

// Why not remove the result type since it can be inferred and put the whole thing on one line
combine = { a,b in a + b }
combine("Some ", "More")

// Why even have variable names (use $vars so no parameter block, so no IN required)
combine = { $0 + $1 }
combine("Absolutely ", "Ridiculous")


// Another demonstration of Jackassery
let animals = ["fish", "cat", "chicken", "dog"]
var sortedAnimals = animals.sorted { (one: String, two: String) -> Bool in
    return one < two
}
sortedAnimals = animals.sorted { (one, two) -> Bool in return one < two }
sortedAnimals = animals.sorted { (one, two) in return one < two }
sortedAnimals = animals.sorted { return $0 < $1 }
sortedAnimals = animals.sorted { $0 < $1 }
sortedAnimals = animals.sorted() // This only works for srings because of func <(lhs: String, rhs: String) -> Bool

// -------------  @ESCAPING
// If a closure is passed as an argument to a function and it is invoked after the function returns, the closure is escaping.
// This is true for most of the cases where I pass a closure into a method (and have an asynchronous event handler)
// Swift 3 changed to make non-escaping default, so we must declare ours as escaping
// Because non-escaping is default, optimizations can be done and you dont need a weak copy of self
// We expect that completion handler to be executed after completion of the function
import HealthKit

class HealthKitManager: NSObject {
    
    private let healthStore = HKHealthStore()
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        var shareTypes = Set<HKSampleType>()
        var readTypes = Set<HKSampleType>()
        
        // Add Workout Type
        shareTypes.insert(HKSampleType.workoutType())
        readTypes.insert(HKSampleType.workoutType())
        
        // Request Authorization (This might take a while...)
        healthStore.requestAuthorization(toShare: shareTypes, read: readTypes, completion: completion)
    }
}

// -------------  Escaping Example: Closure stored for later execution
var closureBlocks: [() -> Void] = []
// This method is going to take a closure as input
// That closure will be added to the array
// But the closure will NOT be EXECUTED until some time in the future, so it is ESCAPING
//func funcWithClosure(closure: () -> Void) {
//    closureBlocks.append(closure)
//}
// So we need to add the @escaping keyword
func funcWithClosure(closure: @escaping () -> Void) {
    closureBlocks.append(closure)
}

// -------------  Escaping Example: Closure executed on another thread
// This method takes a closure as input
// That closure is being put into a global asynchronous queue
// This is outside the scope of the function, so it is ESCAPING
//func funcWithNetworkingClosure(closure: () -> Void) {
//    DispatchQueue.global().async {
//        closure() // Ex) downloading
//    }
//}
// So we need to add the @escaping keyword
func funcWithNetworkingClosure(closure: @escaping () -> Void) {
    DispatchQueue.global().async {
        closure() // Ex) downloading
    }
}

// -----------   Capture list
// Closures are a REFERENCE type (as opposed to a VALUE type)
// By default a closure will use tha value of a variable found at execution time
// you can change this by "capturing" the values
// in this case using the [c]
var c = 0

let standardClosure: () -> () = { () in
    print("standard \(c)")
}

let capturedClosure: () -> () = { [c] in
    print("captured \(c)")
}

standardClosure()
capturedClosure()
c = 7
standardClosure()
capturedClosure()

// you can also rename the captured variable
let anotherCapturedClosure: () -> () = { [captured = c] in
    print("captured \(captured)")
}

// -------------  Traiiling Closures
// Can be used if there is a SINGLE closure block at the END

// We have a function that takes and int and a closure (closure has no input or output)
func trailingClosure(number: Int, closure: () -> Void) {
    print("You've entered \(number)")
    closure()
}

// a sample function with a method signature matching the closure required above
func helloFunc() -> Void {
    print("Hello, Function!")
}

// a sample closure with a method signature matching the closure required above
let helloClosure = {
    print("Hello, Closure!")
}

// Passing the func/closure INDIRECTLY (func/closure defined previously)
trailingClosure(number: 100, closure: helloFunc)
trailingClosure(number: 100, closure: helloClosure)

// Passing the func/closure DIRECTLY (func/closure defined in-line)
trailingClosure(number: 100, closure: { print("Hello!!!") })
trailingClosure(number: 100) { print("Hello!!!!!") }  // This is the trailing closure - - NOTE: look at the closing peren and removal of "closure:"

// -------------  AUTO Closures
func checkIDCard(hasCard: () -> Bool) {
    if hasCard() {
        print("You've an ID")
    }
}

// Imagine the expensiveClosure closure is very expensive in time &/or resources
let expensiveClosure: () -> Bool = { true }

// We can simplyfy the calling of this method, but it still looks "odd", what if it just looked like a function
checkIDCard(hasCard: { return expensiveClosure()})
checkIDCard(hasCard: { expensiveClosure() })
checkIDCard { expensiveClosure() }

// We can rewrite our call with AUTOCLOSURE
func checkIDCard(hasCard: @autoclosure () -> Bool) {
    if hasCard() {
        print("You've an ID")
    }
}

// And the invocation looks clean and familiar
// Even more important, the execution of the closure is only executed when needed
checkIDCard(hasCard: expensiveClosure)

// An escaping autoclosure is indicated by @autoclosure(escaping)

// we use @autoclosure to avoid having to evaluate the default value every time this method is called.
// If they just put a value in there it works like a regular parameter
// If they did have an expensive operation in there, it will not be run if not needed
extension Dictionary where Value == Any {
    func value<T>(forKey key: Key, defaultValue: @autoclosure () -> T) -> T {
        guard let value = self[key] as? T else {
            return defaultValue()
        }
        
        return value
    }
}

// -------------  LAZY VAR Closures
// closures created as a lazy var are NON-ESCAPING, so can access self without creating a retain cycle
class BobGreet {
    var name = "Bob the Developer"
    
    lazy var greeting: String = {
        return "Hello, \(self.name)"
    }()
    
    deinit {
        print("I'm gone, bruh 🙆‍")}
}

var bobGreet: BobGreet? = BobGreet()
bobGreet?.greeting
bobGreet = nil

