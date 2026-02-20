// ViewModels/VehicleListVM.swift
import SwiftUI
import Combine

final class VehicleListVM: ObservableObject {
    @Published var vehicles: [Vehicle] = []
    @Published var selected: Vehicle?

    init() {
        loadVehicles()
    }

    private func loadVehicles() {
        if let parsed = loadCSVVehicles(), !parsed.isEmpty {
            vehicles = parsed
        } else {
            vehicles = Vehicle.samples
        }
        selected = vehicles.first
    }

    private func loadCSVVehicles() -> [Vehicle]? {
        guard let url = Bundle.main.url(forResource: "vehicles", withExtension: "csv"),
              let data = try? Data(contentsOf: url),
              let csv = String(data: data, encoding: .utf8) else {
            return nil
        }

        let rows = csv.split(whereSeparator: \.isNewline)
        guard rows.count > 1 else { return nil }

        return rows.dropFirst().compactMap { row in
            let fields = row.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            guard fields.count == 11 else { return nil }

            let fuelRaw = fields[8].lowercased()
            let fuelType = Vehicle.FuelType(rawValue: fuelRaw == "petrol" ? "gasoline" : fuelRaw) ?? .gasoline

            return Vehicle(
                make: fields[0],
                model: fields[1],
                engine: fields[2],
                ccOrBattery: fields[3],
                horsepower: Int(fields[4]) ?? 0,
                topSpeedKmH: Int(fields[5]) ?? 0,
                acceleration: Double(fields[6]) ?? 0,
                price: fields[7],
                fuelType: fuelType,
                seats: Int(fields[9]) ?? 0,
                torqueNm: Int(fields[10]) ?? 0
            )
        }
    }
}
