//
//  DigitalSpeedo.swift
//  Speedometer
//
//  Created by Matt Sullivan on 10/10/2023.
//

import SwiftUI

struct DigitalSpeedo: View {
    @ObservedObject var locationManager = LocationManager()
    let maxSpeed: CGFloat = 100.0
    
    var body: some View {
        ZStack {
            VStack() {
                Text(locationManager.speed)
                    .font(.system(size: 180, weight: .bold, design: .default))
                    .foregroundStyle(.orange.gradient)
                Text("Miles Per Hour")
                    .font(.system(.body, design: .monospaced))
                    .bold()
            }
            
        }
        .frame(height: 300)
        .containerRelativeFrame(.vertical)
    }
}

#Preview {
    DigitalSpeedo()
}
