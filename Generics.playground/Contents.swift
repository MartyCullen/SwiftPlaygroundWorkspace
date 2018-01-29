//: Playground - noun: a place where people can play

import UIKit

func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
makeArray(repeating: "knock", numberOfTimes:4)  // Implicitly defined
makeArray(repeating: 7, numberOfTimes:2)
//var intArray = makeArray<Int>(repeating: 2, numberOfTimes:3)  // Cannot Explicitly define type on a FUNCTION
// But you CAN on a STRUCT

struct GenericFam<T> {
    var members: [T] = []
    
    mutating func push(member: T) {
        members.append(member)
    }
}

//: Generic Initialization
// T Implicitly Defined
let myHappyFamily = GenericFam(members: [1, 2, 3, 4, 5])

// T Explicitly Defined
var genericFamily = GenericFam<Int>()
genericFamily.push(member: 10)
print(genericFamily)

//: Generic Extension
extension GenericFam {
    var firstElement: T? {
        if members.isEmpty {
            return nil
        } else {
            return members[0]
        }
    }
}

myHappyFamily.firstElement
let mySadFamily = GenericFam(members: [])
mySadFamily.firstElement

//: Type Constraint

class LOL {}
class BabyLol: LOL {}
let example = LOL()

func addLOLClassOnly<T: LOL>(array: [T]) { }
addLOLClassOnly(array: [example, example])
addLOLClassOnly(array: [BabyLol(), BabyLol()])

// Using type constraints for CLASSES seems like someone being clever and makes the code HARDER to read than this:
func addLOLClassOnly2(array: [LOL]) {}
addLOLClassOnly2(array: [example, example])
addLOLClassOnly2(array: [BabyLol(), BabyLol()])

// However using a type constraint to maintain compatibility with a PROTOCOL makes sense
// This function does not work because of the == not able to deal with any object
//func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}
// But if we provide a protocol (Equatable) it knows how to handle the == now
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

