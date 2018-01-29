//: Playground - noun: a place where people can play

import UIKit

class AccountManager {
    static let sharedInstance = AccountManager()
    var userInfo = (ID: "bobthedeveloper", password: 58374953)
    func network() {}
    private init() {}
}

AccountManager.sharedInstance.userInfo.ID


