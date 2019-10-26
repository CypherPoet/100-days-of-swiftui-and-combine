# Day 33: _Project 6: Animation_ (Part Two)

_Follow along at https://www.hackingwithswift.com/100/swiftui/33_.


# 📒 Field Notes

This day covers Part Two of _`Project 6: Animation`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/33). (Project 6 files can be found in the [directory for Part One](../day-032/).)

It focuses on several specific topics:

- Controlling the animation stack
- Animating gestures
- Showing and hiding views with transitions
- Building custom transitions using ViewModifier




## Controlling the animation stack

Views can have multiple `.animation` modifiers, and each one operates on changed properties _up to_ any previous `.animation` modifier in the view stack.

This makes perfect sense when you think of `.animation` modifier as a book tab -- separating a stack of modifiers into composable sections, each with their own animation logic.



## Animating gestures

Gestures allow us to hook into the current "gesture state" whenever it changes or completes... making them perfect for updating our own state that we're trying to animate -- such as the offset of an element that we want to make draggable.




## Showing and hiding views with transitions


Transitions allow us to animate a view as it's dynamically shown or hidden. The also demonstrates the power of explicit animation via `withAnimation` -- because they allow us to animate state from one view that might be used to define a completely separate view:

```swift
VStack {
    Button(action: {
        withAnimation(.easeInOut(duration: 0.4)) {
            self.isShowingSquare.toggle()
        }
    }) {
        Text("Tap Me 🕺")
            .font(.largeTitle)
    }

    if isShowingSquare {
        Rectangle()
            .fill(Color.pink)
            .frame(width: 200, height: 200)
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
    }
}
```


# 📸 Screenshots

<div style="text-align: center;">
  <img src="../day-032/Projects/AnimationSandbox/Screenshots/day-33-recording.gif" width="400px"/>
</div>

