//
//  NeonSpeedo.swift
//  Speedometer
//
//  Created by Matt Sullivan on 11/10/2023.
//

import SwiftUI

struct NeonSpeedo: View {
    @ObservedObject var locationManager = LocationManager()
    let maxSpeed: CGFloat = 100.0
    
    var body: some View {
        ZStack {
            
            Circle()
                .fill(Color(red: 56/255, green: 65/255, blue: 82/255, opacity: 1.0))
            
            Circle()
                .stroke(.teal, lineWidth: 4)
            
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(.teal.opacity(0.3), lineWidth: 10)
                .rotationEffect(.degrees(135))
                .frame(width: 287)
            
            
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(.teal, style: StrokeStyle(lineWidth: 20, lineCap: .butt, lineJoin: .round, dash: [3, 33], dashPhase: 0.0))
                .rotationEffect(.degrees(135))
                .frame(width: 276)
            
            if let float = Float(locationManager.speed) {
                let speedRatio = min(CGFloat(float) / maxSpeed, 1.0)
                
                Circle()
                    .trim(from: 0, to: 0.75 * speedRatio)
                    .stroke(.teal, lineWidth: 5)
                    .rotationEffect(.degrees(135))
                    .frame(width: 255)
                    .animation(.easeIn, value: speedRatio)
            }
            
            VStack {
                Text(locationManager.speed)
                    .font(.system(size: 100, weight: .bold, design: .monospaced))
                    .foregroundStyle(.teal)
                Text("MPH")
                    .font(.system(size: 16, design: .monospaced))
                    .italic()
                    .bold()
                    .foregroundStyle(.teal)
                if locationManager.isCalculatingAverageSpeed {
                    Text(locationManager.averageSpeed)
                }
            }
            
        }
        .frame(width: 300, height: 300)
        .containerRelativeFrame(.vertical)
    }
}

#Preview {
    NeonSpeedo()
}

