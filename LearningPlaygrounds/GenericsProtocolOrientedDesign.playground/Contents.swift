import UIKit

// GENERICS IN A PROTOCOL-ORIENTED DESIGN

// Start with the protocol
protocol List {
    // List will have an associated (generic) type
    associatedtype T
    
    // The subscript receives a sequence of int indices and return an array of T (generic) type elements
    subscript<E: Sequence> (indices: E) -> [T] where E.Iterator.Element == Int { get }
    
    // The implementation of this function will add element of the generic type T passed as the parameter
    mutating func add (_ item: T)
    
    // The implementation of this function will return an int with the number of elements in the list
    func length() -> Int
    
    // The implementation of this method will retrieve an element of the list at the index parameter
    func get(at index: Int) -> T?
    
    // The implementation of this method will delete the element of the list at the index parameter
    mutating func delete (at index: Int)
    
}

// The Lits types will be data storage structures, so we create a backend storage type that implements the COW (Copy On Write) feature for any List using value type
private class BackendList<T> {
    
    // Array of generic elements to store data
    private var items: [T] = []
    
    // Public default initialitzer
    public init () {}
    
    // Private initializer to create new instance of the BackendList
    private init (_ items: [T]) {
        self.items = items
    }
    // Method to add elements
    public func add (_ item: T) {
        items.append(item)
    }
    // Method to get the number of elements in the list
    public func length() -> Int {
        return items.count
    }
    // Method to get the element at the index parameter
    public func get (at index: Int) -> T? {
        return items[index]
    }
    // Method to delete the element at the index parameter
    public func delete (at index: Int) {
        items.remove(at: index)
    }
    // Method to create a copy
    public func copy() -> BackendList<T> {
        return BackendList<T>(items)
    }
}

// ArrayList type, conforms to the List protocol and use the BakcendList storage mechanism implementing the COW feature
struct ArrayList <T>: List {
    // property to store data
    private var items = BackendList<T>()
    
    // Subscript to get the items stored in a concrete sequence of indices, conforms to the protocol
    public subscript<E: Sequence> (indices: E) -> [T] where E.Iterator.Element == Int {
        var result = [T]()
        for index in indices {
            if let item = items.get(at: index) {
                result.append(item)
            }
        }
        return result
    }
    
    // Method to add items. Conforms to the protocol and check if there is only one instance of the type and makes a copy if necessary calling checkUniquely... method
    public mutating func add(_ item: T) {
        checkUniquelyReferencedInternalList()
        items.add(item)
    }
    
    // Method that returns the number of elements in the List. Conforms to the protocol
    public func length() -> Int {
        return items.length()
    }
    
    // Method that return the element at the index parameter. Conforms to the protocol
    public func get(at index: Int) -> T? {
        return items.get(at: index)
    }
    
    // Method to delete items. Conforms to the protocol and check if there is only one instance of the type and makes a copy if necessary calling checkUniquely... method
    public mutating func delete(at index: Int) {
        checkUniquelyReferencedInternalList()
        items.delete(at: index)
    }
    
    // Method that checks if there is more than one feference to the List and, if there are, make a copy of the List
    mutating private func checkUniquelyReferencedInternalList() {
        if !isKnownUniquelyReferenced(&items) {
            print("Making a copy of items")
            items = items.copy()
        } else {
            print("Not making a copy of items")
        }
    }
}

// Creating an instance of the ArrayList and adding items
var arrayList = ArrayList<Int>()
arrayList.add(1)
arrayList.add(2)
arrayList.add(3)

