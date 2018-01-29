//: Playground - noun: a place where people can play

import UIKit

// ARC stuff  (Only an issue with reference types: Classes and Closures)
// STRONG is the default

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    // This must be WEAK or we will have a retain cycle because the objects reference each other
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

// ---------  Delegate pattern
protocol SendDataDelegate: class {}   // Note: must be based on CLASS (not useful for structs

class SendingVC {
    weak var delegate: SendDataDelegate? // Note: WEAK OPTIONAL to break retian cyle (circular reference)
    
    deinit { print("Delegator gone") }
}

class ReceivingVC: SendDataDelegate {
    lazy var sendingVC: SendingVC = {  // Note: Using lazy here so child VC only created when referenced
        let vc = SendingVC()
        vc.delegate = self
        return vc
    }()
    
    deinit { print("Delegate gone") }
}

// ---------  Closure referencing SELF
// Try this without WEAK, and neither VC is freed because they referenceeach other
var receivingVC: ReceivingVC? = ReceivingVC()
receivingVC?.sendingVC
receivingVC = nil

class ClosureClass {
    var aClosure: (() -> ())?
    var name: String = "Me"
    
    init() {
        // This is a memory leak, reference to self makes a circular reference (Compiler/IDE will not warn you)
        //aClosure = { print("\(self.name) says Hello") }
        // So we can use an UNOWNED but this is like self! and may cause error if deallocated
        //aClosure = { [unowned self] in print("\(self.name) says Hello") }
        // So we fix it by using a capture list and making self OPTIONAL
        aClosure = { [weak self] in print("\(self?.name) says Hello") }
    }
    
    deinit { print("ClosureClass gone") }
}

var closureClass: ClosureClass? = ClosureClass()
closureClass?.aClosure!()

closureClass = nil

// ---------  UNOWNED Example
// UNOWNED should be used to break a reference cycle when you can guarantee that the
// other instance has the same lifetime or a longer lifetime.    USE AT YOUR OWN PERIL
class Owner {
    var creditCard: CreditCard?
    deinit { print("Owner gone") }
}

class CreditCard {
    unowned let owner: Owner
    
    init(enterOwner: Owner) {
        owner = enterOwner
    }
    
    deinit { print("Card gone") }
}

var bob: Owner? = Owner()
var myCard = CreditCard(enterOwner: bob!)
bob?.creditCard = myCard

bob = nil
//myCard.owner  //CRASH

