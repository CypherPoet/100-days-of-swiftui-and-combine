# Day 29: _Project 5: WordScramble_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/29_.


# 📒 Field Notes

This day covers Part One of _`Project 5: WordScramble`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/29).

It focuses on several specific topics:

- Word Scramble: Introduction
- Introducing List, your best friend
- Loading resources from your app bundle
- Working with strings


## Word Scramble: Introduction

From the description:

> The game will show players a random eight-letter word, and ask them to make words out of it.
>
> For example, if the starter word is “alarming” they might spell “alarm”, “ring”, “main”, and so on.


## Introducing List, your best friend

`List`s are essentially SwiftUI's version of UIKit's TableView. But one neat difference is their ability to seamlessly integrate static and dynamic content within the same `List` element:

```swift
List {
    Section(header: Text("Section 1")) {
        Text("Static row 1")
        Text("Static row 2")
    }

    Section(header: Text("Section 2")) {
        ForEach(0..<5) {
            Text("Dynamic row \($0)")
        }
    }

    Section(header: Text("Section 3")) {
        Text("Static row 3")
        Text("Static row 4")
    }
}
```

Oh... and, that tight integration with the `Section` element is pretty sweet, too 🙂.


## Loading resources from your app bundle

Whenever we have something in our app's `Bundle` that we want to deal with in code, we first need to locate it with a URL (which is why it's called a "Uniform Resource Locator").

In many cases, we'd use this URL to create an instance of `Data`, and then decode that data into some kind of structured model based upon the structure of the file.

In this app, though, we'll be grabbing the contents of a plain-text file that lacks the structure of something like JSON.


Fortunately, because Swift `String`s are weapons-grade, we can also create them directly from the content's of a file:

```swift
if let fileContents = try? String(contentsOf: fileURL) {
    // we loaded the file into a string!
}
```


