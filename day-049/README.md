# Day 49: _Project 10: CupcakeCorner_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/49_.

<br/>


# 📒 Field Notes

This day covers Part One of _`Project 10: CupcakeCorner`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/49).

It focuses on several specific topics:

- Cupcake Corner: Introduction
- Adding Codable conformance for @Published properties
- Sending and receiving Codable data with URLSession and SwiftUI
- Validating and disabling forms



## Cupcake Corner: Introduction

From the description:

> In this project we’re going to build a multi-screen app for ordering cupcakes. This will use a couple of forms, which are old news for you, but you’re also going to learn how to make classes conform to Codable when they have @Published properties, how to send and receive data from the internet, how to validate forms, and more.




## Adding Codable conformance for @Published properties

For standard Swift objects that conform to `Codable`, Swift will synthesize its `init(from:)` function so long as all of its properties are, themselves, conformant to `Codable`.

This isn't the case with an `ObservableObject`'s `@Published` properties, however, so
if we want to make a `Codable` `ObservableObject`, we'll need to manually create a `CodingKeys` enum, listing all the properties we want to serialize and deserialze.

To be honest, though, I'm not so sure this is the best approach.

`ObservableObject`s need to be classes, and generally I prefer to use structs for models unless reference behavior and semantics are absolutely necessary. (It's almost as if it's a sign that `@Published` properties aren't Codable 🙂.)

In most cases, we're likely better off separating the data models of our application from observing state and responding to changes -- and as such, I've been experimenting with using `ObservableObject`s for view models (aka MVVM) that can be created separately for specific views. These view models, in turn, can focus on their own formatting and presentational logic -- even making use of `Combine` publishers and subscribers to stream updates to their `@Published` properties.

I tweeted about this recently -- [linking a helpful blog post along the way](https://twitter.com/cypher_poet/status/1186121232800014338) -- and several of the projects in this repo make use of this pattern. So far, it feels pretty sweet 😀.



