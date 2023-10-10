//
//  InfoView.swift
//  Speedometer
//
//  Created by Matt Sullivan on 13/10/2023.
//

import SwiftUI

struct InfoView: View {
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                .fill(Color(.systemGray6))
            
            VStack(alignment: .leading) {
                HStack {
                    infoWidget(content: Date().formatted(date: .omitted, time: .shortened))
                        .padding(.trailing)
                    batteryWidget(batteryLevel: Int(round(UIDevice.current.batteryLevel * 100)))
                }
                .padding(.bottom)
                infoWidget(content: Date().formatted(date: .abbreviated, time: .omitted))
            }
            .padding()
        }
    }
}

struct infoWidget: View {
    var content: String
    var image: String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                .fill(Color(.systemGray4))
            
            HStack {
                if let imageName = image {
                    Image(systemName: imageName)
                        .foregroundStyle(.cyan)
                        .font(.largeTitle)
                }
                Text(content)
                    .fontWeight(.bold)
                    .font(.system(size: 28))
            }
        }
        .fontDesign(.rounded)
        .frame(height: 80)
    }
}

struct batteryWidget: View {
    var batteryLevel: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                .fill(Color(.systemGray4))
            
            Image(systemName: "battery.0percent")
                .resizable()
                .frame(width: 105, height: 50)
                .foregroundColor(Color.cyan)
            
            Text("\(100)")
                .fontWeight(.bold)
                .padding(.trailing, 12)
                .font(.system(size: 28))
        }
        .fontDesign(.rounded)
        .frame(height: 80)
    }
}

#Preview {
    InfoView()
}
