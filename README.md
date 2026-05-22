# Wireless Phone Communicator Companion

SwiftUI proof-of-concept companion app for Bluetooth OBD-II vehicle informatics.

The app simulates pairing with a Bluetooth OBD-II adapter and displays real-time vehicle data such as speed, RPM, coolant temperature, throttle position, voltage, fuel/energy level, and diagnostic trouble code status. It is intended as a mobile companion concept for reading vehicle data from the OBD-II port.

## Features

- Vehicle selection screen
- Simulated Bluetooth OBD-II pairing state
- Live telemetry stream with repeating updates
- OBD-style PID dashboard
- Diagnostic trouble code scan action
- ICE, hybrid, diesel, and EV sample vehicles
- Health cards for energy level, temperature, engine status, and tires

## Repository Layout

```text
WirelessCanCommunicator/
  Models/
  ViewModels/
  Views/
  Resources/
```

## Proof-of-Concept Scope

This version simulates Bluetooth and OBD-II data locally. A production version would replace `CarDetailVM`'s timer-driven telemetry with a CoreBluetooth service that pairs to an ELM327-compatible adapter, sends OBD-II PID requests, parses responses, and updates the same dashboard state.

## Build

Open the app in Xcode as a SwiftUI iOS project and run it on a simulator or device. If Xcode project metadata is missing locally, create a new SwiftUI iOS app target and add the files in `WirelessCanCommunicator/`.
