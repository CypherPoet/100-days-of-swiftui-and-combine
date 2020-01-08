# Day 79: _Project 16: QRCollector_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/79_.

<br/>


# 📒 Field Notes

This day covers Part One of _`Project 16`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/79).

It focuses on several specific topics:

- Hot Prospects: Introduction
- Reading custom values from the environment with @EnvironmentObject
- Creating tabs with TabView and tabItem()


## Hot Prospects: Introduction


From the description:

> ...an app to track who you meet at conferences. You’ve probably seen apps like it before: it will show a QR code that stores your attendee information, then others can scan that code to add you to their list of possible leads for later follow up.

I could be wrong, but the way this app is going to be structured, the actual contents of the QR codes could be pretty open-ended. With that in mind, I'm going to name the app `QRCollector` -- and see if it would be more interesting to embed diverse kinds of information into the codes we store.



## Reading custom values from the environment with @EnvironmentObject

Using the `Environment` to store app state is a big topic on its own. One cool SwiftUI-specific tidbit is the way applying the `environmentObject` modifier to a view `View` causes all of that view's children to have access to it:

```swift
VStack {
    EditView()
    DisplayView()
}
.environmentObject(user)
```



## Creating tabs with TabView and tabItem()

Like many of SwiftUI's UIKit analogs, using `TabView` instead of `UITabViewController` feels so much more intuitive.

As soon as you get familiar with the pattern of using `tabItems`, tagging them with some identifiable value, and then using the containing struct's `@State` to change the active tab (by synching it with each tabItem's tag), creating tabbed interfaces is pretty straightforward.

As a bonus, using `@State` to control the active tab can even serve as the foundation for [dynamic deep-linking](https://nalexn.github.io/swiftui-deep-linking/).
