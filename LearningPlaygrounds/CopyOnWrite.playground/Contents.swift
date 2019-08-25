import UIKit

// COPY ON WRITE (COW)
// How to implement COW using reference and value types together.

// Ceating a backend storage type. It is only accesible from inside the defining source file because it should only be used to implment the COW
fileprivate class BackendQueue<T> {
    // An array to store the data
    private var items = [T]()
    
    // Public default initialitzer used to create an instance of the BackendQueue
    public init() { }
    
    // Private initialitzer used internally to create a copy of itself when needed
    private init(_ items: [T]) {
        self.items = items
    }
    
    // A method to add items to the queue
    public func addItem(item: T) {
        items.append(item)
    }
    
    // A method to retrieve an item from the queue
    public func getItem() -> T? {
        if items.count > 0 {
            return items.remove(at: 0)
        } else {
            return nil
        }
    }
    
    // A method to return the number of items in the queue
    public func count() -> Int {
        return items.count
    }
    
    // The copy method
    public func copy() -> BackendQueue<T> {
        return BackendQueue<T>(items)
    }

}

// The Queue type that will use the BackendQueue type to implement the COW feature
struct Queue {
    // Instance of the BackendQueue type
    private var internalQueue = BackendQueue<Int>()
    
    // COW implementation.
    // Check if there is a unique reference to the internalQueue instance.
    mutating private func checkUniquelyReferencedInternalQueue() {
        if !isKnownUniquelyReferenced(&internalQueue) {
            internalQueue = internalQueue.copy()
            print("Making a copy of internalQueue")
        } else {
            print("Not making a copy of internalQueue")
        }
    }
    
    // Method addItem call the BackendQueue type addItem method and pass an integer to be added
    // As the method changes the internalQueue instance, we will want to call the check... method to create a copy of the internalQueue instance
    public mutating func addItem (item: Int) {
        checkUniquelyReferencedInternalQueue()
        internalQueue.addItem(item: item)
    }
    
    // Method getItem call the BackendQueue type method getItem and return the integer if there is any
    // As the method changes the internalQueue instance, we will want to call the check... method to create a copy of the internalQueue instance
    public mutating func getItem() -> Int? {
        checkUniquelyReferencedInternalQueue()
        return internalQueue.getItem()
    }
    
    // Method count, uses BackendQueue type method count.
    public func count() -> Int {
        return internalQueue.count()
    }
    
    // Method to see if there is a unique reference to the internalQueue instance or not
    mutating public func uniquelyReferenced() -> Bool {
        return isKnownUniquelyReferenced(&internalQueue)
    }

}

// COW functionality working with the Queue type
var queue1 = Queue()
queue1.addItem(item: 1)
// Confirming that there is only one reference to the internalQueue instance
print(queue1.uniquelyReferenced())

// Create a new reference to the instance
var queue2 = queue1

// Confirming that there is more than one reference to the instance
print(queue1.uniquelyReferenced())
print(queue2.uniquelyReferenced())

// Adding a new item of the instance will result in a new copy of it
queue1.addItem(item: 2)

// Now each instance of the Queue type has its own copy
print(queue1.uniquelyReferenced())
print(queue2.uniquelyReferenced())

