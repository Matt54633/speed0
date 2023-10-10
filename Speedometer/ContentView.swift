//
//  ContentView.swift
//  Speedometer
//
//  Created by Matt Sullivan on 10/10/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var state = appState()
    
    var body: some View {
        Home().environmentObject(state)
    }
}

#Preview {
    ContentView()
}
