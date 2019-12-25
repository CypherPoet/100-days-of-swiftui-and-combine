# Day 76: _Project 15: Accessibility_ (Part Three)

_Follow along at https://www.hackingwithswift.com/100/swiftui/76_.

<br/>


# 📒 Field Notes

This day covers Part Three of _`Project 15: Accessibility`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/76). (Project files associated with Project 15 can be found in the [directory for Part One](../day-074/).)

In addition to recapping the material covered during the project's other days, Day 76 focuses on extending the project according to a set of challenges.

<br/>



# 🥅 Challenges


## Challenge 1

> The check out view in `Cupcake Corner` uses an image that doesn’t add anything to the UI, so find a way to make the screen reader not read it out.

- 🔗 [Commit](https://github.com/CypherPoet/100-days-of-swiftui/commit/49b518f9effb3a07e420621c21e79de161fb44da)


## Challenge 2

> Fix the steppers in BetterRest so that they read out useful information when the user adjusts their values.


- 🔗 [Commit](https://github.com/CypherPoet/100-days-of-swiftui/commit/7cb7372d76a0d7de232982a22d00f75946ab98c7)


## Challenge 3

>  Do a full accessibility review of Moonshot – what changes do you need to make so that it’s fully accessible?

- 🔗 [Commit](https://github.com/CypherPoet/100-days-of-swiftui/commit/f9012385e71e2f228e824ddec91dff82d4769bcc)



 - I manually removed the `isButton` trait and add the `isLink` trait from the `NavigationLink` in the Missions List to have it read as a link. I'm not sure if this is a bug, though -- or if `Button` is actually supposed to be the official trait 🤔.


- Using a `decorative` Image for each mission's insignia. A more advanced approach would be writing
detailed visual descriptions of each insignia and supplying those for the accessibility label.

- Using a `decorative` Image for each astronaut's photo on their details page.
