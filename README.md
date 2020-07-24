# SwiftUIMultiTextField

This is a simple version of a TextField for SwiftUI it's objective is to create an expanding TextField within SwiftUI.

SwiftUI 2 (iOS 14) has a TextEditor but still missing some features.

## Installation

Currently it's only possible to install through Xcode's SPM

### Using Xcode

* File -> Swift Packages -> Add Package Dependency...
* Search for `https://github.com/PedroCavaleiro/SwiftUIMultiTextField`
* Choose the version that you want

## Usage

The usages is fairly simple, check the steps and comments in the following code

```swift
import SwiftUI
// 1. Import the library
import SwiftUIMultiTextField

struct ContentView: View {

    // 2. Add an observed object that will observe the text field size
    @ObservedObject var obj: ObservedMultiTextField = ObservedMultiTextField()

    @State var text: String = ""

    var body: some View {
        // 3. Include the element (more about the parameters below)
        MultiTextField(text: $text,
                       placeholder: "Some Placeholder",
                       maxSize: 120,
                       textColor: UIColor.black)
            .background(textFieldBackground)
            .frame(height: obj.size) // 4. Set the text field height from the object
            .environmentObject(obj)  // 5. Pass the observable object in step 2
    }

}
```
