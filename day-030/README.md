# Day 30: _Project 5: WordScramble_ (Part Two)

_Follow along at https://www.hackingwithswift.com/100/swiftui/30_.


# 📒 Field Notes

This day covers Part Two of _`Project 5: WordScramble`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/30). (Project 5 files can be found in the [directory for Part One](../day-029/).)

It focuses on several specific topics:

- Adding to a list of words
- Running code when our app launches
- Validating words with UITextChecker



## Running code when our app launches

The `onAppear` modifier is your friend here.



## Validating words with UITextChecker

Now we're getting our hands dirty. In order to check if a word is "valid English" (ideally, though, we'd localize the language), we can utilize `UITextChecker` -- which is available through `UIKit`... but which mainly serves as a bridge to Objective-C-based range operations:

```swift
var currentGuessIsRealWord: Bool {
    let wordRange = NSRange(location: 0, length: currentRootWord.utf16.count)

    let misspelledRange = Self.textChecker.rangeOfMisspelledWord(
        in: currentRootWord,
        range: wordRange,
        startingAt: 0,
        wrap: false,
        language: "en"
    )

    return misspelledRange.location == NSNotFound
}
```

It's all good, though. Clunky as it may be, it's pretty cool that this kind of magic is within reach through some of Apple's lower-level APIs.


# 📸 Screenshots

<div style="text-align: center;">
  <img src="../day-029/Projects/WordScramble/Screenshots/recording-day-30.gif" width="400px"/>
</div>
