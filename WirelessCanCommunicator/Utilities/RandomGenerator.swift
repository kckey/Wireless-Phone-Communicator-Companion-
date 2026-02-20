// Utilities/RandomGenerator.swift
import Foundation

struct RandomGenerator {
    static func randomBool() -> Bool { Bool.random() }
    static func randomInt(min: Int, max: Int) -> Int { Int.random(in: min...max) }
    static func randomDouble(min: Double, max: Double) -> Double {
        Double.random(in: min...max)
    }

    // Example diagnostic values
    static func engineHealth() -> Bool { randomBool() }
    static func batteryLevel() -> Double { randomDouble(min: 20.0, max: 100.0) }   // % for EV
    static func fuelLevel() -> Double { randomDouble(min: 5.0, max: 60.0) }        // % for ICE
    static func tireHealth() -> Double { randomDouble(min: 80.0, max: 100.0) }
    static func tempCelsius() -> Double { randomDouble(min: -10.0, max: 120.0) }
}
