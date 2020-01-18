# Day 86: _Project 17: Flashzilla_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/86_.

<br/>


# 📒 Field Notes

This day covers Part One of _`Project 17`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/86).

It focuses on several specific topics:

- Flashzilla: Introduction
- How to use gestures in SwiftUI
- Making vibrations with UINotificationFeedbackGenerator and Core Haptics
- Disabling user interactivity with allowsHitTesting()




## Flashzilla: Introduction

From the project description:

> In this project we’re going to build an app that helps users learn things using flashcards – cards with one thing written on the front, such as “to buy”, and another thing written on the other side, such as “comprar”.



## How to use gestures in SwiftUI

My intuition for when to use `@GestureState` vs `@State` when updating the UI via gestures remains a bit tenuous -- but I'm definitely seeing how the former can be useful: `@GestureState` is way of telling SwiftUI that this value can _only_ be mutated during a gesture's `updating` callback. `@State` is much more liberal.


# Code

The concepts project to go along with this day can be found [here](./Projects/Project17Concepts/).
