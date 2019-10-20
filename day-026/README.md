# Day 26: _Project 4: BetterRest_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/26_.


# 📒 Field Notes

This day covers Part One of _`Project 4: BetterRest`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/26).

It focuses on several specific topics:

- BetterRest: Introduction
- Entering numbers with Stepper
- Selecting dates and times with DatePicker
- Working with dates
- Training a model with Create ML


## BetterRest: Introduction

From the project description:

> The actual app we’re build is called BetterRest, and it’s designed to help coffee drinkers get a good night’s sleep by asking them three questions:
>
>   - When do they want to wake up?
>   - Roughly how many hours of sleep do they want?
>   - How many cups of coffee do they drink per day?

In my coffee-drinking experience -- which rivals this project's training data in voluminousness -- you really just need to stop drinking coffee about six hours before sleeping so it can exit your system in time. But I digress... I'm just here for the awesomeness that is CoreML 😛. So let's get to it!.


## Entering numbers with Stepper

You _could_ use a stepper as a button-based replacement for `Slider`, but that would be missing out on its eponymous killer feature: the `step` argument. This is a great way to tailor data entry around the values that users would frequently enter within a range -- for instance, hours of sleep in increments of 15 minutes.


## Selecting dates and times with DatePicker

Speaking of killer features... [partial ranges](https://developer.apple.com/documentation/swift/partialrangefrom). So often, we just want to make sure that the user selects a date that hasn't come into existence yet, and thanks to the robustness of `DatePicker`'s `in` argument, we can do it like this:

```swift
DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
```


## Working with dates

[Time doesn't actually exist](https://qz.com/1279371/this-physicists-ideas-of-time-will-blow-your-mind/) -- so I'll admit that it's not easy to develop a system for measuring state change in the universe and maintaining it throughout human history. But in any case, dates are beasts.

Fortunately, Swift and Foundation come packed with several handy classes that let us tame them as needed -- particularly `DateComponents`, `DateFormatter`, and the `Calendar` class.


## Training a model with Create ML

Not unlike `SwiftUI` for building interfaces, the tools Apple is building for letting developers integrate Machine Learning into their apps are nothing short of amazing. I can't wait to see where CreateML and CoreML go in the future ⚡️.




# 🔗 Additional Related Links

- [Swift By Sundell: Computing dates in Swift](https://www.swiftbysundell.com/articles/computing-dates-in-swift/)
- [Apple's Documentation for CreateML](https://developer.apple.com/documentation/createml)
