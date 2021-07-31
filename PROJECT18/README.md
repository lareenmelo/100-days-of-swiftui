# Project #18 - LayoutAndGeometry

https://www.hackingwithswift.com/100/swiftui/92

> ...  explore how SwiftUI handles layout

## Topics
Alignment, Offset, lastTextBaseline, alignmentGuide, ViewDimensions, position(), offset(), GeometryReader, coordinateSpace, ScrollView effects

| Day 92 :white_check_mark: | Day 93 :white_check_mark: | Day 94 :white_check_mark: |
|:--|:--|:--|
| learned how layout works in SwiftUI, what alignment guides are and, how to create your own custom alignment guide.  | learned about absolute and relative positions in SwiftUI, explored different ways of using GeometryReader, created custom coordinate spaces using coordinateSpace() and, learned how to create ScrollView effects using GeometryReader | the three challenges were completed! We basically added scroll effects using geometry reader to previous apps we built. |
| 📐 | ![93](https://user-images.githubusercontent.com/12801333/127727333-2f7e1866-64a4-4681-bc15-f85983d223c1.mp4) | 📏 | 


## Challenges

From [Hacking with Swift](https://www.hackingwithswift.com/books/ios-swiftui/layout-and-geometry-wrap-up):
>1. Change project 8 (Moonshot) so that when you scroll down in `MissionView` the mission badge image gets smaller. It doesn’t need to shrink away to nothing – going down to maybe 80% is fine.
>2. Change project 5 (Word Scramble) so that words towards the bottom of the list slide in from the right as you scroll. Ideally at least the top 8-10 words should all be positioned normally, but after that they should be offset increasingly to the right.
>3. For a real challenge make the letter count images in project 5 change color as you scroll. For the best effect, you should create colors using the `Color(red:green:blue:)` initializer, feeding in values for whichever of red, green, and blue you want to modify. The values to input can be figured out using the row’s current position divided by maximum position, which should give you values in the range 0 to 1.
