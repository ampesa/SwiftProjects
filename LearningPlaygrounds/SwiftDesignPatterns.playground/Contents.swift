import UIKit

/**DESIGN PATTERNS IN SWIFT

 - Design patterns are strategies that have already been proven to solve several common software developement problems.

 - There are three design patterns categories:
    · Creational patterns support the creation of objects
    · Structural patterns concern types and object composition
    · Behavioral patterns communicate between types
*/

// CREATIONAL PATTERNS (how an object is created)
// Encapsulate the knowledge of whic concrete types should be created and hide how its insntances are created

// THE SINGLETONE PATTERN
// Useful when the state of an object must be maintained throughout the lifecycle of the application.

class MySingleton {
    // Static constant than contains an instance of MySingleton class. Can be called without instantiating the class. As a static constant only one instance will exist throughout the application lifecyle
    static let sharedInstance = MySingleton()
    var number = 0
    // The private initiator will prevent external code from creating another instance
    private init() {}
}

// How it works
var singleA = MySingleton.sharedInstance
var singleB = MySingleton.sharedInstance
var singleC = MySingleton.sharedInstance

// All the variables are pointing to the same instance. If we change the number property all three variables will get the new number
singleB.number = 2

print(singleA.number)
print(singleB.number)
print(singleC.number)

singleC.number = 3

print(singleA.number)
print(singleB.number)
print(singleC.number)


// THE BUILDER DESIGN PATTERN
// Complex structure without the builder pattern
struct BurgerOld {
    // Burguer properties
    var name: String
    var patties: Int
    var bacon: Bool
    var cheese: Bool
    var pickles: Bool
    var ketchup: Bool
    var mustard: Bool
    var lettuce: Bool
    var tomato: Bool
    // Initializator
    init(name: String, patties: Int, bacon: Bool, cheese: Bool, pickles: Bool, ketchup: Bool, mustard: Bool, lettuce: Bool, tomato: Bool) {
        self.name = name
        self.patties = patties
        self.bacon = bacon
        self.cheese = cheese
        self.pickles = pickles
        self.ketchup = ketchup
        self.mustard = mustard
        self.lettuce = lettuce
        self.tomato = tomato
    }
}

// The BurguerOld structure force us to complex initializations of its instances
// Create hamburguer
var burgerOld = BurgerOld(name: "Hamburguer", patties: 1, bacon: false, cheese: false, pickles: false, ketchup: false, mustard: false, lettuce: false, tomato: false)

// Create cheeseburguer
var cheeseBurgerOld = BurgerOld(name: "Cheeseburguer", patties: 1, bacon: false, cheese: true, pickles: false, ketchup: false, mustard: false, lettuce: false, tomato: false)

// Burguers with builder pattern. The protocol defines the properties that will be required for any type conforming it.
protocol BurgerBuilder {
    var name: String { get }
    var patties: Int { get }
    var bacon: Bool { get }
    var cheese: Bool { get }
    var pickles: Bool { get }
    var ketchup: Bool { get }
    var mustard: Bool { get }
    var lettuce: Bool { get }
    var tomato: Bool { get }
}

// Now create the builders as structures that implement the BurguerBuilder protocol and define de valuse for the required properties
struct HamburguerBuilder: BurgerBuilder {
    let name = "Burger"
    let patties = 1
    let bacon = false
    let cheese = false
    let pickles = true
    let ketchup = true
    let mustard = true
    let lettuce = false
    let tomato = false
}

struct CheeseBurgerBuilder: BurgerBuilder {
    let name = "Cheeseburger"
    let patties = 1
    let bacon = false
    let cheese = true
    let pickles = true
    let ketchup = true
    let mustard = true
    let lettuce = false
    let tomato = true
}

struct Burger {
    var name: String
    var patties: Int
    var bacon: Bool
    var cheese: Bool
    var pickles: Bool
    var ketchup: Bool
    var mustard: Bool
    var lettuce: Bool
    var tomato: Bool
    
    init (builder: BurgerBuilder) {
        self.name = builder.name
        self.patties = builder.patties
        self.bacon = builder.bacon
        self.cheese = builder.cheese
        self.pickles = builder.pickles
        self.ketchup = builder.ketchup
        self.mustard = builder.mustard
        self.lettuce = builder.lettuce
        self.tomato = builder.tomato
    }
    
    func showBurger() {
        print("Name: \(name)")
        print("Patties: \(patties)")
        print("Bacon: \(bacon)")
        print("Cheese: \(cheese)")
        print("Pickles: \(pickles)")
        print("Ketchup: \(ketchup)")
        print("Mustard: \(mustard)")
        print("Lettuce: \(lettuce)")
        print("Tomato: \(tomato)")
    }
}

// Now the initializer takes only one argument, not nine.
var myBurger = Burger(builder: HamburguerBuilder())
myBurger.showBurger()

var myCheeseBurger = Burger(builder: CheeseBurgerBuilder())
myCheeseBurger.showBurger()

// Modifying properties. If you don't like tomatos you can hold them
myCheeseBurger.tomato = false
myCheeseBurger.showBurger()

// Using the builder design pattern in a single builder type way. This builder type sets all the configurable options to default values that can be changed later as needed
struct BurgerSingleBuilder {
    // default properties
    var name = "Burger"
    var patties = 1
    var bacon = false
    var cheese = false
    var pickles = true
    var ketchup = true
    var mustard = true
    var lettuce = false
    var tomato = false
    
    // set methods to change properties
    mutating func setPatties (choice: Int) { self.patties = choice}
    mutating func setBacon (choice: Bool) { self.bacon = choice}
    mutating func setCheese (choice: Bool) { self.cheese = choice}
    mutating func setPickles (choice: Bool) { self.pickles = choice}
    mutating func setKetchup (choice: Bool) { self.ketchup = choice}
    mutating func setMustard (choice: Bool) { self.mustard = choice}
    mutating func setLettuce (choice: Bool) { self.lettuce = choice}
    mutating func setTomato (choice: Bool) { self.tomato = choice}
    
    // method for creating new instances based on the BurguerOld structure but using the default values defined in the BurguerSingleBuilder
    func buildBurguerOld (name: String) -> BurgerOld {
        return BurgerOld (name: name, patties: self.patties, bacon: self.bacon, cheese: self.cheese, pickles: self.pickles, ketchup: self.ketchup, mustard: self.mustard, lettuce: self.lettuce, tomato: self.tomato)
    }
}

var burgerBuilder = BurgerSingleBuilder()
burgerBuilder.setCheese(choice: true)
burgerBuilder.setBacon(choice: true)
var jonBurger = burgerBuilder.buildBurguerOld(name: "Jon's Burger")



// THE FACTORY METHOD PATTERN
// Used when there are multiple types that conform to a single protocol and the appropiate one to instantiate needs to be chosen at runtime
// In this implementation of the Factory Method Pattern we are defining some text validation types and a function will be responsible of determine which text validation type to use
// Protocol define two string properties. The first to be used for text valitation and the second to be used for prompt a message
protocol TextValidation {
    var regExFindMatchString: String { get }
    var validationMessage: String { get }
}

// Extension of the protocol. Contains a computed property, the method to validate the string and a method that returns the part of the string that matches with de RegEx
extension TextValidation {
    var regExMatchingString: String {
        get {
            return regExFindMatchString + "$"
        }
    }
    
    func validateString(str: String) -> Bool {
        if let _ = str.range(of: regExMatchingString, options: .regularExpression) {
            return true
        } else {
            return false
        }
    }
    
    func getMatchingString(str: String) -> String? {
        if let newMatch = str.range(of: regExMatchingString, options: .regularExpression) {
            return String(str[newMatch])
        } else {
            return nil
        }
    }
}

// Class for alpha characters
class AlphaValidation: TextValidation {
    static let sharedInstance = AlphaValidation()
    private init() { }
    let regExFindMatchString = "^[a-zA-Z]{0,10}"
    let validationMessage = "Can only contain Alpha characters"
}

// Class for alpha and numeric characters
class AlphaNumericValidation: TextValidation {
    static let sharedInstance = AlphaNumericValidation()
    private init() { }
    let regExFindMatchString = "^[a-zA-z0-9]{0,10}"
    let validationMessage = "Can only contain Alpha Numeric characters"
}

// Class for numeric characters only
class NumericValidation: TextValidation {
    static let sharedInstance = NumericValidation()
    private init() { }
    let regExFindMatchString = "^[0-9]{0,10}"
    let validationMessage = "Display Name can contain a maximum of 10 Numeric Characters"
}

func getValidatorFactory(aphaCharacters: Bool, numericCharacters: Bool) -> TextValidation? {
    if aphaCharacters && numericCharacters {
        return AlphaNumericValidation.sharedInstance
    } else if aphaCharacters && !numericCharacters {
        return AlphaValidation.sharedInstance
    } else if !aphaCharacters && numericCharacters {
        return NumericValidation.sharedInstance
    } else {
        return nil
    }
}

// Alphanumeric String
var str = "abc123"

// Use of getValidatorFactory. First to check if only contains alpha characters. Second to check if contains alpha and numeric characters
var validator1 = getValidatorFactory(aphaCharacters: true, numericCharacters: false)
print("String validated: \(validator1!.validateString(str:str))")

// This one will validate to true
var validator2 = getValidatorFactory(aphaCharacters: true, numericCharacters: true)
print("String validated: \(validator2!.validateString(str: str))")



// STRUCTURAL DESIGN PATTERNS

// THE BRIDGE PATTERN
// This pattern is very useful when we have two hierarchies that closely interact together. We can put this interaction logic into a bridge type that will encapsulate the logic in one spot. This way, when there are new requirements, we can make the change in this one spot without refactoring all the code.

// The two hierarchies
protocol Message {
    var messageString: String { get set }
    init (messageString: String)
    func prepareMessage()
}

protocol Sender {
    var message: Message? { get set }
    func verifyMessage()
    func sendMessage()
}


// Types that conform to the message protocol
class PlainTextMessage: Message {
    var messageString: String
    required init(messageString: String) {
        self.messageString = messageString
    }
    func prepareMessage() {
        // Nothing to do
    }
}

class DESEncryptedMessge: Message {
    var messageString: String
    required init(messageString: String) {
        self.messageString = messageString
    }
    func prepareMessage() {
        // Encript message will go here
        self.messageString = "DES: " + self.messageString
    }
}

// Types that conform to de Sender protocol
class EmailSender: Sender {
    var message: Message?
    func verifyMessage() {
        print("Verifying E-Mail message")
    }
    func sendMessage() {
        print("Sending through E-Mail: \n \(message!.messageString)")
    }
}

class SMSSender: Sender {
    var message: Message?
    func verifyMessage() {
        print("Verifying SMS message")
    }
    func sendMessage() {
        print("Sending through SMS: \n \(message!.messageString)")
    }
}

// Instances of the two hierarchies interacting together
var firstMessage = PlainTextMessage(messageString: "This is a plain text message")
firstMessage.prepareMessage()
var sender1 = SMSSender()
sender1.message = firstMessage
sender1.verifyMessage()
sender1.sendMessage()

var sender2 = EmailSender()
sender2.message = firstMessage
sender2.verifyMessage()
sender2.sendMessage()

var secondMessage = DESEncryptedMessge(messageString: "Encrypted message")
secondMessage.prepareMessage()
sender1.message = secondMessage
sender1.verifyMessage()
sender1.sendMessage()
sender2.message = secondMessage
sender2.verifyMessage()
sender2.sendMessage()

// Everytime that there are new requirements we need to make changes to mofify protocol and types conforming that new requirement. Here come the bridge to help us to deal with this problem.
struct MessagingBridge {
    static func sendMessage(message: Message, sender: Sender) {
        var sender = sender
        message.prepareMessage()
        sender.message = message
        sender.verifyMessage()
        sender.sendMessage()
    }
}

var myBridge = MessagingBridge()
type(of: myBridge).sendMessage(message: firstMessage, sender: sender2)


// THE FACADE PATTERN
// If you have several APIs that are working closely together to perform a task, the facade pattern should be considered

// Defining three APIs
// The Hotel API
struct Hotel {
    // Information about hotel room
}

struct HotelBooking {
    static func getHotelNameForDates(to: NSDate, from:NSDate) -> [Hotel]? {
        let hotels = [Hotel]()
        // logic to get hotels
        return hotels
    }
    
    static func bookHotel(hotel: Hotel) {
        // logic to reserve hotel room
    }
}

// The Flight API
struct Flight {
    // Information about flights
}

struct FlightBooking {
    static func getFlightNameForDates(to: NSDate, from: NSDate) -> [Flight]? {
        let flights = [Flight]()
        // logic to get the flights
        return flights
    }
    
    static func bookFlight(flight: Flight) {
        // logic to book flights
    }
}

// The rental cars API
struct RentalCar {
    // Information of the cars for rent
}

struct RentalCarBooking {
    static func getRentalCarNameForDates(to: NSDate, from: NSDate) -> [RentalCar]? {
        let cars = [RentalCar]()
        // logic to get flights
        return cars
    }
    
    static func bookRentalCar(rentalCar: RentalCar) {
        // logic to rent a car
    }
}


// Implementing the Facade Pattern. Contains functionality to search in the three APIs and to book on all of them too.
struct TravelFacade {
    
    var hotels: [Hotel]?
    var flights: [Flight]?
    var cars: [RentalCar]?
    
    init (to: NSDate, from: NSDate) {
        hotels = HotelBooking.getHotelNameForDates(to: to, from: from)
        flights = FlightBooking.getFlightNameForDates(to: to, from: from)
        cars = RentalCarBooking.getRentalCarNameForDates(to: to, from: from)
    }
    
    func bookTrip(hotel: Hotel, flight: Flight, rentalCar: RentalCar) {
        HotelBooking.bookHotel(hotel: hotel)
        FlightBooking.bookFlight(flight: flight)
        RentalCarBooking.bookRentalCar(rentalCar: rentalCar)
    }
}



// THE PROXI DESIGN PATTERN
// In the proxy design pattern one type act as an interface for another type, as a wrapper type allowing us add functionality, hide the implementation of the API or restrict access to the object
// The main problems to solve with the proxy pattern are: to put an abstraction layer between the code and the API (usually a remote API) or when you need to change an API but you don't have the code or is better not changing it because there are some dependencies on the API elsewhere in the application
// This is an implementation of the proxi pattern for accessing the iTunes API. If anything changes in the iTunes API, we only have to change one type and not all the code of our application that uses the API.
// Using a closure to return the results. The networking part of the code will be asynchronous and the closure will return the results when iTunes API returns the results
public typealias DataFromURLCompletionClosure = (Data?) -> Void

// The proxy implementation
public struct ITunesProxy {
    // this method get a string with the search term as a parameter and use the previous typealias to hold the data with the results
    public func sendGetRequest (searchTerm: String, _ handler: @escaping DataFromURLCompletionClosure) {
        
        // a constant with the session configuration wich will use URL default configuration
        let sessionConfiguration = URLSessionConfiguration.default
        
        // property to hold the url information
        var url = URLComponents()
        url.scheme = "https"
        url.host = "itunes.apple.com"
        url.path = "/search"
        
        // query items for the url to pass to the API
        url.queryItems = [ URLQueryItem(name: "term", value: searchTerm) ]
        
        // If url is valid url
        if let queryUrl = url.url {
            // the request variable will hold the url to query the API
            var request = URLRequest(url: queryUrl)
            // the method to use the API is GET (other methods could be "PUT" or "POST"...)
            request.httpMethod = "GET"
            // create an url session using the session configuration previously defined
            let urlSession = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: nil)
            // create a session data task with request url that will hold the results and pass them to the data handler
            let sessionTask = urlSession.dataTask(with: request) {
                (data, response, error) in handler(data)
            }
            // end session data task and communication with the API. Is good practice to close a connection when the task that connection was created to acomplish is finished
            sessionTask.resume()
        } // end of if statement
    } // end of public func sendGetRequest
} // end of ITunesProxy struct


// Using the proxy to access the iTunes API
let proxy = ITunesProxy()
proxy.sendGetRequest(searchTerm: "jimmy+hendrix", {
    if let data = $0, let sString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
        print(sString)
    } else {
        print("Data is nil")
    }
})



// BEHAVIORAL DESIGN PATTERNS

