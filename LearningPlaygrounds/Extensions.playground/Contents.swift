import UIKit

// EXTENSIONS

// this is an extension
extension String {
    func getFirstChar() -> Character? {
        // characters is deprecated so we use the self keyword to refer to the string itself
        guard self.count > 0 else {
            return nil
        }
        return self[startIndex]
    }
    
    // Adding a subscript
    subscript (r: CountableClosedRange<Int>) ->String {
        get {
            let start = index(self.startIndex, offsetBy: r.lowerBound)
            let end = index(self.startIndex, offsetBy: r.upperBound)
            return substring (with: start..<end)
        }
    }
    
}

// here an example of how to use that extension
var myString = "This is a test"
print(myString.getFirstChar()!)

// Extension to get the square of an integer
extension Int {
    func squared() -> Int {
        return self * self
    }
}

print(58.squared())

// extension for representing the value of a Double as a String representing currency value
extension Double {
    func currrencyString() -> String {
        // divisor equals 100, cause 10.0 elevated to 2 = 10 * 10
        let divisor = pow(10.0, 2.0)
        // multiply the Double by 100, then round it, and divide it by 100 to get 2 decimal positions
        let num = (self * divisor).rounded() / divisor
        // return the string with the currency format for the num
        return "$\(num)"
    }
}

print(50.658957.currrencyString())

// my reduced extension version of the previous one
extension Double {
    func toCurrencyString() -> String {
        let num = (self * 100).rounded() / 100
        return "$\(num)"
    }
}

print(50.658957.toCurrencyString())

// example of extension with a computed property
extension Int {
    var squared2: Int {
        return self * self
    }
}
print(36.squared2)


// PROTOCOL EXTENSIONS
// Extension to get the even indexes items on a collection
extension Collection {
    func evenElements() -> [Iterator.Element] {
        // the start index of the collection is assigned to "index"
        var index = startIndex
        // array to store de result of the new collection only with the even index elements
        var result: [Iterator.Element] = []
        var i = 0
        repeat {
            if i % 2 == 0 {
            result.append(self[index])
            }
            index = self.index(after: index)
            i += 1
        } while (index != endIndex) // code will repeat while there are elelements in the collection
        return result
    }
    // return the original elements of a collection in a different order
    func shuffle() -> [Iterator.Element] {
        return sorted() { left, right in return arc4random() < arc4random() }
    }
}

var originalArray = [1,2,3,4,5,6,7,8,9,10]
var evenArray = originalArray.evenElements()
var suffledArray: [Int]
suffledArray = originalArray.shuffle()

// EXTENSION CONSTRAINTS
// Adding a constraint to the extension in order to limit the types that receive the functionality
// Only Array types will receive this functionality
extension Collection where Self: ExpressibleByArrayLiteral {
    // Extension code goes here
}

// Adding constraints to specify our extension will only aply to a collection whose elements conform to a especific protocol.
extension Collection where Iterator.Element: Comparable {
    // Add functionality here
}

// DEVELOPING A TEXT VALIDATION FRAMEWORK WITH PROTOCOLS AND EXTENSIONS
// The protocol
protocol TextValidation {
    var regExMatchingString: String {get} // contains the regular expression string to check the user string
    var regExFindMatchString: String {get} // contains the corrected string to get back and that conforms to the regex
    var validationMessage: String {get} // error message to display
    func validateString(str: String) -> Bool // return true if imput is valid, will use regExMatchingString to check the input string
    func getMatchingString(str: String) -> String? // method for real time validating input. Will return the regExFindMatchString
}

// Implementation with class that conforms to the protocol TextValidation
class AlphabeticValidation1: TextValidation {
    static let sharedInstance = AlphabeticValidation1()
    let regExFindMatchString = "^[a-zA-Z]{0,10}"
    let validationMessage = "Can only contain Alpha characters"
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
        if let newMatch = str.range(of: regExFindMatchString, options: .regularExpression) {
            return str.substring(with: newMatch)
        } else {
            return nil
        }
    }
}

// Text Validation Types with protocol extensions
protocol TextValidation2 {
    var regExFindMatchString: String {get}
    var validationMessage: String {get}
}
// implementing the computed property and methods in the protocol extension
extension TextValidation2 {
    var regExMatchingString: String {
        get {
            return regExFindMatchString + "$"
        }
    }
    func validateString(str: String) -> Bool {
        if let _ = str.range(of: regExMatchingString,
                             options: .regularExpression) {
            return true
        } else {
            return false
        }
    }
    func getMatchingString(str: String) -> String? {
        if let newMatch = str.range(of: regExFindMatchString,
                                    options: .regularExpression) {
            return str.substring(with: newMatch)
        } else {
            return nil
        }
    }
    
}

// Defining the text validation classes. Every class has a static constant and a private initiator so them can be used as a singleton (see Design Patterns - Singleton Pattern)
class AlphabeticValidation: TextValidation2 {
    static let sharedInstance = AlphabeticValidation()
    private init() {}
    let regExFindMatchString = "^[a-zA-Z]{0,10}"
    let validationMessage = "Can only contain Alpha characters"
}

class AlphaNumericValidation: TextValidation2 {
    static let sharedInstance = AlphaNumericValidation()
    private init() {}
    let regExFindMatchString = "^[a-zA-Z0-9]{0,15}"
    let validationMessage = "Can only contain Alpha Numeric characters"
}

class DisplayNameValidation: TextValidation2 {
    static let sharedInstance = DisplayNameValidation()
    private init() {}
    let regExFindMatchString = "^[\\s?[a-zA-Z0-9\\-_\\s]]{0,15}"
    let validationMessage = "Display Name can only contain Alphanumeric characters"
}

// Using the validation classes. Define 2 strings
var myString1 = "abcxyz"
var myString2 = "abc123"
// Create an instance of the AlphabeticValidation class
var validation = AlphabeticValidation.sharedInstance
// Calling method validateString for both strings 1 and 2
validation.validateString(str: myString1) // return true. String is Alphabetic and no more than 10 characters
validation.validateString(str: myString2) // return false. String is not only Alphabetic

validation.getMatchingString(str: myString1) // return "abcxyz"
validation.getMatchingString(str: myString2) // return "abc" the Alphabetic part of myString2

// EXTENSIONS WITH THE SWIFT STANDARD LIBRARY
// Extension of the Int structure to get the factorial
extension Int {
    func factorial() -> Int {
        var answer = 1
        for  x in (1...self).reversed() {
            answer *= x
        }
        return answer
    }
}
// using the extension
print(10.factorial())
// testing the extension
print(10*9*8*7*6*5*4*3*2*1)

// CONFORMING THE EQUATABLE PROTOCOL
// Creating the type we will compare
struct Place {
    let id: String
    let latitude: Double
    let longitude: Double
}

// Implementing the Equatable protocol pulling the functionality out of the Place type itself
extension Place: Equatable {
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.id == rhs.id &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}

// Comparing instances of the Place Type
var placeOne = Place(id: "Fenway Park", latitude: 42.3467, longitude: -71.0972)
var placeTwo = Place(id: "Wrigley Field", latitude: 41.9484, longitude: -87.6553)

print(placeOne == placeTwo)

var placeThree = placeOne
print(placeOne == placeThree)

var merengue = Place(id: "Santiago Bernabeu", latitude: 40.4532, longitude: -3.6883)
var cule = Place(id: "Camp Nou", latitude: 41.3810, longitude: 2.1230)

print(merengue == cule)

