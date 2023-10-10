//
//  AddCameraView.swift
//  Speedometer
//
//  Created by Matt Sullivan on 20/12/2023.
//

import SwiftUI
import SwiftData
import MapKit

struct AddCameraView: View {
    @ObservedObject var locationManager = LocationManager()
    @Environment(\.modelContext) private var context
    
    var body: some View {
        HStack {            
                Button(action: {
                    if let coordCenter = locationManager.userCoordinate, let heading = locationManager.userHeading {
                        savePin(savedCoordinate: coordCenter, userHeading: heading)
                    }
                }) {
                    Image(systemName: "camera.aperture")
                        .padding(1)
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.borderedProminent)
                .tint(.orange)
        }
        .font(.system(size: 28))
    }
    
    func savePin(savedCoordinate: CLLocationCoordinate2D, userHeading: CLHeading) {
        let headingValue = userHeading.trueHeading
        
        let pin = PinnedCamera(long: savedCoordinate.longitude, lat: savedCoordinate.latitude, heading: headingValue)
        
        context.insert(pin)
    }
}


#Preview {
    AddCameraView()
}
