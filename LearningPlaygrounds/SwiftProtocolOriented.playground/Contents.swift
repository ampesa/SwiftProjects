import UIKit

// PROTOCOL-ORIENTED PROGRAMMING "A new way of how to think about programming!"

// The vehicle protocol
protocol Vehicle {
    var hitPoints: Int { get set }
}

// Implementation of methods with protocol extension
extension Vehicle {
    mutating func takeHit(amount: Int) {
        hitPoints -= amount
    }
    
    func hitPointsRemaining () -> Int {
        return hitPoints
    }
    
    func isAlive() -> Bool {
        return hitPoints > 0 ? true : false
    }
}

// Implementation of vehicle types that conform to Vehicle protocol so they inherit the methods extension. Each protocol only contain the requirements for its particular vehicle type
protocol LandVehicle: Vehicle {
    // landVehicle properties are only readable and will act as constants
    var landAttack: Bool { get }
    var landMovement: Bool { get }
    var landAttackRange: Int { get }
    
    // landVehicle actions
    func doLandAttack()
    func doLandMovement()
}

protocol SeaVehicle: Vehicle {
    
    var seaAttack: Bool { get }
    var seaMovement: Bool { get }
    var seaAttackRange: Int { get }
    
    func doSeaAttack()
    func doSeaMovement()
}

protocol AirVehicle: Vehicle {
    
    var airAttack: Bool { get }
    var airMovement: Bool { get }
    var airAttackRange: Int { get }
    
    func doAirAttack()
    func doAirMovement()
}

// Creating the Tank, Amphibious and Transformer Types as structures (Value Types)
struct Tank: LandVehicle {
    // Properties conforming to the protocols. No need to use initializers, cause struct uses it by default
    var hitPoints = 68
    let landAttackRange = 5
    let landAttack = true
    let landMovement = true
    
    func doLandAttack() { print("Tank Attack!") }
    func doLandMovement() { print("Tank move") }
}
// The amphibious type
struct Amphibious: LandVehicle, SeaVehicle {
    var hitPoints = 25
    let seaAttackRange = 1
    let landAttackRange = 1
    
    let landAttack = true
    let landMovement = true
    
    let seaAttack = true
    let seaMovement = true
    
    func doLandAttack() { print("Amphibious land attack!") }
    func doLandMovement() { print("Amphibious land move") }
    func doSeaAttack() { print("Amphibious sea attack!") }
    func doSeaMovement() { print("Amphibious sea move") }
}

// The transformer type
struct Transformer: LandVehicle, SeaVehicle, AirVehicle {
    
    var hitPoints = 75
    let landAttackRange = 7
    let seaAttackRange = 6
    let airAttackRange = 5
    
    let landAttack = true
    let seaAttack = true
    let airAttack = true
    let landMovement = true
    let seaMovement = true
    let airMovement = true
    
    func doLandAttack() { print("Transformer land attack!") }
    func doLandMovement() { print("Transformer land move") }
    func doSeaAttack() { print("Transformer sea attack!") }
    func doSeaMovement() { print("Transformer sea move") }
    func doAirAttack() { print("Transformer air attack!") }
    func doAirMovement() { print("Transformer air move") }
}

// Creating an array and putting several instances
var vehicles = [Vehicle]()

var vh1 = Amphibious()
var vh2 = Amphibious()
var vh3 = Tank()
var vh4 = Transformer()

vehicles.append(vh1)
vehicles.append(vh2)
vehicles.append(vh3)
vehicles.append(vh4)

// Using the interface of the Vehicle protocol to interact with the instances
for (index, vehicle) in vehicles.enumerated() {
    if vehicle is AirVehicle {
        print("Vehicle at position \(index) is Air")
    }
    if vehicle is LandVehicle {
        print("Vehicle at position \(index) is Land")
    }
    if vehicle is SeaVehicle {
        print("Vehicle at position \(index) is Sea")
    }
}

// Getting only one type of Vehicle
for (_, vehicle) in vehicles.enumerated() where vehicle is LandVehicle {
    let vh = vehicle as! LandVehicle
    if vh.landAttack {
        vh.doLandAttack()
    }
    if vh.landMovement {
        vh.doLandMovement()
    }
}

// Persisting data in protocol oriented programming
func takeHit<T: Vehicle> (vehicle: inout T) {
    vehicle.takeHit(amount: 10)
    print(vehicle.hitPointsRemaining())
}

// Loopint attack while vehicle is still alive to check value type is persisting data
repeat {
    takeHit(vehicle: &vh3)
} while vh3.isAlive()
