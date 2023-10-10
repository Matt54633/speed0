//
//  SpeedometerApp.swift
//  Speedometer
//
//  Created by Matt Sullivan on 10/10/2023.
//

import SwiftUI
import SwiftData

@main
struct SpeedometerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: PinnedCamera.self)
    }
}
