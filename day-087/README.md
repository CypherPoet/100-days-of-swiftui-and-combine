# Day 87: _Project 17: Flashzilla_ (Part Two)

_Follow along at https://www.hackingwithswift.com/100/swiftui/87_.

<br/>


# 📒 Field Notes

This day covers Part Two of _`Project 17`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/87). (Project 17 files can be found in the [directory for Part One](../day-086/).)

It focuses on several specific topics:

- Triggering events repeatedly using a timer
- How to be notified when your SwiftUI app moves to the background
- Supporting specific accessibility needs with SwiftUI



## Triggering events repeatedly using a timer

Apple is integrating Combine into `Foundation` at every level, and `Timer` is no exception.

We can compose a publisher out of `Timer.publish` and have our view listen to any of its emitted events.

This listening can be done via `View.onReceive`, but I usually prefer keeping the Timer in a view-model `ObservableObject`, and having the view-model use the timer to update its own state -- which can include `@Published` properties that the View is listening to.



## How to be notified when your SwiftUI app moves to the background

Apple is integrating Combine into `Foundation` at every level, and `NotificationCenter` is no exception.

Using `NotificationCenter.publisher(for:object:)`, we can create a publisher that emits the notifications broadcasted for a passed-in notification name. Because this includes the notifications broadcasted by `UIApplication`, Combine gives us a new lense into things like `willResignActiveNotification`, `willEnterForegroundNotification`, `userDidTakeScreenshotNotification`, and so much more.
