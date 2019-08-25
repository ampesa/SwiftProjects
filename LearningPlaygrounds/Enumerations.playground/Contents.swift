import UIKit

// ENUMERATIONS
enum Devices {
    case IPod
    case IPhone
    case IPad
}

// Enumeration prepopulated with raw values
enum Gadgets: String {
    case IPod = "iPod"
    case IPhone = "iPhone"
    case IPad = "iPad"
}

// Accessing raw value
print(Gadgets.IPad.rawValue)

// Enumeration with associated values
enum GadgetsWithAssociatedValues {
    case IPod(model: String, year: Int, memory: Int)
    case IPhone(model: String, memory: Int)
    case IPad(model: String, memory: Int)
}

// Using enumeration with associated values
var myPhone = GadgetsWithAssociatedValues.IPhone(model: "6", memory: 64)
var myTablet = GadgetsWithAssociatedValues.IPad(model: "Pro", memory: 128)

// Retrieving values from enumeration with associated ones
switch myPhone {
case .IPod(let model, let year, let memory):
    print ("iPod: \(model) \(memory)")
case .IPhone(let model, let memory):
    print("iPhone: \(model) \(memory)")
case .IPad(let model, let memory):
    print("iPad: \(model) \(memory)")
}

// Enumeration with computed properties, initializers and methods
enum Reindeer: String {
    
    case Dasher, Dancer, Prancer, Vixen, Comet, Cupid, Donner, Blitzen, Rudolph
    
    static var allCases: [Reindeer] {
        return [Dasher, Dancer, Prancer, Vixen, Comet, Cupid, Donner, Blitzen, Rudolph]
    }
    
    static func randomCase() -> Reindeer {
        let randomValue = Int(arc4random_uniform(UInt32(allCases.count)))
        return allCases[randomValue]
    }
}

// using supercharged enumeration
for _ in 1...8 {
    print(Reindeer.randomCase())
}

// Another supercharged enumeration
enum BookFormat {
    case PaperBack (pageCount: Int, price: Double)
    case HardCover (pageCount: Int, price: Double)
    case PDF (pageCount: Int, price: Double)
    case EPub (pageCount: Int, price: Double)
    case Kindle (pageCount: Int, price: Double)
    
    // Use inner computed properties better than separated switch statements
    var pageCount: Int {
        switch self {
        case .PaperBack(let pageCount, _):
            return pageCount
        case .HardCover(let pageCount, _):
            return pageCount
        case .PDF(let pageCount, _):
            return pageCount
        case .EPub(let pageCount, _):
            return pageCount
        case .Kindle(let pageCount, _):
            return pageCount
        }
    }
    
    var price: Double {
        switch self {
        case .PaperBack(_, let price):
            return price
        case .HardCover(_, let price):
            return price
        case .PDF(_, let price):
            return price
        case .EPub(_, let price):
            return price
        case .Kindle(_, let price):
            return price
        }
    }
    
    // adding some function for dicounts
    func purchaseTogether (otherFormat: BookFormat) -> Double {
        return (self.price + otherFormat.price) * 0.8
    }
}

// Using the computed properties to retrieve associated values
var paperBack = BookFormat.PaperBack(pageCount: 220, price: 39.99)
print("\(paperBack.pageCount) - \(paperBack.price)")

// Using enmumeration function
var pdf = BookFormat.PDF(pageCount: 180, price: 14.99)
var total = paperBack.purchaseTogether(otherFormat: pdf)
print(total.rounded())




