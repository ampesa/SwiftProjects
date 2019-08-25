import UIKit

// CLASSES
// This is a class. Classes are reference type types
class MyClass {
    
    var oneProperty: String
    
    init (oneProperty: String) {
        self.oneProperty = oneProperty
    }
    
    func oneFunction() {
        // code for the function here
    }
    
}

// STRUCTURES
// This is a structure. It does not need an initializer because it has a default one
// Structures are value type types
struct MyStruct {
    
    var oneProperty: String
    
    func oneFunction() {
        
    }
}

// ACCESS CONTROLS
// some access level examples
private struct EmployeeStruct {}
public var firstName = "Jon"
internal var lastName = "Hoffman"
private var salaryYear = 0.0
public func getFullName() -> String {
    let someString: String = "some string"
    return someString
    
}
fileprivate func giveBonus(amount: Double) {}
public func giveRaise(amaount: Double) {}

// Look for examples of when to use each one of the access control tags

// INHERITANCE (only for reference types)
// Define a parent or super class (Animal)
class Animal {
    
    var numberOfLegs = 0
    
    func sleeping() {
        print("zzzzz")
    }
    
    func walking() {
        print ("Walking on \(numberOfLegs) legs")
    }
    
    func speaking() {
        print ("No sound")
    }
}

// Defining some child or subclasses
class Biped: Animal {
    // This child class overrides parent initialization
    override init() {
        // get the parent initialization
        super.init()
        // define a new value for the numberOfLegs property
        numberOfLegs = 2
    }
}

class Quadruped: Animal {
    override init() {
        super.init()
        numberOfLegs = 4
    }
}

// we can define new child classes that inherit from previus childs
class Dog: Quadruped {
    override func speaking() {
        print("Barking")
    }
}

// create an instance of the Dog class
var myDog = Dog()

// call the class overrided method speaking()
myDog.speaking()
// call the inherit and original method sleeping
myDog.sleeping()
// call the inherit and overrided by the Quadruped class method walking
myDog.walking()

// DYNAMIC DISPATCH
// The appropiate implementation of the overrided and inheritance is performed at runtime, so be carefull about the runtime overhead of using complex class hierarchy with performance-sensitive applications

// When using class hierarchy is good practice to use the "final" keyword wherever possible to make direct calls to methods at runtime
class Animal2 {
    var numberOfLegs = 0
    // this functions cannot be overrided and its call at runtime will be direct, preventing overhead
    final func sleeping() {
        print("zzzzz")
    }
    // More methods here
}

// Its best practice using protocol-oriented design

