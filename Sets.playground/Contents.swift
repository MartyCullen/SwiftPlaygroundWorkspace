//: Playground - noun: a place where people can play

import UIKit

// Arrays are actually structs too

var setOne: Set = [1, 2, 4, 7, 9, 2, 2, 2, 2]  // Note that swift cant figure out that this is not an array so you must give it the type SET (But element type IS INFERRED)
print(setOne)                                  // Duplicates are not permitted in a set (so the number 2 only appears ONCE)
var setTwo: Set<String> = ["Marley", "Newhart", "Hope"]
var setThree = Set<String>()
var setFour = Set([1.5, 5.0, 0.111])

setTwo.insert("Saget")
setTwo.contains("Hope") // true
setTwo.remove("Saget")

let arrayOfNumbers = [1, 4, 6, 77, 1, 1, 1]
let setOfNumbers = Set(arrayOfNumbers)  // Conversion array -> set
let sortedArray = setOfNumbers.sorted() // Conversion set -> array

var oddNumberSet: Set = [1, 3, 5, 7, 9]
let evenNumberSet: Set = [0, 2, 4, 6, 7, 9]

oddNumberSet.union(evenNumberSet)                // union is an adjective          NonMutating
oddNumberSet.symmetricDifference(evenNumberSet)  // ...difference is an adjective  NonMutating
oddNumberSet.intersection(evenNumberSet)         // intersection is an adjective   NonMutating
oddNumberSet.subtract(evenNumberSet)             // SUBTRACT IS A VERB             MUTATING

//*** Swift naming guide - - use verbs for mutating methods and adjectives/nouns otherwise
// https://swift.org/documentation/api-design-guidelines/       // Name Mutating/nonmutating method pairs
//     Mutating           Nonmutating
//     Verb               Verb with -ing or -ed
//     x.sort()           z = x.sorted()
//     x.append(y)        z = x.appending(y)
//
//     NonMutating        Mutating
//     Noun               prefix with form-
//     x = y.union(z)     y.formUnion(z)
//     j = c.successor    c.formSuccessor(&i)

