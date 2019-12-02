# Day 65: _Project 13: Instafilter_ (Part Four)

_Follow along at https://www.hackingwithswift.com/100/swiftui/65_.

<br/>


# 📒 Field Notes

This day covers Part Four of _`Project 13: Instafilter`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/65). (Project 13 files can be found in the [directory for Part One](../day-062/).)


It focuses on several specific topics:

- Building our basic UI
- Importing an image into SwiftUI using UIImagePickerController
- Basic image filtering using Core Image



## Basic image filtering using Core Image

This is just one of many cases where tying user interface controls to Combine publishers can really shine.

By tying out slider to a publisher that updates and observed-object value, we can have the slider react to updates continuously... but not too continuously! -- giving it a slight debounce so that we aren't trying to apply image processing with every microscopic drag movement.

<br/>

**View**:

```swift
Slider(
    value: $viewModel.filterIntensity,
    minimumValueLabel: Text("0"),
    maximumValueLabel: Text("1")
) {
    Text("Intensity")
}
```

**ViewModel ObservableObject**:

```swift
private var filterIntensityPublisher: AnyPublisher<CGFloat, Never> {
    $filterIntensity
        .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
}
```


<br/>
