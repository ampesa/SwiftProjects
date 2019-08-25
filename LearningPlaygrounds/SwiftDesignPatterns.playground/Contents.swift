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

