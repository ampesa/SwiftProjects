import UIKit

// just a protocol defining some functions
protocol RobotMovement {
    
    func forward(speedPercent: Double)
    func reverse(speedPercent: Double)
    func left(speedPercent: Double)
    func right(speedPercent: Double)
    func stop()
    
}

// a protocol that inherits from previous protocol and adds some functions
protocol RobotMovementThreeDimensions: RobotMovement {
    
    func up(speedPercent: Double)
    func down(speedPercent: Double)
    
}

// Sensor protocol with two properties, an initiator to name the sensor and a method to poll it
protocol Sensor {
    
    var sensorType: String { get }
    var sensorName: String { get }
    
    init (sensorName: String)
    func pollSensor()
    
}

// protocol that conforms the requirements for some especific sensor types
protocol EnviromentSensor: Sensor {
    
    func currentTemperature() -> Double
    func currentHumidity() -> Double
    
}

// protocol for more sensor types
protocol RangeSensor: Sensor {
    
    func setRangeNotification(rangeCentimeter: Double, rangeNotification: () -> Void)
    func currentRange() -> Double
    
}

protocol DisplaySensor: Sensor {
    
    func displayMessage(message: String)
    
}

protocol WirelessSensor: Sensor {
    
    func setMessgeReceivedNotification(messageNotification: (String) -> Void)
    func messageSend(message: String)
    
}

// Protocol to define Robots
protocol Robot {
    
    var name: String { get set }
    var robotMovement: RobotMovement { get set }
    var sensors: [Sensor] { get }
    
    init (name: String, robotMovement: RobotMovement)
    func addSensor (sensor: Sensor)
    func pollSensors()
    
}

// Define a robot here:

