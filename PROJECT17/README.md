# Project #17 - Flashzilla

https://www.hackingwithswift.com/100/swiftui/86

> ... an app that helps users learn things using flashcards – cards with one thing written on such as “to buy”, and another thing written on the other side, such as “comprar”. 

## Topics
gesture(), simultaneousGesture(), sequenced(before:), CoreHaptics, contentShape, Timer, Combine, UIApplication.willResignActiveNotification

| Day 86 :white_check_mark: | Day 87 :white_check_mark: | Day 88 :white_check_mark: |
|:--|:--|:--|
| learned about gestures, haptics (core haptics and reviewed UINotificationFeedbackGenerator 🤯), and contentShape which is a modifier that lets us specify the taxable shape of something | learned about Timer, Publishers, Combine, app notifications like knowing when your app goes to background, and supporting  accessibility settings! | created the initial UI for the app. Built a fun stack of cards, added the swipe gestures and the cards text | | | |
| 💆‍♀️ | 🧍🏽‍♀️ | ![D88](Data/D88.mov) | 

| Day 89 :white_check_mark: | Day 90 :white_check_mark: | Day 91 :white_check_mark: |
|:--|:--|:--|
| worked on the flashcards, added colors so we can tell when we had an answer right or wrong, and added a timer. | fixed some bugs (including the card's fast animation that was happening) and now users can add their own cards to practice with (it uses user defaults as persistence). | another set of challenges destroyed (jk those challenge destroyed me). Completed the 3 challenges for the flash cards app! I had to fix a color related bug, add haptics for when the timer finished and a new settings feature! :) |
| ![D89](Data/D89.mov) | ![D90](https://user-images.githubusercontent.com/12801333/127066363-e33118e1-b3ad-42bb-a52e-8c8cd55e0daf.mov) | ![D91](https://user-images.githubusercontent.com/12801333/127260635-315f0f92-e396-4960-b45e-3eed6ed46159.mov) |

## Challenges

From [Hacking with Swift](https://www.hackingwithswift.com/books/ios-swiftui/flashzilla-wrap-up):
>1. Make something interesting for when the timer runs out. At the very least make some text appear, but you should also try designing a custom haptic using Core Haptics.
>2. Add a settings screen that has a single option: when you get an answer one wrong that card goes back into the array so the user can try it again.
>3. If you drag a card to the right but not far enough to remove it, then release, you see it turn red as it slides back to the center. Why does this happen and how can you fix it? (Tip: use a custom modifier for this to avoid cluttering your body property.)



| MAIN VIEW| INCORRECT ANSWER | DEMO |
|:--:|:--:|:--:|
|![P17](https://user-images.githubusercontent.com/12801333/127261518-516cc98d-f42f-4391-add5-275c6497febc.png) | ![P17_wrong](https://user-images.githubusercontent.com/12801333/127261572-f4dd021a-f1d4-42cd-b358-f45babf9f028.png) | ![Demo](https://user-images.githubusercontent.com/12801333/127261604-38795b96-c02a-4e3e-b062-492dd9b7e0ed.mov)



