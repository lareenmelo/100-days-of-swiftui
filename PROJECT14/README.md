# Project #14 - BucketList

https://www.hackingwithswift.com/100/swiftui/68

> ...  an app that lets the user build a private list of places on the map that they intend to visit one day, add a description for that place, look up interesting places that are nearby, and save it all to the iOS storage for later.

## Topics
Comparable, operator overloading, FileManager, MVC, MapKit, LocalAuthentication, NSError, MKPointAnnotation, MKMapView

|Day 68 :white_check_mark: | Day 69 :white_check_mark: | Day 70 :white_check_mark: | Day 71 :white_check_mark: | Day 72 :white_check_mark: | Day 73 :white_check_mark: |
|:--|:--|:--|:--|:--|:--|
| learned about Comparable, operator overloading, FileManager, writing data to the documents directory, and handling a View's state using Enums.  | worked with MapKit, UIViewRepresentable, and LocalAuthentication (used it to work with Touch ID and Face ID). | worked more with MKMapView, MKPointAnnotation, got more comfortable with coordinators, and many MapKit delegate methods 😭. | continued with the project, we can now edit a location, and we added a section that displays nearby places to visit. This was used using URLSession to get data from Wikipedia. | worked with authentication today, now you have to use biometrics (if there's any) to access your saved locations and there's persistence (saving to the documents directory) | completed the challenges for the project. Added error handling (when biometrics fails there's an alert that shows an error message) and code cleanup! |
|  🗺  | ![D69](Data/D69.png)| ![D70](https://user-images.githubusercontent.com/12801333/124700638-0ccdda00-debb-11eb-9092-560b34e0d472.mp4) | ![D71](https://user-images.githubusercontent.com/12801333/124851051-c6868280-df6f-11eb-8591-f29dae21fc92.mp4)| ![D72](https://user-images.githubusercontent.com/12801333/125012853-df0e9f80-e038-11eb-85a5-63f099639ad0.mp4) | ![D74](https://user-images.githubusercontent.com/12801333/125153749-ebbbf200-e123-11eb-8c57-54c53472c1f7.mp4) |  

## Challenges

From [Hacking with Swift](https://www.hackingwithswift.com/books/ios-swiftui/bucket-list-wrap-up):
>1. Our + button is rather hard to tap. Try moving all its modifiers to the image inside the button – what difference does it make, and can you think why?
>2. Having a complex `if` condition in the middle of `ContentView` isn’t easy to read – can you rewrite it so that the `MapView`, `Circle`, and `Button` are part of their own view? This might take more work than you think!
>3. Our app silently fails when errors occur during biometric authentication. Add code to show those errors in an alert, but be careful: you can only add one `alert()` modifier to each view.


| locked screen | unlocked screen - locations |
|:--:|:--:|
|<img width="516" alt="locked" src="https://user-images.githubusercontent.com/12801333/125153950-3853fd00-e125-11eb-9cb4-612bf6914cf4.png"> | <img width="516" alt="unlocked" src="https://user-images.githubusercontent.com/12801333/125153956-47d34600-e125-11eb-8194-b6dfb3eb00da.png"> |
