import UIKit

// OBJECT ORIENTED PROGRAMMIGN WITH SWIFT

// TerrainType enum that will be used to define different vehicles, attack and movement types
enum TerrainType {
    case land
    case sea
    case air
}

// The Vehicle superclass
class Vehicle {
    // Properties for the vehicle types. Cause we are defining the vehicle subclasses into the same sourcefile we use the fileprivate access to prevent these properties from being changed by other types.
    fileprivate var vehicleTypes = [TerrainType]()
    fileprivate var vehicleAttackTypes = [TerrainType]()
    fileprivate var vehicleMovementTypes = [TerrainType]()
    fileprivate var landAttackRange = -1
    fileprivate var seaAttackRange = -1
    fileprivate var airAttackRange = -1
    fileprivate var hitPoints = 0
    
    // Vehicle identification functions
    func isVehicleType(type: TerrainType) -> Bool {
        return vehicleTypes.contains(type)
    }
    
    func canVehicleAttack(type: TerrainType) -> Bool {
        return vehicleAttackTypes.contains(type)
    }
    
    func canVehicleMove(type: TerrainType) -> Bool {
        return vehicleMovementTypes.contains(type)
    }
    
    // Vehicle action functions
    func doLandAttack() { }
    func doLandMovement() { }
    
    func doSeaAttack() { }
    func doSeaMovement() { }
    
    func doAirAttack() { }
    func doAirMovement() { }
    
    // Vehicle state functions
    func takeHit(amount: Int) { hitPoints -= amount}
    func hitPointsRemaining() -> Int { return hitPoints }
    func isAlive() -> Bool { return hitPoints > 0 ? true: false }
    
}

// Some vehicle subclases
class Tank: Vehicle {
    // Vehicle Tank initialization.
    override init() {
        // take the properties of the superclass
        super.init()
        
        // initialize the vehicle type, attack and movement as land
        vehicleTypes = [.land]
        vehicleAttackTypes = [.land]
        vehicleMovementTypes = [.land]
        
        // initialize vehicle state
        landAttackRange = 5
        hitPoints = 68
    }
    // Especific implementation of action methods for the Tank type
    override func doLandAttack() {
        print("Tank attack!")
    }
    
    override func doLandMovement() {
        print("Tank move")
    }
    
    // Function to interact with the hitPoints property
    func takeHit(vehicle: Vehicle) {
        vehicle.takeHit(amount: 10)
    }
    
}

// Amphibious has both land and sea properties
class Amphibious: Vehicle {
    override init() {
        
        super.init()
        
        vehicleTypes = [.land, .sea]
        vehicleAttackTypes = [.land, .sea]
        vehicleMovementTypes = [.land, .sea]
        
        landAttackRange = 1
        seaAttackRange = 1
        
        hitPoints = 25
    }
    
    override func doLandAttack() { print("Amphibious land attack!") }
    override func doLandMovement() { print("Amphibious land move") }
    override func doSeaAttack() { print("Amphibious sea attack!") }
    override func doSeaMovement() { print("Amphibious sea move") }
}

// Transformer has the three terrain properties
class Transformer: Vehicle {
    override init() {
        super.init()
        vehicleTypes = [.land, .sea, .air]
        vehicleAttackTypes = [.land, .sea, .air]
        vehicleMovementTypes = [.land, .sea, .air]
        
        landAttackRange = 7
        seaAttackRange = 10
        airAttackRange = 12
        
        hitPoints = 75
    }
    
    override func doLandAttack() { print("Transformer land attack!") }
    override func doLandMovement() { print("Transformer land move") }
    override func doSeaAttack() { print("Transformer sea attack!") }
    override func doSeaMovement() { print("Transformer sea move") }
    override func doAirAttack() { print("Transformer air attack!") }
    override func doAirMovement() { print("Transformer air move") }
}

// Creating a Vehicle type array and storing instances of its subclasses
var vehicles = [Vehicle]()

var vh1 = Amphibious()
var vh2 = Amphibious()
var vh3 = Tank()
var vh4 = Transformer()

vehicles.append(vh1)
vehicles.append(vh2)
vehicles.append(vh3)
vehicles.append(vh4)

// Iterating through the array and interacting with each instance calling methods for each vehicle type when condition is true
for (index, vehicle) in vehicles.enumerated() {
    // Here we are not using if-else or switch because any vehicle can be a member of multiple types and we need to recheck the type, even if the vehicle type was previously matched. Checking the three terrain types and both methods: attack and move
    if vehicle.isVehicleType(type: .air) {
        print("Vehicle at \(index) is Air")
        
        if vehicle.canVehicleAttack(type: .air) {
            vehicle.doAirAttack()
        }
        
        if vehicle.canVehicleMove(type: .air) {
            vehicle.doAirMovement()
        }
    }
    
    if vehicle.isVehicleType(type: .land) {
        print("Vehicle at \(index) is Land")
        
        if vehicle.canVehicleAttack(type: .land) {
            vehicle.doLandAttack()
        }
        
        if vehicle.canVehicleMove(type: .land) {
            vehicle.doLandMovement()
        }
    }
    
    if vehicle.isVehicleType(type: .sea) {
        print("Vehicle at \(index) is Sea")
        
        if vehicle.canVehicleAttack(type: .sea) {
            vehicle.doSeaAttack()
        }
        
        if vehicle.canVehicleMove(type: .sea) {
            vehicle.doSeaMovement()
        }
    }
}

// Looping to only return instances of air units
for (index, vehicle) in vehicles.enumerated() where vehicle.isVehicleType(type: .air) {
    if vehicle.isVehicleType(type: .air) {
        print("**Vehicle at \(index) is Air")
        
        if vehicle.canVehicleAttack(type: .air) {
            vehicle.doAirAttack()
        }
        
        if vehicle.canVehicleMove(type: .air) {
            vehicle.doAirMovement()
        }
    }
}

// Interacting with the hitPoints property
func takeHit(vehicle: Vehicle) {
    vehicle.takeHit(amount: 10)
    print("\(vehicle) under attack loses 10 damage points")
    if vehicle.isAlive() {
        print("\(vehicle) is still alive and has \(vehicle.hitPointsRemaining()) hit points remaining")
    } else {
        print("\(vehicle) is defeated. No hit points reamining")
    }
}

// Checking how data is persisted in reference type. Looping attack to vh3 vehicle type (Tank).
while vh3.isAlive() {
    takeHit(vehicle: vh3)
}

print("Is \(vh3.vehicleTypes) alive? \(vh3.isAlive())")

/*
 ISSUES WITH THE OBJECT-ORIENTED DESIGN IN SWIFT
 - Swift is a single-inheritance language and limits a class to having not more than one superclass
 - That single-inheritance can lead to a too much big superclasses
 - That super superclasses may lead to inheritance of functionality that a type does not need... This is "potential error"
 */
