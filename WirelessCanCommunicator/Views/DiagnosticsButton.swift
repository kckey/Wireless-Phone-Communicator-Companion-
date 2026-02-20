// Views/DiagnosticsButton.swift
import SwiftUI

struct DiagnosticsButton: View {
    @ObservedObject var vm: CarDetailVM

    var body: some View {
        Button(action: { vm.requestDiagnostics() }) {
            HStack {
                Image(systemName: "waveform.path.ecg")
                Text("Run Diagnostics")
                    .font(.headline)
                Spacer()
                Image(systemName: "arrow.clockwise")
            }
            .padding()
            .foregroundColor(.white)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.teal]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(14)
        }
    }
}
