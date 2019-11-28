# Day 62: _Project 13: Instafilter_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/62_.

<br/>


# 📒 Field Notes

This day covers Part One of _`Project 13: Instafilter`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/62).

It focuses on several specific topics:

- Instafilter: Introduction
- How property wrappers become structs
- Creating custom bindings in SwiftUI
- Showing multiple options with ActionSheet




## Instafilter: Introduction

From the description:

> In this project we’re going to build an app that lets the user import photos from their library, then modify them using various image effects. We’ll cover a number of new techniques, but at the center of it all are one useful app development skill – using Apple’s Core Image framework – and one important SwiftUI skill – integrating with UIKit. There are other things too, but those two are the big takeaways.



## How property wrappers become structs


`@State` property wrappers wrap their properties in a struct under the hood. That's because they have the following type declaration:

```swift
@propertyWrapper public struct State<Value> : DynamicProperty {}
```

This is important, because if means the following code won't work as expected:

```swift
@State private var blurAmount: CGFloat = 0 {
    didSet {
        print("New value is \(blurAmount)")
    }
}
```

`didSet` won't run when our `View`'s `blurAmount` changes, because what it's actually saying "When the State struct wrapping `blurAmount` changes, print out the new blur amount".

If we truly need the behavior depicted above, one solution is to leverage custom bindings...


## Creating custom bindings in SwiftUI

Custom bindings can serve as a "pass-through" to changes that occur to a View's state:

```swift
struct ContentView: View {
    @State private var blurAmount: CGFloat = 0

    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )

        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: blur, in: 0...20)
        }
    }
}
```




## Showing multiple options with ActionSheet

While visually distinct, `ActionSheet`s are alot like `Alert`s with respect to the way we declare them as a modifier on a SwiftUI View.

As hinted at by their name, `ActionSheet`s can also be much more extensive than `Alert`s -- taking any number of buttons in their constructor:

```swift
.actionSheet(isPresented: $isShowingActionSheet) {
      ActionSheet(
          title: Text("Change background"),
          message: Text("Select a new color"),
          buttons: [
              .default(Text("Red")) { self.backgroundColor = .red },
              .default(Text("Green")) { self.backgroundColor = .green },
              .default(Text("Blue")) { self.backgroundColor = .blue },
              .cancel(),
          ]
        )
}
```
