//: Playground - noun: a place where people can play

import UIKit

// ------------------ Filter
// Use a FILTER on a collection to pare down te results using a closure
let answer = [true, false, true, false, false, false, false]
// Use the built in filter mechanism on collections by passing in a closure forhow to process
print(answer.filter { $0 == true }.count)
// And they can be chained
print(Array(1...100).filter { $0 % 2 == 0 }.filter { $0 < 50 })
// Or you could build your own
extension Array {
    func myFilter(_ logic: (Element) -> Bool) -> [Element] {  // Note that Element is the datatype in the array
        var result: [Element] = []
        for item in self {
            if logic(item) {
                result.append(item)
            }
        }
        return result
    }
}

// ------------------ Map
// Use a MAP on a collection to take an action on each element using a closure
print(Array(1...5).map { $0 * $0 })
// or you could build your own
extension Array {
    func myMap<U>(_ operation: (Element) -> U) -> [U] {
        var result = [U]()
        for item in self {
            result.append(operation(item))
        }
        return result
    }
}
// If you need to return a different type than then existing element type
func genericMap<T, U>(_ items: [T], _ operation: (T) -> U) -> [U] {
    var result = [U]()
    for item in items {
        result.append(operation(item))
    }
    return result
}

// ------------------ Flat Map
// Like map, but culls out NILs
print([1,2,3,4,5,nil, nil].flatMap { $0 })
print(["1", "two", "3"].flatMap { Int($0) })


// ------------------ Reduce
// Use a REDUCE on a collection when you want to calculate a value based on each of the elements, like Sum, Count, Min, etc
// The zero is the seed, and just means what number to start at
print(Array(1...10).reduce(0) { $0 + $1 })
print(Array(1...10).reduce(100) { $0 + $1 })
print(Array(1...10).reduce(0) { $0 - $1 })
print(Array(1...10).reduce(0) { max($0, $1) })
print(["Bob", "Bobby", "Lee"].reduce("Names:") { "\($0) " + $1 })
// Or build your own
extension Array {
    func reduce(_ seed: Element, operation:(Element, Element) -> Element) -> Element {
        var current = seed
        for item in self {
            current = operation(current, item)
        }
        return current
    }
}

// ------------------ Sorted
// Arrangea collection using the closure
print([3, 1, 5, 6, 2, 4].sorted { $1 > $0 })

// ------------------ forEach
// Run the closure for each element of the collection
print(["Error", "Created", "Crashed"].forEach { print($0) })

// ------------------ grouping
// Use a GROUPING on a collection to break it up into a dictionary created based on the closure passed in
let contacts = ["Julia", "Susan", "John", "Alice", "Alex", "", nil]
print(contacts)
let noNils = contacts.flatMap { $0 }
print(noNils)
let noBlanks = noNils.filter { !$0.isEmpty }
print(noBlanks)
let grouped = Dictionary(grouping: noBlanks, by: { $0.first! }) // OK with the BANG here because we swept the file of nil and blanks
print(grouped)


// ------------------ grouping
// Creates a new dictionary from the key-value pairs in the given sequence, using a combining closure to determine the value for any duplicate keys.
// I THINK what it is doing is returnint the first pair it finds with a unique key
// So the first pair that had an "a" fora key, had a value of 1
// and the first pair that had a value of "b", had a value of 7
// And it found no other unique keys

let duplicates = [("a", 1), ("b", 7), ("a", 3), ("b", 4)]
let myLetter = Dictionary(duplicates, uniquingKeysWith: { (letter, number) in letter })
myLetter // ["b": 7, "a": 1]

// ------------------ zip
// for-in-zip runs a loop that selects one element from each collection
// Looks like the ZIP part generates a sequence of tuples created by the 2 input collections
let words = ["one", "two", "three", "four"]
let numbers = 1...words.count

for (word, number) in zip(words, numbers) {
    print("\(word): \(number)")
}

// Use ZIP to create a dictionary from an array
let friends = ["Hoy", "Dan", "Huy"]
let friendsWithValue = Dictionary(uniqueKeysWithValues: zip(1..., friends)) // the numbers collection is limited by the friends size automagically


// ------------------ Filter and Map on Dictionaries
let dictionary = ["name": "Bob", "age": "15", "hairColor": "Black"]

let filtered = dictionary.filter {
    $0.key == "name"
}
print(filtered) // ["name": "Bob"]

let mapped = dictionary.mapValues { value in
    value.uppercased()
}
print(mapped) // ["name": "BOB", "age": "15", "hairColor": "BLACK"]








// For more see...
// https://github.com/typelift/Swiftz
// https://github.com/ReactiveX/RxSwift

