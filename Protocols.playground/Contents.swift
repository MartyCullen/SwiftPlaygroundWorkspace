//: Playground - noun: a place where people can play

import UIKit

// Classes, Enums and Structs can adopt protocols
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

protocol ExtendedProtocol: ExampleProtocol {
    // You can inherit from another protocol
    var isCool: Bool {get}   // NOTE: this is GET ONLY because Extension may not contain stored properties
    func calculateStuff()
}

extension ExtendedProtocol {
    // Allows you to have a default implementation for a protocol
    var isCool: Bool {
        return true
    }
    func calculateStuff(){
        print("Put default calculation here")
    }
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = " A simple class"
    var anotherProperty: Int = 08970
    func adjust() {
        simpleDescription += "  Now adjusted"
    }
}
var a = SimpleClass()
a.adjust()
let aDesc = a.simpleDescription

struct SimpleStruct: ExampleProtocol {
    var simpleDescription: String = " A simple structure"
    var something: Double = 0.8970
    mutating func adjust() {
        simpleDescription += "  (adjusted)"
    }
}

class ExtendedClass: ExtendedProtocol {
    var simpleDescription: String = " An extended class"
    func adjust() {
        simpleDescription += "  for sure"
    }
    // Note that we did not NEED to implement ExtendedProtocol.calculateStuff because it is handled in the EXTENSION, but you can override if desired
}
var b = SimpleStruct()
b.adjust()
let bDesc = b.simpleDescription

// Collections can contain different objects that conform to the same protocol (even if one is a struct and the other a class)
let collection: [ExampleProtocol] = [a, b]
var element = collection[0]
element.adjust()
print(collection)

// ------------ Generic Protocols
// protocols can be used to meet Generic conditions
func describe<T:ExampleProtocol>(_ input:T){
    input.simpleDescription
}
print(describe(a))

protocol GenericProtocol {
    associatedtype myType
}

class SomeClass: GenericProtocol {
    typealias myType = String
}

struct SomeStruct: GenericProtocol {
    typealias myType = Int
}

extension GenericProtocol {
    static func introduce() {
        print("Hi, Im Bob")
    }
}

extension GenericProtocol where Self == SomeStruct {
    static func saySomething() {
        print("I'm some struct")
    }
}

protocol FamilyProtocol {
    associatedtype familyType
    var familyMembers: [familyType] {get set}
}

struct NumberFamily: FamilyProtocol {
    var familyMembers: [Int] = [1,2,3]
}

struct StringFamily: FamilyProtocol {
    var familyMembers: [String] = ["Dad"]
}

struct LeeFamily<T>: FamilyProtocol {
    var familyMembers: [T] = []  // familyType --> T
}

let family = LeeFamily(familyMembers: ["Bobby", "Bruce"])
// T has become a STRING
// familyType has also become STRING

// It is usually easiest to design your protocol with a concrete type and then convert it to a generic
// The actual object type MUST be determined implicitly or explicitly

// ------------------ Type Erasure
struct Folder {}
struct Cell {}

protocol Listable {
    associatedtype FileType
    func getFileType() -> String // What kind of objects are held in this container
}

class FolderCell: Listable {
    typealias FileType = Folder
    func getFileType() -> String {
        return "FolderCell with \(FileType.self) type" // Note: SELF on the right side gives you the name of the type of object
    }
}

class CollectionCell: Listable {
    typealias FileType = Cell
    func getFileType() -> String {
        return "CollectionCell with \(FileType.self) type"
    }
}

class ListCell: Listable {
    typealias FileType = Cell
    func getFileType() -> String {
        return "ListCell with \(FileType.self) type"
    }
}


print(FolderCell().getFileType())
print(CollectionCell().getFileType())
print(ListCell().getFileType())

//let cell: Listable = CollectionCell()
// Cant do this
//Error: Listable' can only be used as a generic constraint because it has Self or associated type requirements


// Type Erasure solves this...
// Type Erasing: Erase Abstract Type (associatetype, T) to Concrete Type (String, Int, File, Cell)
// http://chris.eidhof.nl/post/protocol-oriented-programming
// http://www.thedotpost.com/2016/01/rob-napier-beyond-crusty-real-world-protocols

class AnyListableCell<T>: Listable {
    typealias FileType = T
    
    private let _getFileType: () -> String
    
    init<U: Listable>(_ enterAnyCell: U) where U.FileType == T {
        // T defined based on U
        _getFileType = enterAnyCell.getFileType
    }
    
    func getFileType() -> String {
        return _getFileType()
    }
}

let collectionCell: AnyListableCell = AnyListableCell(CollectionCell())
let listCell: AnyListableCell = AnyListableCell(ListCell())

