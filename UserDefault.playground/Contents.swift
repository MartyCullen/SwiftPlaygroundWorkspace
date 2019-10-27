//: Playground - noun: a place where people can play

import UIKit

let preference = UserDefaults.standard
let key = "Welcome_string"

preference.set("Hello Playground", forKey: key)

preference.value(forKey: key)
preference.string(forKey: key) ?? "No Name"
