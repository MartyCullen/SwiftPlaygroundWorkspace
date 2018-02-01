//: Playground - noun: a place where people can play

import UIKit

// The AnyObject aliases can represent an instance of any class type, (any reference type?) (best used with Obj-C)
// while the Any aliases can represent an instance of the Any type.
//
// We should use the Any and AnyObject aliases only when there is an explicit need for this behavior.
// It is always better to be specific about the types of data our collections contain.

var myArray: [Any] = [1,"Two", true]

//var anyObjectArray: [AnyObject] = [1 , 2, "Hi", [1,2], ["X": 15]]
var anyObjectArray: [AnyObject] = [1 as AnyObject, 2 as AnyObject, "Hi" as AnyObject, [1,2] as AnyObject, ["X": 15] as AnyObject]
// This works because swift automatically bridges to NSNumber, NSString, NSArray, NSDictionary






