//: Playground - noun: a place where people can play

import UIKit

// Only use this shortcut if it is obvious what the subscript will return for the class - can be improperly used and make code LESS readable

struct WeekDays {
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    subscript(index: Int) -> String {
        return days[index]
    }
}

let myDays = WeekDays()
myDays.days[3] // Normal Access
myDays[3]      // Subscript Access

// You can change the behavior of accessing dictionary elements
struct HealthInfo {
    var info = ["Height": 183, "Body Fat": 12.5, "Weight": 76]
    
    subscript(key: String) -> Double {
        if let newInfo = info[key] {   // Would be even better as a guard statement or ??
            return newInfo
        } else {
            return 0
        }
    }
}

let data = HealthInfo()
data.info["Height"]   // Without using the subscript we need to dig into the object (and it will be an optional
data["Weight"]        // Using the subscript is simpler and always returns a Double
data["NotInTheArray"] // Change what is returned for elements not in dictionary


// ------------ Generic Subscripts (Added in Swift 4)
struct JSON {
    private var storage: [String: Any]
    
    init(dictionary: [String: Any]) {
        self.storage = dictionary
    }
    
    subscript<T>(key: String) -> T? {
        return storage[key] as? T
    }
}


let republicOfKorea = JSON(dictionary: [
    "capital": "Seoul",
    "name": "Republic of Korea",
    "population": 50000000
    ])

let koreaCapital: String? = republicOfKorea["capital"]
let koreaName: String? = republicOfKorea["name"]
let koreaPopulation: Int? = republicOfKorea["population"]

