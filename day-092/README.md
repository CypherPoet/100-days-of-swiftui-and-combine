# Day 92: _Project 18: Layout And Geometry_ (Part One)

_Follow along at https://www.hackingwithswift.com/100/swiftui/92_.

<br/>


# 📒 Field Notes

This day covers Part One of _`Project 18`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/92).

It focuses on several specific topics:

- Layout and geometry: Introduction
- How layout works in SwiftUI
- Alignment and alignment guides
- How to create a custom alignment guide



## Layout and geometry: Introduction

From the project description:

> In this technique project we’re going to explore how SwiftUI handles layout.
>
> ...
>
> Along the way you’ll also learn about creating more advanced layout alignments, building special effects using GeometryReader, and more.



## How layout works in SwiftUI

1. A parent view proposes a size for its child.

2. Based on that information, the child then chooses its own size and the parent must respect that choice.

3. The parent then positions the child in its coordinate space.


A key insight to go along with this is that modifiers make containers. As such, every modifier becomes the parent of a child view its attached to, and this three-step process is performed anew.


## Alignment and alignment guides

### Alignment

A neat way to think of alignment is that it refers to how a view is pinned on its main axis.

For horizontal views, the main axis is a horizontal line, so the pinning refers to a vertical adjustment.

For vertical views, the main axis is a vertical line, so the pinning refers to a horizontal adjustment.


### Alignment Guides

Alignment guides are basically the way that views configure their layout _with respect_ to their current alignment. It makes sense once you start using them 😛.

A key insight to go along with this is that alignment guide computation is distinct from offsetting. Using the `offset` modifier will move a view relative to its container; alignment guides will compute the view's layout position -- and the container will be defined as the resulting perimeter.


## How to create a custom alignment guide

Exhibit A:

```swift
extension VerticalAlignment {
    enum CustomAlignment: AlignmentID {
        static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
            dimensions[VerticalAlignment.center]
        }

    }

    static let customAlignment = VerticalAlignment(CustomAlignment.self)
}

```
