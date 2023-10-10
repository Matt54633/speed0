//
//  DefaultSpeedo.swift
//  Speedometer
//
//  Created by Matt Sullivan on 10/10/2023.
//

import SwiftUI

struct DefaultSpeedo: View {
    @ObservedObject var locationManager = LocationManager()
    let maxSpeed: CGFloat = 100.0
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(Color(.systemGray6))
            
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(.blue, style: StrokeStyle(lineWidth: 7.36, lineCap: .butt, lineJoin: .round, dash: [3, 30], dashPhase: 0.0))
                .rotationEffect(.degrees(135))
            
            if let float = Float(locationManager.speed) {
                let speedRatio = min(CGFloat(float) / maxSpeed, 1.0)
                Circle()
                    .trim(from: 0, to: 0.75 * speedRatio)
                    .stroke(.white, lineWidth: 10)
                    .rotationEffect(.degrees(135))
                    .animation(.easeIn, value: speedRatio)
            }
            
            VStack {
                Text(locationManager.speed)
                    .font(.system(size: 100, weight: .bold, design: .rounded))
                    .foregroundStyle(.blue)
                Text("MPH")
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .foregroundStyle(.gray)
            }
            
        }
        .frame(width: 300, height: 300)
        .containerRelativeFrame(.vertical)
    }
}

#Preview {
    DefaultSpeedo()
}
