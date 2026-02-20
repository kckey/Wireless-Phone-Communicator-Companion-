// Views/ICEInfoView.swift
import SwiftUI

struct ICEInfoView: View {
    let diagnostics: DiagnosticsData

    var body: some View {
        VStack(spacing: 10) {
            Label("Fuel Level: \(String(format: "%.0f%%", diagnostics.energyLevel))", systemImage: "fuelpump.fill")
                .foregroundColor(.orange)
            Label("Engine: \(diagnostics.engineHealth ? "Normal" : "Check")", systemImage: diagnostics.engineHealth ? "checkmark.seal.fill" : "exclamationmark.triangle.fill")
                .foregroundColor(diagnostics.engineHealth ? .green : .orange)
            Label("Tire Health: \(String(format: "%.0f%%", diagnostics.tireHealth))", systemImage: "car.circle.fill")
                .foregroundColor(.blue)
            Label("Temp: \(String(format: "%.1f C", diagnostics.tempCelsius))", systemImage: "thermometer")
                .foregroundColor(.red)
        }
    }
}
