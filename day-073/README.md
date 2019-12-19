# Day 73: _Project 14: PlaceCase_ (Part Five)

_Follow along at https://www.hackingwithswift.com/100/swiftui/73_.

<br/>


# 📒 Field Notes

This day covers Part Five of _`Project 14`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/73). (Project 14 files can be found in the [directory for Part One](../day-068/).)


In addition to recapping the material covered during the project's other days, Day 67 focuses on extending the project according to a set of challenges.

<br/>



# 🥅 Challenges


## Challenge 1

> Our + button is rather hard to tap. Try moving all its modifiers to the image inside the button – what difference does it make, and can you think why?

We don't quite need to put _all_ modifiers inside the button -- but certainly the ones that would determine the surface area of the content:

```swift
Button(action: {
    self.createNewLocation()
}) {
    Image(systemName: "plus.rectangle.fill")
        .font(.title)
        .padding(24)
        .background(Color.accentColor.opacity(0.8))
        .foregroundColor(.white)
}
.clipShape(Circle())
.padding(.trailing)
```

- 🔗 [Commit](https://github.com/CypherPoet/100-days-of-swiftui/commit/53dc10ab4a71fa0be1d003726e45d714b8de0a37)



## Challenge 2

> Having a complex `if` condition in the middle of `ContentView` isn’t easy to read – can you rewrite it so that the `MapView`, `Circle`, and `Button` are part of their own view?

TBH, `ContentView` is usually the first file I delete in a new project 😂. Organizing views under a `Scenes` folder and also [composing them from various "container views"](https://swiftwithmajid.com/2019/07/31/introducing-container-views-in-swiftui/) can go a long way to preventing the sort of problem mentioned above.

With a container view that handles authentication, it can conditionally show an "authed" view which, itself, is solely focused on its standard layout:


```swift
struct LocationCollectionView: View {

    var body: some View {
        ZStack {
            mapUnderlay

            centerIndicator

            addLocationButton
        }
    }
}
```



## Challenge 3

> Our app silently fails when errors occur during biometric authentication. Add code to show those errors in an alert. But be careful: you can only add one alert() modifier to each view.

- 🔗 [Commit](https://github.com/CypherPoet/100-days-of-swiftui/commit/74ac5d349b173f9a8ba26e6fd1dbbdb8e96751aa)
