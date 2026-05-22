import SwiftUI

extension Color {
    static let dashboardBackground = Color(red: 0.94, green: 0.96, blue: 0.98)
    static let cardBackground = Color.white
    static let cardBorder = Color(red: 0.83, green: 0.88, blue: 0.93)
    static let primaryText = Color(red: 0.08, green: 0.12, blue: 0.18)
    static let mutedText = Color(red: 0.38, green: 0.45, blue: 0.54)
    static let accentBlue = Color(red: 0.05, green: 0.36, blue: 0.72)
    static let safetyGreen = Color(red: 0.10, green: 0.55, blue: 0.33)
    static let warningAmber = Color(red: 0.82, green: 0.48, blue: 0.10)
}

extension View {
    func dashboardCard() -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.cardBorder, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct PrimaryVehicleButtonStyle: ButtonStyle {
    var active = true

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.weight(.bold))
            .padding(.vertical, 12)
            .foregroundColor(.white)
            .background(active ? Color.accentBlue : Color.warningAmber)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .opacity(configuration.isPressed ? 0.78 : 1)
    }
}

struct SecondaryVehicleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.weight(.bold))
            .padding(.vertical, 12)
            .foregroundColor(.accentBlue)
            .background(Color.accentBlue.opacity(0.10))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .opacity(configuration.isPressed ? 0.78 : 1)
    }
}
