//
//  ContentView.swift
//  WirelessCanCommunicator
//
//  Created by Kaleb Key on 12/14/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vehicleListVM = VehicleListVM()

    var body: some View {
        MainView()
            .environmentObject(vehicleListVM)
    }
}

#Preview {
    ContentView()
        .environmentObject(VehicleListVM())
}
