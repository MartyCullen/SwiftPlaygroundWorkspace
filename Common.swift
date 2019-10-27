//
//  Common.swift
//  
//
//  Created by Marty Cullen on 1/28/18.
//

import UIKit

class Common {

}

public enum Rank: Int {
    case ace = 1  // set the initial value to ONE instead of the default of ZERO
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

public enum Suit: Int {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .clubs:
            return "clubs"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        }
    }
    
    func color() -> String{
        switch self {
        case .spades:
            return "black"
        case .clubs:
            return "black"
        case .hearts:
            return "red"
        case .diamonds:
            return "red"
        }
    }
}


