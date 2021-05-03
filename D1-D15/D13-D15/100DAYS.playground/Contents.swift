import UIKit

// Arrays
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]

// Sets
let colors = Set(["red", "blue", "yellow"])
let colors2 = Set(["red", "blue", "yellow", "yellow"]) // duplicates get ignore as set's items must be unique

// Tuples
var name = (first: "Taylor", second: "Swift")
name.0
name.1
name.first

// Dictionaries
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
heights["Taylor Swift"] // when using type annotations dictionaries are defined like let heights: [String: Double]

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

favoriteIceCream["Charlotte"]
favoriteIceCream["Charlotte", default: "Unknown"] // default value to prevent nils from non-existent keys

// Enums
enum Result {
    case success
    case failure
}

let result = Result.failure

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "music") // associated values

enum Planet: Int { // raw values
    case mercury = 1
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 3) // they start from 0 automatically thnks to Swift, unless specifically defined like we did


// Exiting multiple loops
outerLoop: for i in 1...10 { // add alias to our outer loop
    for j in   1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop // to exit both loops
            // to exit just inner loop, a regular break would sufice
        }
    }
}


print("Haters", "gonna", "hate")
// Throwing Functions

enum PasswordError: Error {
    case obvious
}

// throws enum error if something goes wrong
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

// Optional Try

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}


// CLOSURES
// Bah-sic Closure
let driving = {
    print("I'm driving in my car")
}

driving()

// Accepting Parameters in a Closure
let drivingAgain = { (place: String) in
    print("I'm going to \(place) in my car")
    
}

drivingAgain("London")

// Returning Values From a Closure
let drivingWithReturn = { (place: String) -> String in
    return "I am going to \(place) in my car"
    
}

let message = drivingWithReturn("Canada")
print(message)

// Closures As Parameters
func travel(action: () -> Void) {
    print("I am getting ready to go.")
    action()
    print("I arrived")
}

travel(action: driving)

travel {
    print("I'm driving in my carz")
}


func animate(duration: Double, animations: () -> Void) {
    print("Starting a \(duration) second animation…")
    animations()
}

animate(duration: 3) {
    print("Fade out the image")
}

func travel(action: (String) -> Void) {
    print("I am getting ready to go.")
    action("London")
    print("I arrived")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}

func travel(action: (String) -> String) {
    print("I am getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}


// Shorthand parameter names
travel { place in
    "I'm going to \(place) in my car"
}

travel
{
    "I'm going to \($0) in mt car"
    
}

func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

travel {
    "I'm going to \($0) at \($1) miles per hour"
}

//func travel() -> (String) -> Void {
//    return {
//        print("I'm going to \($0)")
//    }
//}
//
//let resultz = travel() // travel returns back the closure
//resultz("California")


// Closure Capturing
func travel() -> (String) -> Void {
    var counter = 1 // variable
    return {
        print("I'm going to \($0)")
        counter += 1 // being used inside the closure, it gets captured. So it will remain alive for that closure
    }
}

let resultsz = travel()
resultsz("California")
resultsz("California")
resultsz("California")


// Structures
struct Sport { //creates a type
    var name: String //name property
    var isOlympicSport: Bool
    
    var olympicStatus: String { // computed property
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

var chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

// Property Observers
struct Progress {
    var task: String
    var amount: Int {
        didSet { // willSet takes action before the change
            print("\(task) is now at \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
print(london.collectTaxes())

// Mutating Methods

struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()

// Because it changes the property Swift will only allow this method to be called
// on Person instances that are vars


let string = "Do or do not, there is no try."
print(string.count) // property
print(string.hasPrefix("Do")) // methods
print(string.uppercased())


var toys = ["Woody"]
print(toys.count) // property
toys.append("Buzz") // method

var fibonacci = [1, 1, 2, 3, 5, 8]
fibonacci.sorted() == [1, 2, 3, 5, 8]

let movies = ["A New Hope", "Empire Strikes Back", "Return of the Jedi"]
movies.firstIndex(of: "A New Hope") == 4


struct Usezr {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")

    }
}

// var user = User(username: "twostraws") - memberwise initalizer

var user = Usezr()
user.username = "twostraws"

struct FamilyTree {
    init() {
        print("Creating a family tree!")
    }
}


struct Persona {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
}

var ed = Persona(name: "Ed")
ed.familyTree // to print creating a family tree!

struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}


let eddy = Student(name: "Eddy")
let taylor = Student(name: "Taylor")

print(Student.classSize)


// Class

//Inheritance
//class Dog {
//    var name: String
//    var breed: String
//
//    init(name: String, breed: String) {
//        self.name = name
//        self.breed = breed
//    }
//}
//
//class Poodle: Dog {
//    init(name: String) {
//        super.init(name: name, breed: "Poodle")
//    }
//}

class Dogz {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodlez: Dogz {
    override func makeNoise() {
        print("Yip!")
    }
}


// Protocols
// P. Inheritance
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(day: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }


// Extensions
extension Int {
    func squared() -> Int {
        return self * self
    }
    
    // computed property
    var isEven: Bool {
        return self % 2 == 0
    }
}

let number = 8
number.squared()

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatlez = Set(["John", "Paul", "George", "Ringo"])

// both arrays and sets conform to the Collection protocol

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()


protocol Identifiable {
    var id: String { get set }
    func identify()
}

extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}


struct User: Identifiable {
    var id: String
}

let twostraws = User(id: "twostrings")
twostraws.identify()

// Optionals

var namee: String? = nil
if let unwrapped = namee {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}


// Implicitly Unwrapped Optionals
let agez: Int! = nil

// Nil-Coalescing Operator ??
// let username = username(for: 15) ?? "Anonymous"


// Typecasting
class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]


for pet in pets {
    if let dog = pet as? Dog { // typecasting
        dog.makeNoise()
    }
}
