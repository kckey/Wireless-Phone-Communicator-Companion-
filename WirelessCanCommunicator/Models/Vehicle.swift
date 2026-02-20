// Models/Vehicle.swift
import Foundation

struct Vehicle: Identifiable {
    let id = UUID()
    let make: String
    let model: String
    let engine: String
    let ccOrBattery: String      // "5000 cc" or "100 kWh"
    let horsepower: Int
    let topSpeedKmH: Int
    let acceleration: Double          // 0-100 km/h in seconds
    let price: String
    let fuelType: FuelType
    let seats: Int
    let torqueNm: Int

    enum FuelType: String, CaseIterable {
        case gasoline, diesel, hybrid, electric

        var displayName: String {
            switch self {
            case .gasoline: return "Gasoline"
            default: return rawValue.capitalized
            }
        }
        var energyLabel: String { self == .electric ? "Battery" : "Fuel" }
    }
}

extension Vehicle {
    static let samples: [Vehicle] = [
        Vehicle(
            make: "Tesla",
            model: "Model S",
            engine: "Dual Motor",
            ccOrBattery: "100 kWh",
            horsepower: 1020,
            topSpeedKmH: 322,
            acceleration: 2.1,
            price: "$94,990",
            fuelType: .electric,
            seats: 5,
            torqueNm: 1050
        ),
        Vehicle(
            make: "Tesla",
            model: "Model 3",
            engine: "Rear-Wheel Drive",
            ccOrBattery: "60 kWh",
            horsepower: 283,
            topSpeedKmH: 225,
            acceleration: 5.8,
            price: "$38,990",
            fuelType: .electric,
            seats: 5,
            torqueNm: 350
        ),
        Vehicle(
            make: "Toyota",
            model: "Camry",
            engine: "2.5L I4",
            ccOrBattery: "2500 cc",
            horsepower: 203,
            topSpeedKmH: 210,
            acceleration: 8.1,
            price: "$28,000",
            fuelType: .gasoline,
            seats: 5,
            torqueNm: 250
        ),
        Vehicle(
            make: "Ford",
            model: "F-150 Hybrid",
            engine: "3.5L V6 Hybrid",
            ccOrBattery: "3500 cc + 1.5 kWh",
            horsepower: 430,
            topSpeedKmH: 180,
            acceleration: 5.9,
            price: "$52,000",
            fuelType: .hybrid,
            seats: 5,
            torqueNm: 773
        ),
        Vehicle(
            make: "BMW",
            model: "330e",
            engine: "2.0L Plug-In Hybrid",
            ccOrBattery: "2000 cc + 12 kWh",
            horsepower: 288,
            topSpeedKmH: 230,
            acceleration: 5.7,
            price: "$44,900",
            fuelType: .hybrid,
            seats: 5,
            torqueNm: 420
        ),
        Vehicle(
            make: "Volkswagen",
            model: "Golf TDI",
            engine: "2.0L Turbo Diesel",
            ccOrBattery: "2000 cc",
            horsepower: 147,
            topSpeedKmH: 215,
            acceleration: 8.8,
            price: "$27,500",
            fuelType: .diesel,
            seats: 5,
            torqueNm: 340
        )
    ]
}
