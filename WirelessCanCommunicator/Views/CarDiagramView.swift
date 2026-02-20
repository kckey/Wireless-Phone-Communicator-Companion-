// Views/CarDiagramView.swift
import SwiftUI

struct CarDiagramView: View {
    let diagnostics: DiagnosticsData
    let fuelType: Vehicle.FuelType

    private var energyLabel: String { fuelType.energyLabel }
    private var energyIcon: String { fuelType == .electric ? "bolt.fill" : "fuelpump.fill" }
    private var engineIcon: String { diagnostics.engineHealth ? "checkmark.seal.fill" : "exclamationmark.triangle.fill" }

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                systemTile(title: "Engine", value: diagnostics.engineHealth ? "Normal" : "Check", icon: engineIcon, color: diagnostics.engineHealth ? Color.green : Color.orange)
                systemTile(title: "Temp", value: "\(String(format: "%.1f C", diagnostics.tempCelsius))", icon: "thermometer", color: Color.red)
            }

            meter(title: energyLabel, value: diagnostics.energyLevel, icon: energyIcon, tint: fuelType == .electric ? Color.teal : Color.orange)
            meter(title: "Tire Health", value: diagnostics.tireHealth, icon: "car.circle.fill", tint: Color.blue)
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.15), Color.teal.opacity(0.15)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
    }

    private func meter(title: String, value: Double, icon: String, tint: Color) -> some View {
        let clamped = max(0, min(value, 100))
        return VStack(alignment: .leading, spacing: 8) {
            HStack {
                Label(title, systemImage: icon)
                    .font(.headline)
                Spacer()
                Text("\(String(format: "%.0f%%", clamped))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            ProgressView(value: clamped / 100)
                .tint(tint)
                .progressViewStyle(.linear)
        }
    }

    private func systemTile(title: String, value: String, icon: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Label(title, systemImage: icon)
                .font(.headline)
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}
