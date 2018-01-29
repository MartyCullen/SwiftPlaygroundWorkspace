//: Playground - noun: a place where people can play

import UIKit

//*** Structs pass by value and classes pass by reference

class Shape {
    var numberOfSides = 0
    var name: String
    
    static var triangleSides = 3
    static var computedProperty: Int {
        get {
            return 120
        }
        set {
            print("You have called the setter with \(newValue) but this always returns 120")
        }
    }
    
    //*** NO-TYPE is an overridable instance method
    func simpleDescription(color:String) -> String {
        return "A \(color) shape with \(numberOfSides) sides"
    }
    
    //*** FINAL is a non-overridable instance method
    final func cantOverride() {
        print("You cant Change Me")
    }
    
    //*** STATIC is a non-overridable class method
    static func hello() {
        print("Hello")
    }
    
    //*** CLASS is an overridable class method
    class func goodbye() {
        print("Bye Bye")
    }
    
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "Not Specified")
    }
    deinit{
        // instead of dealloc
    }
}

// Statics do not require an instantiated object
print(Shape.computedProperty)
Shape.computedProperty = 50
Shape.hello()
Shape.triangleSides
Shape.triangleSides = 7
Shape.triangleSides

var shape = Shape(name:"Septagon")
var convenient = Shape()
shape.numberOfSides = 7
print(shape.simpleDescription(color: "Blue"))
shape.cantOverride()

class Square: Shape {
    override func simpleDescription(color:String) -> String {
        return "A \(color) shape with FOUR sides"
    }
    override class func goodbye() {
        print("Farewell")
    }
    
    //    You can not override FINAL functions like you can with normal NO-TYPE functions
    //    override final func cantOverride() {
    //        print("Cant do this")
    //    }
    
    //    You can not override STATIC functions like you can with CLASS functions
    //    override static func hello() {
    //        print("Welcome")
    //    }
    
}


var square = Square(name:"Septagon")
print(square.simpleDescription(color: "Red"))
Square.hello()

// Failable Init
class Blog {
    let name: String
    // Note the ? indicating that we can get a nil on creation failure - (returns an optional)
    init?(name: String) {
        if name.isEmpty {
            // handle error
            return nil
        }
        self.name = name
    }
}

// Lazy Proerties pg237
class DataImporter{
    /*
     DataImporter is a class to import data from an external file.
     The class is assumed to take a non-trivial amount of time to initialize.
     */
    var fileName = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property has not yet been created
print(manager.importer.fileName)
// The DataImporter instance for the importer property has now been created




// Computed Properties pg240
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        //        set(newCenter) {
        //            origin.x = newCenter.x - (size.width / 2)
        //            origin.y = newCenter.y - (size.height / 2)
        //        }
        set {                                                      // Note this shorthand change
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
        // If setter is not present, it is a READ ONLY computed property
        
    }
}
var square2 = Rect(origin: Point(x: 0.0, y: 0.0),
                   size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square2.center
square2.center = Point(x: 15.0, y: 15.0)
print("square2.origin is now at (\(square2.origin.x), \(square2.origin.y))")
// Prints "square2.origin is now at (10.0, 10.0)

// Property Observers
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps”



// isKindOfClass is now just "is"
if (stepCounter is StepCounter){
    print("YUP")
}

// --------------CASTING -----------------
// A UILabel IS A UIView so this is UPCASTING and always works
let label = UILabel() as UIView

// Upcast as common type to add disparate types into a colllection
var name = "Bob" as Any
var number = 20 as Any
var anyArray = [name, number]

// downcast using as? (or as! NOT RECOMMENDED) and return an optional
if let element = anyArray[1] as? String {
    print(element)
}

// ACCESS CONTROL pg476

