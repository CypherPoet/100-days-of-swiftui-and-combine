# Day 57: _Project 12: ExploringCoreData_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/57_.

<br/>


# 📒 Field Notes

This day covers Part One of _`Project 12: Core Data`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/57).

It focuses on several specific topics:

- Core Data: Introduction
- Why does \.self work for ForEach?
- Creating NSManagedObject subclasses
- Conditional saving of NSManagedObjectContext
- Ensuring Core Data objects are unique using constraints




## Core Data: Introduction

From the description:

> This technique project is going to explore Core Data in more detail, starting with a summary of some basic techniques then building up to tackling some more complex problems.



## Why does \.self work for ForEach?

In a word: hashing.

`\.self` works for anything that conforms to `Hashable`, and Core Data models conform to `Hashable` under the hood. Put those two things together and you get ~~D4735E3A265E16EEE03F59718B9B5D03019C07D8B6C51F90DA3A666EEC13AB35~~ seamless integration with SwiftUI's `ForEach`.


## Creating NSManagedObject subclasses

When we generate an NSManagedObject subclass for a Core Data model, attributes that aren't required or don't have default values will be marked as `Optional`. We _could_ manually remove them, and that would still work -- but it would actually lead to the ability to create an entity instance without providing values for the (supposedly) non-optional attributes.

This is due to the way Core Data treats `@NSManaged` properties under the hood -- that is, it's not treating them as real properties.

IMO, trying to exploit implementation details like this is a recipe for frustrating bugs down the road and only reinforces bad habits. I'd recommend avoiding it all costs. If we want to create more suger over our optionals, it's far better to use computed properties -- and/or make use of the view-model pattern when passing a Core Data model instance down to a view.




## Conditional saving of NSManagedObjectContext

#PerfMatters

```swift
if moc.hasChanges {
    do {
      try moc.save()
    } catch {
        ...
    }
}
```


## Ensuring Core Data objects are unique using constraints

By default, Core Data uses a context `mergePolicy` of `NSErrorMergePolicy`. This means that when we attempt to save multiple objects considered to be identical, the operation will fail.

If we want to be able to keep saving the same object -- say, an object with the same unique identifier(s) but with different attributes after a user edits it in a form -- we can set the `mergePolicy` to `NSMergeByPropertyObjectTrumpMergePolicy`.

The [Apple documentation](https://developer.apple.com/documentation/coredata/nsmergepolicy/merge_policies) describes it as follows:

```swift
A policy that merges conflicts between the persistent store’s version of the object and the current in-memory version by individual property, with the in-memory changes trumping external changes.
```

... just what we needed 🙂.

<br/>
