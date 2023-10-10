//
//  Home.swift
//  Speedometer
//
//  Created by Matt Sullivan on 11/10/2023.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        VStack() {
            SpeedoCarousel()
            ControlCarousel()
            WidgetCarousel()
        }
        .ignoresSafeArea(edges: [.leading, .trailing, .bottom])
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

#Preview {
    Home()
}
