//: Playground - noun: a place where people can play

import UIKit

/*
ScrollView Tricks:

To get scrollview to respect width of device (It wants to squish it to the left):
Place UIView on ScrollView pinned to UIScrollView
Pin equal width from child UIView to PARENT UIVIEW of scrollview

To prevent the keyboard from hiding bottom fields:
conform to protocol KeyboardHandler
Add:

// Bind ScrollView Here
@IBOutlet var scrollView: UIScrollView!

override func viewDidLoad() {
    super.viewDidLoad()
    // Register
    self.registerForKeyboardEvents()
}

deinit {
    // DeRegister
    self.deregisterForKeyboardEvents()
}

*/
