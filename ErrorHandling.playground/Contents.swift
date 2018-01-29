//: Playground - noun: a place where people can play

import UIKit

enum PrinterError: Error {
    case outOfPaper, noToner, onFire
}

func send(job: Int, toPrinter printerName:String) throws -> String {
    if ( printerName == "Never has toner") {
        throw PrinterError.noToner
    }
    return "Job Sent"
}

do {
    let printerResponse = try send(job:1040, toPrinter: "Never has toner")  // The TRY is where the error can occur
    print(printerResponse)
} catch PrinterError.onFire {
    print("Get the extinguisher")
} catch let printerError as PrinterError{
    print("Printer Error: \(printerError)")
} catch { // any remaining error types
    print(error)
}

// Instead of using the do...try...catch you can return as an optional and get a nil on error
let optionalResponse = try? send(job:1040, toPrinter: "Never has toner")

// Instead of using the do...try...catch you can return as an optional and CRASH on error
//let crashResponse = try! send(job:1040, toPrinter: "Never has toner")

