# Day 53: _Project 11: Bookworm_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/53_.

<br/>


# 📒 Field Notes

This day covers Part One of _`Project 11: Bookworm`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/53).

It focuses on several specific topics:

- Bookworm: Introduction
- Creating a custom component with @Binding
- Using size classes with AnyView type erasure
- How to combine Core Data and SwiftUI





## Bookworm: Introduction

From the description:

> In this project we’re going to build an app to track which books you’ve read and what you thought of them, and it’s going to follow a similar theme to project 10: let’s take all the skills you’ve already mastered, then add some bonus new skills that take them all to a new level.
>
> This time you’re going to meet Core Data, which is Apple’s battle-hardened framework for working with databases. This project will serve as an introduction for Core Data, but we’ll be going into much more detail soon.
>
> At the same time, we’re also going to build our first custom user interface component – a star rating widget where the user can tap to leave a score for each book. This will mean introducing you to another property wrapper, called @Binding



## Creating a custom component with @Binding

`@Binding`s are sort of like `inout` inside of a functions parameters: It means that some other context owns this value -- but we have carte blanche to mutate it if we want. The `Toggle` control is a perfect example of how this can be utilized.



## Using size classes with AnyView type erasure

`AnyView` can be used to overcome situations where different conditional logic might lead to different types being returned from a `View`'s body. Better yet, we can use `Group` to [overcome the performance hit that `AnyView` incurs](https://swiftwithmajid.com/2019/10/30/view-composition-in-swiftui/) 😀.




## How to combine Core Data and SwiftUI

Historically, there's always been somewhat of an art to passing around Core Data's "Managed Object Context" and using it to update our app's data model. SwiftUI standardizes this by exposing it in the `Environment`:

```swift
@Environment(\.managedObjectContext) var moc
```

Property wrappers FTW 💪

