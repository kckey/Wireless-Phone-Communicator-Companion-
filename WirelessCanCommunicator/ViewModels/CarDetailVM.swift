// ViewModels/CarDetailVM.swift
import Foundation
import SwiftUI
import Combine

struct DiagnosticsData {
    var engineHealth: Bool
    var energyLevel: Double  // Battery % for EV, fuel % for ICE
    var tireHealth: Double   // %
    var tempCelsius: Double

    static let empty = DiagnosticsData(
        engineHealth: true,
        energyLevel: 0,
        tireHealth: 0,
        tempCelsius: 0
    )
}

final class CarDetailVM: ObservableObject {
    let vehicle: Vehicle
    @Published var diagnostics: DiagnosticsData = .empty

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        generate()
    }

    private func generate() {
        let engineHealth = RandomGenerator.engineHealth()
        let energyLevel = vehicle.fuelType == .electric ?
            RandomGenerator.batteryLevel() : RandomGenerator.fuelLevel()
        let tireHealth = RandomGenerator.tireHealth()
        let tempCelsius = RandomGenerator.tempCelsius()

        diagnostics = DiagnosticsData(
            engineHealth: engineHealth,
            energyLevel: energyLevel,
            tireHealth: tireHealth,
            tempCelsius: tempCelsius
        )
    }

    func requestDiagnostics() {
        // In a real app you would send an OBD-II or CAN message.
        // Here we just regenerate random values.
        generate()
    }
}
