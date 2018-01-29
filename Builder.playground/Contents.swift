//: Playground - noun: a place where people can play

import UIKit

// The builder pattern simplifies the creation of instances
// It unburdens the object of the initialization logic complexity
// It can defines the default values


// ------------------------------------------------------------------------------------------------------------------------------------------------------------
//     Without using the BUILDER pattern
// ------------------------------------------------------------------------------------------------------------------------------------------------------------


struct BurgerOld {
    var name: String
    var patties: Int
    var bacon: Bool
    var cheese: Bool
    var pickles: Bool
    var ketchup: Bool
    var mustard: Bool
    var lettuce: Bool
    var tomato: Bool
    
    // A Crap ton of parameters to init this thing
    init(name: String, patties: Int, bacon: Bool, cheese: Bool,
         pickles:Bool,ketchup: Bool,mustard: Bool,lettuce: Bool,
         tomato: Bool) {
        self.name = name
        self.patties = patties
        self.bacon = bacon
        self.cheese = cheese
        self.pickles = pickles
        self.ketchup = ketchup
        self.mustard = mustard
        self.lettuce = lettuce
        self.tomato = tomato
    }
}

// Create Hamburger
var hamburger = BurgerOld(name:  "Hamburger", patties: 1, bacon: false,
                          cheese:  false, pickles:  false, ketchup: false,
                          mustard: false, lettuce: false, tomato: false)
// Create Cheeseburger
var cheeseburger = BurgerOld(name:  "Cheeseburger", patties: 1 ,
                             bacon: false, cheese: false, pickles: false,
                             ketchup: false, mustard: false,
                             lettuce: false, tomato: false)


// ------------------------------------------------------------------------------------------------------------------------------------------------------------
//     One way to do this...
// ------------------------------------------------------------------------------------------------------------------------------------------------------------

protocol BurgerBuilder {
    var name: String { get }
    var patties: Int { get }
    var bacon: Bool { get }
    var cheese: Bool { get }
    var pickles: Bool { get }
    var ketchup: Bool { get }
    var mustard: Bool { get }
    var lettuce: Bool { get }
    var tomato: Bool { get }
}

extension BurgerBuilder {
    // Allows you to have a default implementation for a protocol
    // (Which allows us to comment out all the duplication below
    var patties: Int { return 1 }
    var bacon: Bool { return false }
    var cheese: Bool { return false }
    var pickles: Bool { return true }
    var ketchup: Bool { return true }
    var mustard: Bool { return true }
    var lettuce: Bool { return false }
    var tomato: Bool { return false }
}

struct HamburgerBuilder: BurgerBuilder {
    let name = "Burger"
//    let patties = 1
//    let bacon = false
//    let cheese = false
//    let pickles = true
//    let ketchup = true
//    let mustard = true
//    let lettuce = false
//    let tomato = false
}
struct CheeseBurgerBuilder: BurgerBuilder {
    let name = "CheeseBurger"
//    let patties = 1
//    let bacon = false
    let cheese = true
//    let pickles = true
//    let ketchup = true
//    let mustard = true
//    let lettuce = false
//    let tomato = false
}

struct Burger {
    var name: String
    var patties: Int
    var bacon: Bool
    var cheese: Bool
    var pickles: Bool
    var ketchup: Bool
    var mustard: Bool
    var lettuce: Bool
    var tomato: Bool
    init(builder: BurgerBuilder) {
        self.name = builder.name
        self.patties = builder.patties
        self.bacon = builder.bacon
        self.cheese = builder.cheese
        self.pickles = builder.pickles
        self.ketchup = builder.ketchup
        self.mustard = builder.mustard
        self.lettuce = builder.lettuce
        self.tomato = builder.tomato
    }
    func showBurger() {
        print("Name:\(name)")
        print("Patties: \(patties)")
        print("Bacon: \(bacon)")
        print("Cheese: \(cheese)")
        print("Pickles: \(pickles)")
        print("Ketchup: \(ketchup)")
        print("Mustard: \(mustard)")
        print("Lettuce: \(lettuce)")
        print("Tomato: \(tomato)")
    }
}

// Create Hamburger
// var aBurger = Burger() // You cannot create one without passing the builder
var myBurger = Burger(builder: HamburgerBuilder())
myBurger.showBurger()
// Create Cheeseburger with tomatoes
var myCheeseBurger = Burger(builder: CheeseBurgerBuilder())
// Lets hold the tomatoes
myCheeseBurger.tomato = false
myCheeseBurger.showBurger()


// ------------------------------------------------------------------------------------------------------------------------------------------------------------
//     Another way to do this...
//     Rather than having multiple builder types, we can have a single builder type that sets all the configurable options to a default value;
//     then we change the values as needed.
//     Useful when updating older code because it is easy to integrate it with preexisting code.
//     But you lose the protection of knowing the init logic only needed in the Builder because someone could init without using the builder
// ------------------------------------------------------------------------------------------------------------------------------------------------------------

struct BurgerBuilder2 {
    // Define the defaults
    var name = "Burger"
    var patties = 1
    var bacon = false
    var cheese = false
    var pickles = true
    var ketchup = true
    var mustard = true
    var lettuce = false
    var tomato = false
    // Allow modification of builder parameters
    mutating func setPatties(choice: Int) {self.patties = choice}
    mutating func setBacon(choice: Bool) {self.bacon = choice}
    mutating func setCheese(choice: Bool) {self.cheese = choice}
    mutating func setPickles(choice: Bool) {self.pickles = choice}
    mutating func setKetchup(choice: Bool) {self.ketchup = choice}
    mutating func setMustard(choice: Bool) {self.mustard = choice}
    mutating func setLettuce(choice: Bool) {self.lettuce = choice}
    mutating func setTomato(choice: Bool) {self.tomato = choice}
    // Generate a legacy instance
    func buildBurgerOld(name: String) -> BurgerOld {
        return BurgerOld(name: name, patties: self.patties,bacon: self.bacon,
                         cheese: self.cheese,pickles: self.pickles,
                         ketchup: self.ketchup,mustard: self.mustard,
                         lettuce: self.lettuce,tomato: self.tomato)
    }
    
}

var burgerBuilder2 = BurgerBuilder2()
burgerBuilder2.setCheese(choice: true)
burgerBuilder2.setBacon(choice: true)
var jonBurger = burgerBuilder2.buildBurgerOld(name: "Jon's Burger")

print("hi")

