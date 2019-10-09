# Day 16: _Project 1: WeSplit_, Part One


_Follow along at https://www.hackingwithswift.com/100/swiftui/16_.


## 📒 Field Notes

> This day covers the first part of `Project 1: WeSplit` in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/16)_.
>
> It focuses on several specific topics:
>
> - WeSplit: Introduction
> - Understanding the basic structure of a SwiftUI app
> - Creating a form
> - Adding a navigation bar
> - Modifying program state
> - Binding state to user interface controls
> - Creating views in a loop



### WeSplit: Introduction

The basic premise of `WeSplit` is that it's a check splitting app. From HWS:

> In this project we’re going to be building a check-splitting app that you might use after eating a restaurant – you enter the cost of your food, select how much of a tip you want to leave, and how many people you’re with, and it will tell you how much each person needs to pay.
>
> This project isn’t trying to build anything complicated, because its real purpose is to teach you the basics of SwiftUI in a useful way while also giving you a real-world project you can expand on further if you want.



### Understanding the basic structure of a SwiftUI app

- Using `SceneDelegate` is the new paradigm for a lot of things that were previously stuffed into `AppDelegate`. This allows us to configure individual "windows" of an app, separate from the entire app process.

- `ContentView.swift` is the default entry point -- though ultimately it can be anything. This is because the entry point is set up in `SceneDelegate.scene(_:willConnectTo:options:)`:

```swift
// Create the SwiftUI view that provides the window contents.
let contentView = ContentView()

// Use a UIHostingController as window root view controller.
if let windowScene = scene as? UIWindowScene {
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = UIHostingController(rootView: contentView)
    self.window = window
    window.makeKeyAndVisible()
}
```


### Creating a Form

SwiftUI has a dedicated `Form` view for handling data entry. Forms are scrolling lists of static controls -- which might remind `UIKit` developers of using a static table view for forms.




### Adding a navigation bar


Navigation bars get added to views wrapped in a `NavigationView` view. Important to note is that navigation bar titles are configured by the outer-most `navigationBarTitle` modifier on a view _within_ the `NavigationView`. That is, the modifier isn't used on `NavigationView` directly.



### Modifying program state

SwiftUI views are structs. This means that we can't mutate their properties within computed property getters -- like the all-important `body` property. This won't compile:

```swift
struct ContentView: View {
    var tapCount = 0

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
        }
    }
}
```

This is where SwiftUI's `@State` property wrapper comes in. It allows properties to  be stored separately by SwiftUI in a place that _can_ be modified.

```swift
struct ContentView: View {
    @State private var tapCount = 0

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
        }
    }
}
```

This means we don't need to sacrifice the advantages of using structs -- _and_ we can create bindings with that state while SwiftUI handles the updates under the hood.


### Binding state to user interface controls

Whenever we want to pass off state to another view and create a two-way binding -- where updates in any location will be synched to the source of the state -- we can use the `$` symbol as preface:

```swift
struct ContentView: View {
    @State private var name = ""

    var body: some View {
        Form {
            TextField("Enter your name", text: $name)
            Text("Hello World")
        }
    }
}
```


### Creating views in a loop


`ForEach` is a wonderful fusion of functional programming and SwiftUI's declarative approach to view building. Essentially, we can pass a sequence of values to it, and treat it as a generator for any kind of dynamic list of views. Even better, it integrates seamlessly with other components such as `List` or `Picker`:


```swift
struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"

    var body: some View {
        Picker("Select your student", selection: $selectedStudent) {
            ForEach(0 ..< students.count) {
                Text(self.students[$0])
            }
        }
    }
}
```



## 🔗 Additional/Related Links

- [Apple's SwiftUI Homepage](https://developer.apple.com/xcode/swiftui/)
