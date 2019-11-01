# Day 39: _Project 8: Moonshot_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/39_.

<br/>


# 📒 Field Notes

This day covers Part One of _`Project 8: Moonshot`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/39).

It focuses on several specific topics:

- Moonshot: Introduction
- Resizing images to fit the screen using GeometryReader
- How ScrollView lets us work with scrolling data
- Pushing new views onto the stack using NavigationLink
- Working with hierarchical Codable data



## Moonshot: Introduction


From the description:

> In this project we’re going to build an app that lets users learn about the missions and astronauts that formed NASA’s Apollo space program. You’ll get more experience with Codable, but more importantly you’ll also work with scroll views, navigation, and much more interesting layouts.



## Resizing images to fit the screen using GeometryReader

`GeomeryReader` gives us a `GeometryProxy` that will contain data about the view's surrounding context after it's laid out.

This is everything 🙂. It means we can dynamically size a view _with respect_ to how it's appearing in a container.



## How ScrollView lets us work with scrolling data

`ScrollView` is pretty straightforward, but there's one important caveat: It's views get created immediately. This means that for dynamic, lazy, performant, view-recycling layouts... `List` is often the best choice.




## Pushing new views onto the stack using NavigationLink

Again, SwiftUI makes this pretty straightforward. Now we just need more control over the entire navigation stack for pushing, popping, or hopping somewhere in between.



## Working with hierarchical Codable data

Codable is smart. If a `Codable` type contains a property that also conforms to `Codable`. A decoder or encoder will know to call that property's own `decode` or `encode` methods while performing them for the containing instance.
