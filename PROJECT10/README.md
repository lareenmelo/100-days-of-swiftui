# Project #10 - CupcakeCorner

https://www.hackingwithswift.com/100/swiftui/49

> ... a multi-screen app for ordering cupcakes

## Topics
Codable, URLSession, DispatchQueue, disabled(), GeometryReader

|Day 49 :white_check_mark: | Day 50 :white_check_mark: | Day 51 :white_check_mark: | Day 52 :white_check_mark: |
|:--|:--|:--|:--|
| really learned what property wrappers are, Codable conformance for Published properties, URLSession, DispatchQueue, and disabling forms | started the project and worked with GeometryReader again | used URLSession and conformed published property wrappers to codable, concluded walkthrough of the project  |    |
| :woman_technologist: |![D50](https://user-images.githubusercontent.com/12801333/120259608-48450b00-c262-11eb-9a7c-f068d07cc7a1.mov)|![D51](https://user-images.githubusercontent.com/12801333/120406458-e4c9e480-c318-11eb-80f4-96901bd1c386.mov)|![D52](https://user-images.githubusercontent.com/12801333/120585662-27b2b780-c400-11eb-9081-f7d129a370d0.mov)|

## Challenges

From [Hacking with Swift](https://www.hackingwithswift.com/books/ios-swiftui/cupcake-corner-wrap-up):
>1. Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
>2. If our call to `placeOrder()` fails – for example if there is no internet connection – show an informative alert for the user. To test this, just disable WiFi on your Mac so the simulator has no connection either.
>3. For a more challenging task, see if you can convert our data model from a class to a struct, then create an `ObservableObject` class wrapper around it that gets passed around. This will result in your class having one `@Published` property, which is the data struct inside it, and should make supporting `Codable` on the struct much easier.

|before challenges| after challenges|
|:--|:--|
|![D51](https://user-images.githubusercontent.com/12801333/120406458-e4c9e480-c318-11eb-80f4-96901bd1c386.mov)|![D52](https://user-images.githubusercontent.com/12801333/120585662-27b2b780-c400-11eb-9081-f7d129a370d0.mov)|
