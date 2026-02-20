// Views/CarDetailView.swift
import SwiftUI

struct CarDetailView: View {
    let vehicle: Vehicle
    @StateObject private var vm: CarDetailVM

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        _vm = StateObject(wrappedValue: CarDetailVM(vehicle: vehicle))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerCard

                specsGrid

                VStack(spacing: 14) {
                    Text("Live Systems Check")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    CarDiagramView(
                        diagnostics: vm.diagnostics,
                        fuelType: vehicle.fuelType
                    )

                    HStack(spacing: 12) {
                        if vehicle.fuelType == .electric {
                            EVInfoView(diagnostics: vm.diagnostics)
                        } else {
                            ICEInfoView(diagnostics: vm.diagnostics)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(14)
                }

                DiagnosticsButton(vm: vm)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .navigationTitle("\(vehicle.make) \(vehicle.model)")
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(vehicle.make) \(vehicle.model)")
                        .font(.system(.title, design: .rounded, weight: .bold))
                    Text(vehicle.engine)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Estimated value: \(vehicle.price)")
                        .font(.headline)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 8) {
                    badge(text: vehicle.fuelType.displayName, color: vehicle.fuelType == .electric ? .teal : .orange)
                    badge(text: vehicle.ccOrBattery, color: .blue)
                }
            }

            HStack(spacing: 16) {
                statTile(title: "0-100", value: "\(String(format: "%.1fs", vehicle.acceleration))")
                statTile(title: "Top Speed", value: "\(vehicle.topSpeedKmH) km/h")
                statTile(title: "Seats", value: "\(vehicle.seats)")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.15), Color.teal.opacity(0.25)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(18)
    }

    private var specsGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Powertrain")
                .font(.headline)
            HStack(spacing: 16) {
                specRow(label: "Horsepower", value: "\(vehicle.horsepower) hp", icon: "speedometer")
                specRow(label: "Torque", value: "\(vehicle.torqueNm) Nm", icon: "bolt.car")
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(14)
        }
    }

    private func badge(text: String, color: Color) -> some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .cornerRadius(10)
    }

    private func statTile(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground).opacity(0.8))
        .cornerRadius(12)
    }

    private func specRow(label: String, value: String, icon: String) -> some View {
        HStack {
            Label(label, systemImage: icon)
                .font(.headline)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
