import UIKit

// DELEGATION

// protocol defines the delegate's responsabilities
protocol DisplayNameDelegate {
    // delegate needs to implement this method
    func displayName (name: String)
    
}

// This structure uses the delegate
struct Someone {
    
    // an instance of the protocol
    var displayNameDelegate: DisplayNameDelegate
    
    // properties definitions with property observers. Everytime property changes displayName method from the delegate will be call taking the returning string of the method getFullName() as its parameter
    var firstName = "" {
        didSet {
            displayNameDelegate.displayName(name: getFullName())
        }
    }
    
    var lastName = "" {
        didSet {
            displayNameDelegate.displayName(name: getFullName())
        }
    }
    
    // initialization of the delegate
    init (displayNameDelegate: DisplayNameDelegate) {
        self.displayNameDelegate = displayNameDelegate
    }
    
    // function that returns a string with the concatenation of the name and the last name
    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}

// Definition of the delegate type
struct MyDisplayNameDelegate: DisplayNameDelegate {
    // implementation of the displayName() method to conform the protocol. Receives a string and print it as the Name: ...
    func displayName(name: String) {
        print("Name: \(name)")
    }
}

// instance of the protocol type
var displayDelegate = MyDisplayNameDelegate()
// Create an instance of Someone type using the protocol instance
var someone = Someone(displayNameDelegate: displayDelegate)

// Name is set, so name may be prited out to the console
someone.firstName = "Jon"
// last name is set, so name and last name may be printed
someone.lastName = "Hoffman"

// name has changed, so the new name and de previous last name may be printed
someone.firstName = "Maria"

