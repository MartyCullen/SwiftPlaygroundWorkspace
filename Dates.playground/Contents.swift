//: Playground - noun: a place where people can play

import UIKit

var date1 : NSDate = NSDate()
var interval : TimeInterval = date1.timeIntervalSince1970

NSIntegerMax

let dateLastNite : NSDate = NSDate(timeIntervalSince1970: 1430190884.0)
let dateMorning : NSDate = NSDate(timeIntervalSince1970: 1430195000.0)
let dateMid : NSDate = NSDate(timeIntervalSince1970: 1430240000.0)
let dateEvening : NSDate = NSDate(timeIntervalSince1970: 1430279900.0)
let dateTomorrow : NSDate = NSDate(timeIntervalSince1970: 1430280100.0)

var curCal : Calendar = Calendar.current
var tz = curCal.timeZone.abbreviation

var dayOfYearPast : NSInteger = curCal.ordinality(of: Calendar.Component.day, in: Calendar.Component.year, for: dateLastNite as Date)!
var dayOfYearAM   : NSInteger = curCal.ordinality(of: Calendar.Component.day, in: Calendar.Component.year, for: dateMorning as Date)!
var dayOfYearPM   : NSInteger = curCal.ordinality(of: Calendar.Component.day, in: Calendar.Component.year, for: dateEvening as Date)!

var dayOfEraPast : NSInteger = curCal.ordinality(of: Calendar.Component.day, in: Calendar.Component.era, for: dateLastNite as Date)!
var dayOfEraAM   : NSInteger = curCal.ordinality(of: Calendar.Component.day, in: Calendar.Component.era, for: dateMorning as Date)!
var dayOfEraPM   : NSInteger = curCal.ordinality(of: Calendar.Component.day, in: Calendar.Component.era, for: dateEvening as Date)!

var formatter : DateFormatter = DateFormatter()
formatter.dateFormat = "g"
var lastNiteString = formatter.string(from: dateLastNite as Date)
var AMString = formatter.string(from: dateMorning as Date)
var PMString = formatter.string(from: dateEvening as Date)

