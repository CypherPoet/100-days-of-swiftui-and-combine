# Day 68: _Project 14: PlaceCase_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/68_.

<br/>


# 📒 Field Notes

This day covers Part One of _`Project 14`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/68).

It focuses on several specific topics:

- Bucket List: Introduction
- Adding conformance to Comparable for custom types
- Writing data to the documents directory
- Switching view states with enums



## Bucket List: Introduction


From the description:


> In this project we’re going to build an app that lets the user build a private list of places on the map
> that they intend to visit one day, add a description for that place, look up interesting places that are
> nearby, and save it all to the iOS storage for later.
>
>
>
> To make all that work will mean leveraging some skills you’ve met already, such as forms, sheets, Codable,
> and URLSession, but also teach you some new skills: how to embed maps in a SwiftUI app, how to store
> private data safely so that only an authenticated user can access it, how to load and save data outside of
> UserDefaults, and more.


**📝Note**: Instead of `Bucket List`, I'm going to call the project `PlaceCase`, because I don't want my users to die 😛. I might also use CoreData as a storage mechanism... we'll see.




## Adding conformance to Comparable for custom types

Operator overloading can be a huge hammer in some languages, but in a type safe language like Swift, we can scope it to a custom type and have it adopt the `Comparable` protocol for use with inequality comparisons:


```swift
struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String

    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
```



## Writing data to the documents directory


Thanks to sandboxing, all iOS apps run in their own container under a randomly generated directory name. This means that an external application won't be able to know where another app's file storage directories are located.

It also means that our app itself won't know until runtime, so we'll need a handy utility like this to find things like the user documents directory:

```swift
extension FileManager {
    public static var userDocumentsDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
```


## Switching view states with enums

Whether it's gameplay state, loading state, playback state, or any kind of dynamic state, Swift `Enum`s are a tremendously useful way to track it and respond accordingly. Case closed.
