// Views/EVInfoView.swift
import SwiftUI

struct EVInfoView: View {
    let diagnostics: DiagnosticsData

    var body: some View {
        VStack(spacing: 10) {
            Label("Battery Level: \(String(format: "%.0f%%", diagnostics.energyLevel))", systemImage: "bolt.fill")
                .foregroundColor(.green)
            Label("Engine: \(diagnostics.engineHealth ? "Normal" : "Check")", systemImage: diagnostics.engineHealth ? "checkmark.seal.fill" : "exclamationmark.triangle.fill")
                .foregroundColor(diagnostics.engineHealth ? .green : .orange)
            Label("Tire Health: \(String(format: "%.0f%%", diagnostics.tireHealth))", systemImage: "car.circle.fill")
                .foregroundColor(.blue)
            Label("Temp: \(String(format: "%.1f C", diagnostics.tempCelsius))", systemImage: "thermometer")
                .foregroundColor(.red)
        }
    }
}
