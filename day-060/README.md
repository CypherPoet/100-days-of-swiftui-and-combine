# Day 60: Milestone for Projects 10-12

_Follow along at https://www.hackingwithswift.com/100/swiftui/60_.


# 📒 Field Notes

This day resolves around recapping the content covered while going through Projects 10-12 in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui), and then implementing a challenge project.


# 🥅 Challenge Project


From the description:

> Use `URLSession` to download some JSON from the internet, use `Codable` to convert it to Swift types, then use `NavigationView`, `List`, and more to display it to the user.

And regarding the data source:

> As you can see, there is an array of people, and each person has an ID, name, age, email address, and more. They also have an array of tag strings, and an array of friends, where each friend has a name and ID.
>
> How far you implement this is down to you, but at the very least you should:
>
>   - Fetch the data and parse it into User and Friend structs.
>   - Display a list of users with a little information about them.
>   - Create a detail view shown when a user is tapped, presenting more information about them.
>
> Where things get more interesting is with their friends: if you really want to push your skills, think about how to show each user’s friends on the detail screen.
>
> For a medium-sized challenge, show a little information about their friends right on the detail screen. For a bigger challenge, make each of those friends tappable to show their own detail view.


Honestly, though, I'm not that into listing random people's data -- so I hit up the [SpaceX API](https://github.com/r-spacex/SpaceX-API) to see if there was an opportunity to do some similar stuff with rockets 🚀.

As it turns out, `missions` and the lists of `payloads` delivered during a mission's many launches fits the mold of what we're going for here perfectly.
