# Day 80: _Project 16: QRCollector_ (Part Two)

_Follow along at https://www.hackingwithswift.com/100/swiftui/80_.

<br/>


# 📒 Field Notes

This day covers Part Two of _`Project 16`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/80). (Project 16 files can be found in the [directory for Part One](../day-079/).)

It focuses on several specific topics:

- Understanding Swift’s Result type
- Manually publishing ObservableObject changes
- Controlling image interpolation in SwiftUI



## Understanding Swift’s Result type

Being able to return declarative, deterministic, strongly-typed information about the success or failure of an operation is a beautiful -- and useful -- concept -- even more so when dealing with asynchronous operations.

It's no coincidence that Swift's `Result` type is basically what [everyone was rolling on their own](https://www.swiftbysundell.com/articles/the-power-of-result-types-in-swift/) well before its introduction in Swift 5 😆.

