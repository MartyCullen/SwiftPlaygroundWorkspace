//: Playground - noun: a place where people can play

import UIKit

// Serial (aka: Private) - one at a time FIFO
// Concurrent - started in the order added, but can be executed as OS has resources available
// Main - ONE globally available Serial queue

// 3 types of Dispatch Queue:
// Main - The main thread is serial and obviously one ONE
// Global - Concurrent ques shared by the whole system
// Custom - Developer created and can be Serial or Concurrent (These end up being handled in one of the global queues)

// 4 levels of QoS
// User-interactive - Small high-priority tasks that should be on MAIN thread
// User-initiated - UI initiated high-priority tasks - high priority global queue
// Utility - long running asynch ops - progress indicator appropriate - low priority global queue
// Background - prefetching - user unaware - background priority global queue

// Can be Asynch or Synch

// LET variables are immutable constants and thread safe
// VAR variables are mutable and not safe unless designed to be so
// Mutable collections are not safe

// Use dispatch barriers to prevent thread read/write conflicts
// Be VERY careful using sync on the MAIN queue or a custom serial queue
// sync is good for waiting for a task to complete in the global queue


func doCalc() {
    let x = 100
    let y = x*x
    _ = y/x
}

func performCalculation(iterations: Int, tag: String) {
    let start = CFAbsoluteTimeGetCurrent()
    for _ in 0 ..< iterations {
        doCalc()
    }
    let end = CFAbsoluteTimeGetCurrent()
    print("Time for \(tag) \(end - start)")
}

let concurrentQueue = DispatchQueue(label: "concurrent.martycullen.com", attributes: .concurrent)
let serialQueue = DispatchQueue(label: "serial.martycullen.com") // No attributes indicates SERIAL

concurrentQueue.async(execute:{ performCalculation(iterations: 1000, tag: "Async1")})


// Most common usage is to force an action on main if it is GUI related
DispatchQueue.main.async {
    //self.tableView.reloadData()
}





