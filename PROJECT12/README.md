 # Project #12 - CoreD

https://www.hackingwithswift.com/100/swiftui/57

> ... explore Core Data in more detail, starting with a summary of some basic techniques then building up to tackling some more complex problems.

## Topics

|Day 57 :white_check_mark: | Day 58 :white_check_mark: | Day 59 :white_check_mark: |
|:--|:--|:--|
| learned about Hashable (and understood why \.self works to identify managed objects), created NSManagedObject subclasses, learned about the hasChange property in managed objects and, CoreData constraints... a packed day! |  worked with NSPredicate, Dynamic filtering, and Core Data relationships.  | Completed the challenges for project #12, basically created ways to add predicates and filters so it's easier to customize the filtering of a list in the project. |
| :eyes: |:100:|👩🏽‍🍼|

## Challenges

From [Hacking with Swift](https://www.hackingwithswift.com/books/ios-swiftui/core-data-wrap-up):
> 1. Make it accept an array of `NSSortDescriptor` objects to get used in its fetch request.
> 2. Make it accept a string parameter that controls which predicate is applied. You can use Swift’s string interpolation to place this in the predicate. 
> 3. Modify the predicate string parameter to be an enum such as `.beginsWith`, then make that enum get resolved to a string inside the initializer.
