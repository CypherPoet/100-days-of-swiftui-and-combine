# Day 74: _Project 15: Accessibility_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/74_.

<br/>


# 📒 Field Notes

This day covers Part One of _`Project 15: Accessibility`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/74).

It focuses on several specific topics:

- Accessibility: Introduction
- Identifying views with useful labels
- Hiding and grouping accessibility data
- Reading the value of controls



## Accessibility: Introduction

From the description:

> In this technique project we’re going to look at a handful of accessibility techniques, then look at some of the previous projects we made to see how they might get upgraded.




## Identifying views with useful labels


If we have an image that functions as a button (i.e., if it has an `.onTapGesture` modifier attached to it), we can use a combination of the `.accessibility(label:)` and `.accessibility(hint:)` modifiers override the default VoiceOver description of the image.


Furthermore, to help keep VoiceOver in the know about the element's purpose, we can use `.accessibility(removeTraits: .isImage)` and `.accessibility(addTraits: .isButton)`.

This fine-grained control is, no doubt, awesome -- but if we find ourselves doing the latter dance, it might be _more_ appropriate to use a `Button` and render the image as its content. [Semantic markup](https://html.com/semantic-markup/)... meet `SwiftUI` 🙂.



## Hiding and grouping accessibility data

VoiceOver will attempt to drill down into every container and read each child element separately, pausing along the way. This might be what we want -- but it could also create an unnecessarily confusing and muddy auditory experience.

Enter the `.accessibilityElement(children:)`. If all the elements in a container can be summarized into a single description, we can add `.accessibilityElement(children: .ignore)` to that container, then follow up with a single `.accessibility(label:)` modifier.




## Reading the value of controls


Controls have a mind of their own when it comes to values. A `Slider`, for instance, will always read out its value as a percentage. That's perfect if we're sliding between 0 and 1 -- but less so if we're sliding between... well, anything else. By attaching the `accessibility(value:)` modifier to a control, we can get VoiceOver to read the control's value in a way that we'd want users to perceive it:


```swift
@State private var transactionFee = 100


var body: some View {
    Slider(value: $transactionFee, in: 1...500)
        .padding()
        .accessibility(value: Text("\(transactionFee) Satoshis"))
}

```
