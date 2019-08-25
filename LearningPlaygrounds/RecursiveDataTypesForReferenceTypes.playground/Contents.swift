import UIKit

// LINKED LIST
// Notice that recursive data types are only for reference types and cannot be used with value types

// Create linked list using reference type
class LinkedLisReferenceType {
    var value: String
    var next: LinkedLisReferenceType?
    init (value: String) {
        self.value = value
    }
}

// Look for more about the use of linked list: What are linked list used for in Swift?
