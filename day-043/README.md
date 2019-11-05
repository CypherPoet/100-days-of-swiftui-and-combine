# Day 43: _Project 9: Drawing_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/43_.

<br/>


# 📒 Field Notes

This day covers Part One of _`Project 9: Drawing`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/43).

It focuses on several specific topics:

- Drawing: Introduction
- Creating custom paths with SwiftUI
- Paths vs shapes in SwiftUI
- Adding strokeBorder() support with InsettableShape



## Drawing: Introduction

From the description:

> In this technique project we’re going to take a close look at drawing in SwiftUI, including creating custom paths and shapes, animating your changes, solving performance problems, and more>



## Creating custom paths with SwiftUI


For custom paths, the `StrokeStyle` constructor is one of your best friends. This gives us fine-grained
control over many of the imporant properties that define path style:

```swift
public struct StrokeStyle : Equatable {

    public var lineWidth: CGFloat

    public var lineCap: CGLineCap

    public var lineJoin: CGLineJoin

    public var miterLimit: CGFloat

    public var dash: [CGFloat]

    public var dashPhase: CGFloat


    ...
}
```
