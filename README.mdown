# ALPickerView

`ALPickerView` is an attempt to mime the multiple selection behavior of Cocoa Touch's `UIPickerView` (as seen in Mobile Safari).

![ALPickerView Screenshot](https://github.com/alexleutgoeb/ALPickerView/raw/master/screenshot.png "ALPickerView Screenshot")

~~Requires iOS SDK 4.0 or higher~~ *Update*: `ALPickerView` should now be compatible from iOS3 to latest

## How to use

* Copy class files from Classes folder to your project
* Copy image files from ImageRes folder to your project
* Import `ALPickerView.h` and implement `ALPickerViewDelegate` protocol
* See Demo project for details


## Known limitations

* `ALPickerView` doesn't play the keyboard input sound on selection changes; though I don't consider this as a problem ;)
* The size is constrained to 320x216 atm (like `UIPickerView`)