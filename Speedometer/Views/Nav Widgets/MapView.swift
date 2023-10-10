//
//  MapView.swift
//  Speedometer
//
//  Created by Matt Sullivan on 10/10/2023.
//

import SwiftUI
import SwiftData
import MapKit
import AVFoundation


struct MapView: View {
    @State private var player: AVAudioPlayer?
    @Query private var pins: [PinnedCamera]
    @Namespace var mapScope
    @State private var position: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    @State private var savedCoordinate: CLLocationCoordinate2D?
    @ObservedObject var locationManager = LocationManager()
    @State private var showText: Bool = false
    @Environment(\.modelContext) private var context
    @State private var soundPlayed: Bool = false // Track if the sound has been played
    @State private var lastPlayedTime: [Date?] = [] // Track the last time the sound was played for each camera
        let cooldownDuration: TimeInterval = 45 // Cooldown duration in seconds


    
    var body: some View {
        ZStack {
            Map(position: $position, bounds: MapCameraBounds(minimumDistance: 100, maximumDistance: 500), interactionModes: [.zoom, .pitch, .rotate], scope: mapScope) {
                
                ForEach(pins, id: \.self) { pin in
                    Marker("Speed Camera", systemImage: "camera.aperture", coordinate: CLLocationCoordinate2D(latitude: pin.lat, longitude: pin.long))
                        .tint(.orange)
                }
            }
            .mapStyle(.standard(elevation: .realistic, showsTraffic: true))
            .cornerRadius(25)
            .tint(Color(.blue))
            .mapControlVisibility(.hidden)
            .overlay(alignment: .topTrailing) {
                MapUserLocationButton(scope: mapScope)
                    .buttonBorderShape(.circle)
                    .padding(7.5)
                
            }
            .mapScope(mapScope)
            
            if showText {
                HStack {
                    Image(systemName: "camera.aperture")
                    Text("Speed Camera")
                        .fontWeight(.semibold)
                }
                .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                .background(Color.orange)
                .clipShape(Capsule())
                .fontDesign(.rounded)
                .font(.title3)
                .padding(.top, 225)
                .transition(.scale)
            }
        }
        .onReceive(locationManager.$userCoordinate.combineLatest(locationManager.$userHeading)) { userCoordinate, userHeading in
            checkDistanceFromPins(userCoordinate: userCoordinate, userHeading: userHeading)
        }
    }
    
    func playSound() {
            guard let soundURL = Bundle.main.url(forResource: "camera_alert", withExtension: "wav") else {
                return
            }
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                try AVAudioSession.sharedInstance().setActive(true)
                
                player = try AVAudioPlayer(contentsOf: soundURL)
                player?.play()
            } catch {
                print("Failed to load or play the sound: \(error)")
            }
        }
       
       func initializeLastPlayedTimeArrayIfNeeded() {
           if lastPlayedTime.isEmpty {
               lastPlayedTime = Array(repeating: nil, count: pins.count)
           }
       }
       
       func checkDistanceFromPins(userCoordinate: CLLocationCoordinate2D?, userHeading: CLHeading?) {
           guard let userCoordinate = userCoordinate, let userHeading = userHeading else { return }
           
           let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
           var shouldShowText = false

           initializeLastPlayedTimeArrayIfNeeded()
           
           for (index, pin) in pins.enumerated() {
               let pinLocation = CLLocation(latitude: pin.lat, longitude: pin.long)
               let distance = userLocation.distance(from: pinLocation)
               
               if distance <= 200 {
                   let bearingDifference = abs(pin.heading - userHeading.trueHeading)
                   let roughDirectionThreshold: Double = 50
                   
                   if bearingDifference <= roughDirectionThreshold {
                       shouldShowText = true
                       let currentTime = Date()
                       
                       if let lastPlayed = lastPlayedTime[index], currentTime.timeIntervalSince(lastPlayed) >= cooldownDuration {
                           playSound()
                           lastPlayedTime[index] = currentTime
                       } else if lastPlayedTime[index] == nil {
                           playSound()
                           lastPlayedTime[index] = currentTime
                       }
                   }
               }
           }
           
           withAnimation {
               showText = shouldShowText
           }
           
//           if !shouldShowText {
//               lastPlayedTime = Array(repeating: nil, count: pins.count)
//           }
       }

}

#Preview {
    MapView()
}
