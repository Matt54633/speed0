//
//  NewSpeedo.swift
//  Speedometer
//
//  Created by Matt Sullivan on 10/10/2023.
//

import SwiftUI

struct SportSpeedo: View {
    @ObservedObject var locationManager = LocationManager()
    let maxSpeed: CGFloat = 100.0
    
    var body: some View {
        ZStack {
            
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(.gray, lineWidth: 10)
                .rotationEffect(.degrees(135))
            
            if let float = Float(locationManager.speed) {
                let speedRatio = min(CGFloat(float) / maxSpeed, 1.0)
                Circle()
                    .trim(from: 0, to: 0.75 * speedRatio)
                    .stroke(.red, lineWidth: 15)
                    .rotationEffect(.degrees(135))
                    .animation(.easeIn, value: speedRatio)
            }
            
            VStack {
                Text(locationManager.speed)
                    .font(.system(size: 100, weight: .bold, design: .monospaced))
                    .foregroundStyle(.red)
                Text("MPH")
                    .font(.system(.body, design: .monospaced))
                    .italic()
                    .bold()
                    .foregroundStyle(.gray)
            }
            
        }
        .frame(width: 300, height: 300)
        .containerRelativeFrame(.vertical)
    }
}

#Preview {
    SportSpeedo()
}
