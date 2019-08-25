import UIKit

// GENERIC FUNCTIONS
// Single generic function for swapping two values
func swapGeneric<T>(a: inout T, b: inout T) {
    let tmp = a
    a = b
    b = tmp
}

// Is a good practice to use T to define a generic placeholder
// Using the previous generic function with integer types
var a = 5
var b = 10
swapGeneric(a: &a, b: &b)
print("a: \(a) b: \(b)")

// Using the generic function with String types
var c = "My first string"
var d = "My second string"
swapGeneric(a: &c, b: &d)
print("c: \(c) ; d: \(d)")

// The type of the first parameter determines the type of all of the parameters in that function

// Using generic with different types
func testGeneric<T, E> (a:T, b:E) {
    print("\(a) \(b)")
}
testGeneric(a: b, b: d)

// TYPE CONSTRAINTS WITH GENERIC FUNCTIONS
// Type constraint specifies that a generic type must inherit from a class or conform to a protocol
func testGenericComparable<T: Comparable> (a: T, b: T) -> Bool {
    return a == b
}

testGenericComparable(a: c, b: d)

// Declaring multiple constraints
func multipleConstraints<T: Comparable, E: Equatable> (a: T, b: E) {
    // here some code with the parameters
}


// GENERIC TYPES
// This is a generic structure. A list to hold items of any type
struct List<T> {
    // Adding the backend Storage Array
    var items = [T]()
    
    // The method to add items
    mutating func add(item: T) {
        items.append(item)
    }
    
    // Method to return items
    func getItemAtIndex(index: Int) -> T? {
        // If the total elements in the list is greater than the index passed as parameter, then there is an elemente at that index and the method return it. If not, return nil
        if items.count > index {
            return items[index]
        } else {
            return nil
        }
    }
    // Subscript that calls the method getItemAtIndex using an Int as the parameter
    public subscript(index: Int) -> T? {
        return getItemAtIndex(index: index)
    }
}

// Creating instances of the generic structure
var stringList = List<String>()
var intList = List<Int>()
class MyObject {}
var customList = List<MyObject>()

// Generic class
class GenericClass<T> {}

// Generic enumeration
enum GenericEnum<T> {}

// Using the generic List type
stringList.add(item: "Good")
stringList.add(item: "Morning!")

print(stringList.getItemAtIndex(index: 0)! + " " + stringList.getItemAtIndex(index: 1)!)

// using the subscript to access items
print(stringList[0]! + " " + stringList[1]!)

// Generic Types with multiple placeholders
class MyClass <T, E> {}

var mc = MyClass<String, Int>()

// Generic Types with multiple placeholders and type constranints
struct MyStruct <T: Comparable, E: Equatable> {}


// ASSOCIATED TYPES. GENERIC TYPES IN PROTOCOL-ORIENTED PROGRAMMING
protocol MyProtocol {
    // specify an associated type with the "associatedtype" keyword
    associatedtype E
    // defining a property as an array of items of the associatedtype
    var items: [E] {get set}
    // creating the add function using the associatedtype
    mutating func add(item: E)
}

// Creating types that conform to the protocol
struct MyIntType: MyProtocol {
    var items: [Int] = []
    mutating func add(item: Int) {
        items.append(item)
    }
}

// Generic type that conforms to the MyProtocol protocol
struct MyGenericType<T>: MyProtocol {
    var items: [T] = []
    mutating func add(item: T) {
        items.append(item)
    }
    func getItemAtIndex(index: Int) -> T? {
        if items.count > index {
            return items[index]
        } else {
            return nil
        }
    }
}

// GENERIC SUBSCRIPTS

struct List2<T> {
    // Adding the backend Storage Array
    var items = [T]()
    
    // The method to add items
    mutating func add(item: T) {
        items.append(item)
    }
    
    // Method to return items
    func getItemAtIndex(index: Int) -> T? {
        // If the total elements in the list is greater than the index passed as parameter, then there is an elemente at that index and the method return it. If not, return nil
        if items.count > index {
            return items[index]
        } else {
            return nil
        }
    }
    
    // Subscript that calls the method getItemAtIndex using an Int as the parameter
    public subscript(index: Int) -> T? {
        return getItemAtIndex(index: index)
    }
    
    // Defining generic types within the subscript definition itself. Function returns an array of elements of the defined type corresponding to a sequence of indices
    public subscript<E: Sequence>(indices: E) -> [T] where E.Iterator.Element == Int {
        var result = [T]()
        for index in indices {
            result.append(items[index])
        }
        return result
    }
}

// Using the subscript. Create an instance of the List2 structure of the type Int
var aList = List2<Int>()

// Fullfill the array with integer values from 1 to 10
for i in 1...10 {
    aList.add(item: i)
}

// Use the subscript with a sequence parameter
var values = aList[2...4]

// Show the values of the new array created with the subscript
print(values)

