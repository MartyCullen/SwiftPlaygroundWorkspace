//: Playground - noun: a place where people can play

import UIKit

let font : UIFont = UIFont ( name : "HelveticaNeue" , size : 18.0 )!

var pointSize : CGFloat = font.pointSize
var ascender : CGFloat = font.ascender
var descender : CGFloat = font.descender
var leading : CGFloat = font.leading
var capHeight : CGFloat = font.capHeight
var xHeight : CGFloat = font.xHeight
var lineHeight : CGFloat = font.lineHeight

var diff : CGFloat = font.ascender - font.capHeight
var ratio : CGFloat = diff / font.pointSize

let i : NSInteger = 7 / 60

print(ascender)

func printFonts() {
    let fontFamilyNames = UIFont.familyNames
    for familyName in fontFamilyNames {
        print("------------------------------")
        print("Font Family Name = \(familyName)")
        let names = UIFont.fontNames(forFamilyName: familyName)
        print("Font Names = \(names)")
    }
}

// Commented out to speed up playground
//printFonts()
