//
//  AvgSpeedView.swift
//  Speedometer
//
//  Created by Matt Sullivan on 20/12/2023.
//

import SwiftUI

struct AvgSpeedView: View {
    @ObservedObject var locationManager = LocationManager()
    @State private var isSheetPresented = false
    @State private var buttonTint: Color = .blue
    @State private var showDetails = false
    
    var body: some View {
        HStack {
            Button(action: {
                locationManager.toggleAverageSpeedCalculation()
                isSheetPresented.toggle()
                if buttonTint == .blue {
                    buttonTint = .red
                } else {
                    buttonTint = .blue
                }
                withAnimation {
                    showDetails.toggle()
                }
                
            }) {
                if !locationManager.isCalculatingAverageSpeed {
                    Image(systemName: "gauge.with.dots.needle.bottom.50percent.badge.plus")
                } else {
                    Image(systemName: "gauge.with.dots.needle.bottom.50percent.badge.minus")
                }
            }
            .tint(buttonTint)
            .buttonBorderShape(.circle)
            .buttonStyle(.borderedProminent)
            
            if showDetails {
                Text("\(locationManager.averageSpeed) MPH")
                    .frame(width: 200, height: 50)
                    .background(.purple)
                    .fontWeight(.bold)
                    .clipShape(Capsule())
                    .transition(.scale)
                    .fontDesign(.rounded)
            }
            
        }
        .font(.system(size: 28))
    }
}


#Preview {
    AvgSpeedView()
}
