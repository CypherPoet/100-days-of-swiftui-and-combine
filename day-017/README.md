# Day 17: _Project 1: WeSplit_, Part Two


_Follow along at https://www.hackingwithswift.com/100/swiftui/17_.


# 📒 Field Notes

This day covers Part Two of _`Project 1: WeSplit`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/16). (Project files can be found in the [directory for Part One](../day-016/).)

It focuses on several specific topics:

- Reading text from the user with TextField
- Creating pickers in a form
- Adding a segmented control for tip percentages
- Calculating the total per person



### Reading text from the user with TextField

Given that this is a check spitting app, I experimented with binding a `Double` to the `TextField` with the `TextField(_:value:)` initializer. Unfortunately, at the moment, [SwiftUI will only refresh the view](https://stackoverflow.com/a/57985669) automatically if using the ``TextField(_:text:)` initializer and binding a string.

Good to know... but I anticipate we'll need a splash of custom logic to properly handle converting string inputs to currency values.



### Creating pickers in a form

I'm not sure if this is a feature that was added after the course video was made, but it looks like a `Picker` wrapped in a `ForEach` will bind to the `ForEach`'s values directly (that is, instead of updating them with the active index) as long as we include an `id` keypath in its construction:

```swift
Picker("Number of People", selection: $numberOfPeople) {
    ForEach(1...100, id: \.self) { number in
        Text("\(number) \(number == 1 ? "Person" : "People")")
    }
}
```


### Calculating the total per person

This is where computed properties get to work their magic. Composing everything like this...

```swift
extension MainView {
     private var checkAmount: Double { Double(checkAmountString) ?? 0 }


    private var totalCost: Double {
         checkAmount
             + (checkAmount * (Double(tipPercentage.rawValue) / 100.0))
     }


    private var amountPerPerson: Double? {
         guard numberOfPeople > 0 else { return nil }

         return totalCost / Double(numberOfPeople)
     }


    private var formattedAmountPerPerson: String? {
         guard let amountPerPerson = amountPerPerson else { return nil }

         return Currency.formatter.string(from: amountPerPerson as NSNumber)
     }
}

```


...gives us a nice and clean declaration at the call site:

```swift
if formattedAmountPerPerson != nil {
  Text("\(formattedAmountPerPerson!) Satoshis")
}
```
