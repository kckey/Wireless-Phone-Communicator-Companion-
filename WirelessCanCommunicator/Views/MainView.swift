// Views/MainView.swift
import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: VehicleListVM

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemGray6), Color(.systemBackground)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        header

                        LazyVStack(spacing: 14) {
                            ForEach(vm.vehicles) { vehicle in
                                NavigationLink(destination: CarDetailView(vehicle: vehicle)) {
                                    VehicleCard(vehicle: vehicle)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Select Vehicle")
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Vehicle Diagnostics")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            Text("Select a vehicle to view live health and system data.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

private struct VehicleCard: View {
    let vehicle: Vehicle

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(vehicle.make) \(vehicle.model)")
                        .font(.system(.title3, design: .rounded, weight: .semibold))
                    Text(vehicle.engine)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Estimated value: \(vehicle.price)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text(vehicle.fuelType.displayName)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(vehicle.fuelType == .electric ? Color.teal.opacity(0.15) : Color.orange.opacity(0.15))
                    .foregroundColor(vehicle.fuelType == .electric ? .teal : .orange)
                    .cornerRadius(10)
            }

            HStack(spacing: 16) {
                stat(icon: "speedometer", label: "HP", value: "\(vehicle.horsepower)")
                stat(icon: "bolt.fill", label: "Torque", value: "\(vehicle.torqueNm) Nm")
                stat(icon: "figure.seated.side.airbag.off", label: "Seats", value: "\(vehicle.seats)")
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
    }

    private func stat(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundColor(.blue)
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
