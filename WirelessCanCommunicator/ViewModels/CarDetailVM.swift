import Foundation
import Combine

struct DiagnosticsData {
    var engineHealth: Bool
    var energyLevel: Double
    var tireHealth: Double
    var tempCelsius: Double

    static let empty = DiagnosticsData(
        engineHealth: true,
        energyLevel: 0,
        tireHealth: 0,
        tempCelsius: 0
    )
}

struct OBDTelemetry {
    var rpm: Int
    var speedMph: Int
    var coolantTempF: Int
    var throttlePercent: Double
    var intakeTempF: Int
    var fuelTrimPercent: Double
    var voltage: Double
    var fuelOrBatteryPercent: Double
    var diagnosticTroubleCodes: [String]

    static let idle = OBDTelemetry(
        rpm: 760,
        speedMph: 0,
        coolantTempF: 184,
        throttlePercent: 6,
        intakeTempF: 72,
        fuelTrimPercent: 1.2,
        voltage: 13.9,
        fuelOrBatteryPercent: 74,
        diagnosticTroubleCodes: []
    )
}

enum OBDConnectionState: String {
    case disconnected = "Disconnected"
    case scanning = "Scanning"
    case connected = "Connected"

    var isLive: Bool { self == .connected }
}

final class CarDetailVM: ObservableObject {
    let vehicle: Vehicle
    @Published var diagnostics: DiagnosticsData = .empty
    @Published var telemetry: OBDTelemetry = .idle
    @Published var connectionState: OBDConnectionState = .disconnected
    @Published var adapterName = "OBDLink MX+"
    @Published var lastUpdated = "Not connected"

    private var timer: Timer?
    private var tick = 0

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        refreshDiagnostics()
    }

    deinit {
        stopStream()
    }

    func connect() {
        connectionState = .scanning
        lastUpdated = "Scanning for Bluetooth OBD-II adapter"

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            guard let self else { return }
            self.connectionState = .connected
            self.lastUpdated = "Live stream active"
            self.startStream()
        }
    }

    func disconnect() {
        stopStream()
        connectionState = .disconnected
        lastUpdated = "Disconnected"
    }

    func requestDiagnostics() {
        refreshDiagnostics()
        telemetry.diagnosticTroubleCodes = Bool.random() ? [] : ["P0420"]
        lastUpdated = Self.timestamp()
    }

    private func startStream() {
        stopStream()
        timer = Timer.scheduledTimer(withTimeInterval: 0.55, repeats: true) { [weak self] _ in
            self?.updateTelemetry()
        }
    }

    private func stopStream() {
        timer?.invalidate()
        timer = nil
    }

    private func updateTelemetry() {
        tick += 1
        let wave = sin(Double(tick) / 2.0)
        let speedBase = max(0, 38 + Int(wave * 18) + Int.random(in: -3...4))
        let rpmBase = max(700, 1450 + Int(wave * 520) + Int.random(in: -80...90))
        let energyDrift = max(7, telemetry.fuelOrBatteryPercent - Double.random(in: 0.02...0.09))

        telemetry = OBDTelemetry(
            rpm: rpmBase,
            speedMph: speedBase,
            coolantTempF: max(165, min(222, telemetry.coolantTempF + Int.random(in: -1...2))),
            throttlePercent: max(0, min(100, 22 + wave * 18 + Double.random(in: -4...6))),
            intakeTempF: max(55, min(125, telemetry.intakeTempF + Int.random(in: -1...1))),
            fuelTrimPercent: max(-8, min(8, telemetry.fuelTrimPercent + Double.random(in: -0.35...0.35))),
            voltage: max(12.2, min(14.6, telemetry.voltage + Double.random(in: -0.04...0.04))),
            fuelOrBatteryPercent: energyDrift,
            diagnosticTroubleCodes: telemetry.diagnosticTroubleCodes
        )

        diagnostics = DiagnosticsData(
            engineHealth: telemetry.diagnosticTroubleCodes.isEmpty,
            energyLevel: telemetry.fuelOrBatteryPercent,
            tireHealth: diagnostics.tireHealth == 0 ? RandomGenerator.tireHealth() : diagnostics.tireHealth,
            tempCelsius: Double(telemetry.coolantTempF - 32) * 5 / 9
        )

        lastUpdated = Self.timestamp()
    }

    private func refreshDiagnostics() {
        let energyLevel = vehicle.fuelType == .electric ?
            RandomGenerator.batteryLevel() : RandomGenerator.fuelLevel()

        diagnostics = DiagnosticsData(
            engineHealth: RandomGenerator.engineHealth(),
            energyLevel: energyLevel,
            tireHealth: RandomGenerator.tireHealth(),
            tempCelsius: RandomGenerator.tempCelsius()
        )

        telemetry.fuelOrBatteryPercent = energyLevel
    }

    private static func timestamp() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: Date())
    }
}
