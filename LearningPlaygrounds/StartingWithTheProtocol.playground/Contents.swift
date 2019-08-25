import UIKit

protocol MyProtocol {
    // protocol definition here
}

struct MyStruct: MyProtocol {
    // structure implementation here
}

protocol FullName {
    
    // some read-write properties
    var firstName: String { get set }
    var lastName: String { get set }
    
    // some read-only property
    var readOnly: String { get }
    
    // some static property
    static var typeProperty: String { get }
    
    // defining some method within the protocol
    func getFullName() -> String
    
    // method allowed to modify the instance it belongs to "mutating"
    mutating func changeName()
    
}

// protocol optional requirements, only for classes
@objc protocol Phone {
    
    // read-write property
    var phoneNumber: String { get set }
    
    // optional property
    @objc optional var emailAddress: String { get set }

    // method
    func dialNumber()
    
    // optional method
    @objc optional func getEmail()
    
}

// Protocol Inheritance
// Protocol Person iherits from protocol FullName
protocol FullName2 {
    
    var firstName: String { get set }
    var lastName: String { get set }
    
}

protocol Person: FullName2 {
    
    var age: Int { get set }
    
}

// Student structure must conforme both Person and FullName protocol requirements
struct Student: Person {
    
    // initializing properties conforming protocol
    var firstName = ""
    var lastName = ""
    var age = 0
    
    
    // implementation of the FullName protocol method returns concatenation of vars first and lastName
    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
}

// Protocols as a TYPE
protocol HumanBeing {
    var firstName: String { get set }
    var lastName: String { get set }
    var birthDate: Date { get set }
    var profession: String { get }
    init ( firstName: String, lastName: String, birthDate: Date )
}

func upadateHumanBeing (person: HumanBeing) -> HumanBeing {
    
    var newPerson: HumanBeing
    
    // Add some code to update person
    
    return newPerson
    
}

// protocols as a type to store in collections
var personArray = [HumanBeing]()
var personDict = [String: HumanBeing]()

var person: HumanBeing

class SwiftProgrammer: HumanBeing {
    
    var firstName: String
    var lastName: String
    var birthDate: Date
    var profession: String
    
    required init(firstName: String, lastName: String, birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
}

class FootballPlayer: HumanBeing {
    var firstName: String
    var lastName: String
    var birthDate: Date
    var profession: String
    
    required init(firstName: String, lastName: String, birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
}

person = SwiftProgrammer (firstName: "Jon", lastName: "Hoffman", birthDate: Date)
person = FootballPlayer (firstName: "Dan", lastName: "Marino", birthDate: Date)

// Using Person protocol as a type for an array
var programmer = SwiftProgrammer (firstName: "Jon", lastName: "Hoffman", birthDate: Date)
var player = FootballPlayer (firstName: "Dan", lastName: "Marino", birthDate: Date)
var people: [Person] = []
people.append(programmer)
people.append(player)


// Type-casting. Checking if an instance is or not of a concrete type (is). Treat an instance (as) a especific type
if person is SwiftProgrammer {
    print ("(person.firstname) is a Swift Programmer")
}

for person in people where person is SwiftProgrammer {
    print("(person.firstName) is a Swift Programmer")
}

if let _ = person as? SwiftProgrammer {
    print("(person.firstName) is a Swift Programmer")
}

// Associated Type. Define protocol Queue with associatedtype and use it in two methods
protocol Queue {
    associatedtype QueueType
    mutating func addItem (item: QueueType)
    mutating func getItem() -> QueueType?
    func count() -> Int
}

// Implemetation of Queue protocol in a non generic class using the integer type as the associated type
struct IntQueue: Queue {
    var items = [Int] ()
    mutating func addItem(item: Int) {
        items.append(item)
    }
    mutating func getItem() -> Int? {
        if items.count > 0 {
            return items.remove(at: 0)
        }
        else {
            return nil
        }
    }
    func count() -> Int {
        return items.count
    }
}





