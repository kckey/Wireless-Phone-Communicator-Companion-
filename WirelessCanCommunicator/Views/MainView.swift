import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: VehicleListVM

    var body: some View {
        NavigationStack {
            ZStack {
                Color.dashboardBackground.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        header

                        LazyVStack(spacing: 12) {
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
            .navigationTitle("OBD-II Companion")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Bluetooth OBD-II Proof of Concept", systemImage: "dot.radiowaves.left.and.right")
                .font(.caption.weight(.bold))
                .foregroundColor(.accentBlue)
            Text("Real-time vehicle informatics from an OBD-II adapter")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .foregroundColor(.primaryText)
            Text("Select a demo vehicle to simulate pairing, live PID updates, diagnostics, and drivetrain health from the vehicle port.")
                .font(.subheadline)
                .foregroundColor(.mutedText)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.cardBorder, lineWidth: 1)
        )
    }
}

private struct VehicleCard: View {
    let vehicle: Vehicle

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: vehicle.fuelType == .electric ? "bolt.car.fill" : "car.fill")
                    .font(.title2)
                    .foregroundColor(.accentBlue)
                    .frame(width: 44, height: 44)
                    .background(Color.accentBlue.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                VStack(alignment: .leading, spacing: 4) {
                    Text("\(vehicle.make) \(vehicle.model)")
                        .font(.system(.title3, design: .rounded, weight: .semibold))
                        .foregroundColor(.primaryText)
                    Text(vehicle.engine)
                        .font(.subheadline)
                        .foregroundColor(.mutedText)
                }

                Spacer()

                Text(vehicle.fuelType.displayName)
                    .font(.caption.weight(.bold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.safetyGreen.opacity(0.12))
                    .foregroundColor(.safetyGreen)
                    .clipShape(Capsule())
            }

            HStack(spacing: 10) {
                stat(icon: "speedometer", label: "HP", value: "\(vehicle.horsepower)")
                stat(icon: "bolt.fill", label: "Torque", value: "\(vehicle.torqueNm) Nm")
                stat(icon: "antenna.radiowaves.left.and.right", label: "Link", value: "BT OBD-II")
            }
        }
        .padding()
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.cardBorder, lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }

    private func stat(icon: String, label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Label(label, systemImage: icon)
                .font(.caption)
                .foregroundColor(.mutedText)
            Text(value)
                .font(.caption.weight(.semibold))
                .foregroundColor(.primaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
