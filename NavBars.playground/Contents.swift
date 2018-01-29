//: Playground - noun: a place where people can play

import UIKit

/*
 NavBar tricks:
 
 To get status bar tinted same color as nav bar:
 Conform to protocol UIBarPositioningDelegate
 Add:
 // MARK: - UINavigationBarDelegate methods -
 func position(for: UIBarPositioning) -> UIBarPosition {
 // Believe it or not, this allows the status bar to be tinted in the same color as the navBar
 // As long as the navBar delegate is set to the VC (in this case, set in IB)
 // and the VC conforms to UIBarPositioningDelegate
 return UIBarPosition.topAttached
 }
 
 To get just a chevron (no text) as back button on nav stack on a StoryBoard:
 Locate nav item on the PREVIOUS VC and set "Back Button" property to a single SPACE char
 
 To set the back color:
 Locate the NavBar on the NavController at the beginning of the nav stack
 Set "Bar Tint" for background
 Set "Tint" for image and text color

 */
