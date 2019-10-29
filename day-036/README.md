# Day 36: _Project 7: iExpense_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/36_.


# 📒 Field Notes

This day covers Part One of _`Project 7: iExpense`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/36).

It focuses on several specific topics:

- iExpense: Introduction
- Why @State only works with structs
- Sharing SwiftUI state with @ObservedObject
- Showing and hiding views
- Deleting items using onDelete()
- Storing user settings with UserDefaults
- Archiving Swift objects with Codable


## iExpense: Introduction

It's an expense tracker. Reign in your spending... buy Bitcoin... financial responsibility, people 😀.




## Why @State only works with structs

Super short version: Structs allow us to leverage value semantics for most of our code -- and @State is meant as helper for updating to changes within to that paradigm.



## Sharing SwiftUI state with @ObservedObject

https://twitter.com/cypher_poet/status/1186121232800014338




## Showing and hiding views

SwiftUI's modal presentation is flow is really starting to grow on me. As straightforward as _showing_ a modal is, thought (using the `.sheet` modifier), dismissal is a bit less so. Fortunately, the `@Environment` has our back -- allowing us to trigger dismissal from within a modal view like so:

```swift
struct MyView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
      Button("Dismiss") {
          self.presentationMode.wrappedValue.dismiss()
      }
    }
}
```


## Deleting items using onDelete()


Step 1: The view hierarchy:

```swift

List {
    ForEach {

    }
    .onDelete(perform: removeRows)
}
.navigationBarItems(leading: EditButton())


```

Step 2: The callback:

  ```swift
  func removeRows(at offsets: IndexSet) {
      numbers.remove(atOffsets: offsets)
  }
  ```
