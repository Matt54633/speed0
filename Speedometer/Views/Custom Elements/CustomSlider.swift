//
//  CustomSlider.swift
//  Speedometer
//
//  Created by Matt Sullivan on 12/10/2023.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    var inRange: ClosedRange<Double>
    
    var body: some View {
        GeometryReader { geometry in
            let trackWidth = geometry.size.width - 22
            let trackX = (trackWidth * CGFloat(value - inRange.lowerBound) / CGFloat(inRange.upperBound - inRange.lowerBound))
            
            ZStack(alignment: .center) {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: trackWidth, y: 0))
                    path.addLine(to: CGPoint(x: trackWidth - 10, y: 12))
                    path.addLine(to: CGPoint(x: -10, y: 12))
                    path.closeSubpath()
                }
                .fill(Color.gray.opacity(0.5))
                
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: trackX, y: 0))
                    path.addLine(to: CGPoint(x: trackX - 10, y: 12)) // Adjust the angle by changing the y value
                    path.addLine(to: CGPoint(x: -10, y: 12)) // Adjust the angle by changing the y value
                    path.closeSubpath()
                }
                .fill(Color.cyan)
            }
            .padding(.horizontal)
        }
    }
    
}



//#Preview {
//    CustomSlider()
//}
