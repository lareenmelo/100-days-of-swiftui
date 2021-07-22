# Project #16 - HotProspects

https://www.hackingwithswift.com/100/swiftui/79

> ... an app to track who you meet at conferences.

## Topics
EnvironmentObjects, TabView, Tags, Result, objectWillChange, image interpolation, contextMenu, UserNotifications, Swift Package Manager (SPM), Semantic Versioning, textContentType, fileprivate(set)

| Day 79 :white_check_mark: | Day 80 :white_check_mark: | Day 81 :white_check_mark: | Day 82 :white_check_mark: | Day 83 :white_check_mark: | Day 84 :white_check_mark: | Day 85 :white_check_mark: |
|:--|:--|:--|:--|:--|:--|:--|
| worked with Environment Objects and custom values and, learned how to use a TabView | dived deeper into Swift's Return type, learned about objectWillChange and image interpolation | officially started the HotProspects project. Created its tab bar, reviewed custom values and EnvironmentObjects. Here's the projects layout so far. | officially started the HotProspects project. Created its tab bar, reviewed custom values and EnvironmentObjects. | learned about the textContentType modifier for TextFields, declared a  fileprivate(set) var (felt like a pro while at it), and implemented the QR functionality. | added persistence to the app using UserDefaults, structured our architecture in a safer way, and implemented another context action and notifications  | challenge day!!! Completed the 3 challenges. I feel like the challenges are usually sorted in order of difficulty, but today the second challenge had me 💀. Also, added mock data to the app.  |
| ![D79](Data/D79.png) | 💆‍♀️ | ![D81](Data/D81.png) | ![D82](https://user-images.githubusercontent.com/12801333/126087570-d7078bd7-66cf-4b93-b564-bafc0017a447.mp4) | ![D83](https://user-images.githubusercontent.com/12801333/126257202-0704de74-1448-4bde-812d-9f98c37342ac.mp4) | ![D84](https://user-images.githubusercontent.com/12801333/126407508-2e35386b-13b3-44ea-9183-6296623acb6e.mp4) | ![D85](https://user-images.githubusercontent.com/12801333/126584363-e97897ce-4003-4cb6-8d07-863300323613.mp4) |

## Challenges

From [Hacking with Swift](https://www.hackingwithswift.com/books/ios-swiftui/hot-prospects-wrap-up):
>1. Add an icon to the “Everyone” screen showing whether a prospect was contacted or not.
>2. Use JSON and the documents directory for saving and loading our user data.
>3. Use an action sheet to customize the way users are sorted in each screen – by name or by most recent.

| main list| contacted list | uncontacted list | sort feature | settings view | notification | 
|:--:|:--:|:--:|:--:|:--:|:--:|
| ![main](https://user-images.githubusercontent.com/12801333/126584552-fdf3e259-fa54-4af7-9fb4-57cac7229be9.png) |![contacted](https://user-images.githubusercontent.com/12801333/126584564-11fb6b91-bf15-485a-b7f5-4aecd9c38e8b.png) |![uncontacted](https://user-images.githubusercontent.com/12801333/126584575-0cbdb18e-8534-4f1f-a8ed-3efc3c9c534a.png) | ![actions](https://user-images.githubusercontent.com/12801333/126584598-af6b4abe-6dcb-4c58-9a2e-bf86ce1fe0b1.png) | ![me](https://user-images.githubusercontent.com/12801333/126584618-f8e67288-9539-4c83-b274-79cb229463fe.png) | ![notification](https://user-images.githubusercontent.com/12801333/126584631-81bc5d61-6a6d-49ab-8421-b37b8f1ce8a2.png)|
