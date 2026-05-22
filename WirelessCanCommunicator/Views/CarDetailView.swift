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
            VStack(spacing: 16) {
                connectionCard
                liveGaugeGrid
                CarDiagramView(diagnostics: vm.diagnostics, fuelType: vehicle.fuelType)
                pidGrid
                DiagnosticsButton(vm: vm)
            }
            .padding()
        }
        .background(Color.dashboardBackground.ignoresSafeArea())
        .navigationTitle("\(vehicle.make) \(vehicle.model)")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var connectionCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Bluetooth OBD-II Link")
                        .font(.headline)
                        .foregroundColor(.primaryText)
                    Text("\(vm.adapterName) · \(vm.connectionState.rawValue)")
                        .font(.subheadline)
                        .foregroundColor(.mutedText)
                }
                Spacer()
                statusPill
            }

            Text("Proof-of-concept live informatics stream from the vehicle OBD-II port. Values simulate common OBD-II PIDs such as RPM, speed, coolant temperature, voltage, throttle, and fuel/energy level.")
                .font(.footnote)
                .foregroundColor(.mutedText)

            HStack(spacing: 10) {
                Button(action: vm.connectionState.isLive ? vm.disconnect : vm.connect) {
                    Label(vm.connectionState.isLive ? "Disconnect" : "Pair Adapter", systemImage: vm.connectionState.isLive ? "xmark.circle.fill" : "dot.radiowaves.left.and.right")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryVehicleButtonStyle(active: !vm.connectionState.isLive))

                Button(action: vm.requestDiagnostics) {
                    Label("DTC Scan", systemImage: "waveform.path.ecg")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(SecondaryVehicleButtonStyle())
            }

            Text("Last update: \(vm.lastUpdated)")
                .font(.caption)
                .foregroundColor(.mutedText)
        }
        .dashboardCard()
    }

    private var statusPill: some View {
        Text(vm.connectionState.isLive ? "LIVE" : vm.connectionState.rawValue.uppercased())
            .font(.caption.weight(.bold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(vm.connectionState.isLive ? Color.safetyGreen.opacity(0.14) : Color.warningAmber.opacity(0.16))
            .foregroundColor(vm.connectionState.isLive ? .safetyGreen : .warningAmber)
            .clipShape(Capsule())
    }

    private var liveGaugeGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            telemetryTile(title: "Speed", value: "\(vm.telemetry.speedMph)", unit: "mph", icon: "speedometer", tint: .accentBlue)
            telemetryTile(title: "RPM", value: "\(vm.telemetry.rpm)", unit: "rev/min", icon: "gauge.with.dots.needle.67percent", tint: .safetyGreen)
            telemetryTile(title: "Coolant", value: "\(vm.telemetry.coolantTempF)", unit: "F", icon: "thermometer.medium", tint: .warningAmber)
            telemetryTile(title: vehicle.fuelType.energyLabel, value: "\(Int(vm.telemetry.fuelOrBatteryPercent))", unit: "%", icon: vehicle.fuelType == .electric ? "bolt.fill" : "fuelpump.fill", tint: .accentBlue)
        }
    }

    private var pidGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Live PID Stream")
                .font(.headline)
                .foregroundColor(.primaryText)

            VStack(spacing: 10) {
                pidRow("Throttle Position", "\(String(format: "%.1f", vm.telemetry.throttlePercent))%")
                pidRow("Intake Air Temp", "\(vm.telemetry.intakeTempF) F")
                pidRow("Fuel Trim", "\(String(format: "%.1f", vm.telemetry.fuelTrimPercent))%")
                pidRow("Adapter Voltage", "\(String(format: "%.2f", vm.telemetry.voltage)) V")
                pidRow("DTC Status", vm.telemetry.diagnosticTroubleCodes.isEmpty ? "No active codes" : vm.telemetry.diagnosticTroubleCodes.joined(separator: ", "))
            }
        }
        .dashboardCard()
    }

    private func telemetryTile(title: String, value: String, unit: String, icon: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(title, systemImage: icon)
                .font(.caption.weight(.semibold))
                .foregroundColor(.mutedText)
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.primaryText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Text(unit)
                    .font(.caption.weight(.bold))
                    .foregroundColor(tint)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(tint.opacity(0.10))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(tint.opacity(0.22), lineWidth: 1)
        )
    }

    private func pidRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .foregroundColor(.mutedText)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
                .foregroundColor(.primaryText)
                .multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
    }
}
