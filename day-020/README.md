# Day 20: _Project 2: Guess The Flag_, Part One


_Follow along at https://www.hackingwithswift.com/100/swiftui/20_.


# 📒 Field Notes

This day covers Part One of _`Project 2: Guess The Flag`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/20).

It focuses on several specific topics:

- Using stacks to arrange views
- Colors and frames
- Gradients
- Buttons and images
- Showing alert messages



## Using stacks to arrange views

Each SwiftUI `View` returns `some View` for its computed `body` property. If we want it to contain
multiple views, we can wrap it in a stack such as a `VStack`, `HStack` or `ZStack`. Other containers such as `Group`, `List`, `Form`, etc can also facilitate this need.


## Colors and frames

That SwiftUI's `Color` type is a `View` perfectly epitomizes the framework's ethos of composability. It's views all the way down -- which makes pulling off effects like full screen background colors s cinch:

```swift
ZStack {
    Color.red.edgesIgnoringSafeArea(.all)
    Text("⚡️")
}
```


## Gradients

Whether it's a `LinearGradient', 'RadialGradient', or `AngularGradient`, the same `View`-based benefits afforded to color also apply to SwiftUI gradients. Which is good... because gradients are sexy AF.



## Showing alert messages

In `UIKit`, alerts would need to be constructed as part of a `UIAlertController` and then explicitly presented inside of another controller.

In `SwiftUI`... alerts exist as another modifier on a view -- which binds to a certain piece of
state to know whether or not it should be shown:


```swift
struct ContentView: View {
    @State private var isShowingAlert = false

    var body: some View {
        Button("Show Alert") {
            self.isShowingAlert = true
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Hello SwiftUI!"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
        }
    }
}
```
