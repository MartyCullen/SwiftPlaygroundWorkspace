//: Playground - noun: a place where people can play

import UIKit

var occupations = [
    "Bill": "Captain",
    "Tony": "Ensign"]

var emptyDictionary = [String: Float]()
emptyDictionary = [:]

var aDictionary: Dictionary<String, Int> = [
    "Angie": 4,
    "Fred": 2]

// Dictionaries are actually structs
var dOne = ["Bob":"Builder"]
var dTwo = dOne        // Creates a new COPY of the dictionary object
dTwo["Joe"] = "Farmer" // Add Joe to the copy
print(dOne)            // Still just Bob in the original


// Dictionarys can now have a default
// Previously accessing an element would return an OPTIONAL
var myInfo = ["name": "Bob Lee", "age": "14"]
let name = myInfo["name"] // Optional("Bob Lee")

// Bu specifying a default, you do not need to unwrap an optional
let myName = myInfo["name", default: "No Value"] // "Name"
let footSize = myInfo["footsize", default: "No Value"] // "No Value"
