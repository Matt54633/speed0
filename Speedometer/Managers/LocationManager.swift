//
//  LocationManager.swift
//  Speedometer
//
//  Created by Matt Sullivan on 10/10/2023.
//

import CoreLocation
import Combine
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var speed: String = "?" {
        willSet { objectWillChange.send() }
    }
    
    @Published var speedAccuracy: String = "?" {
        willSet { objectWillChange.send() }
    }
    
    @Published var isCalculatingAverageSpeed: Bool = false {
        willSet { objectWillChange.send() }
    }
    
    @Published var averageSpeed: String = "?" {
        willSet { objectWillChange.send() }
    }
    
    @Published var userCoordinate: CLLocationCoordinate2D? {
        willSet { objectWillChange.send() }
    }
    
    @Published var userHeading: CLHeading? {
        willSet { objectWillChange.send() }
    }
    
    
    private var startDate: Date?
    private var startLocation: CLLocation?
    private var totalDistance: CLLocationDistance = 0.0
    
    override init() {
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
}

extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        if location.speedAccuracy >= 0 {
            let speedMetersPerSecond: Double = location.speed
            let speedMilesPerHour: Double = 2.23694 * speedMetersPerSecond
            
            self.speed = String(format: "%.0f", speedMilesPerHour)
            self.speedAccuracy = String(format: "%.1f", 2.23694 * location.speedAccuracy)
            
            if isCalculatingAverageSpeed {
                updateAverageSpeed(with: location)
            }
            
            self.userCoordinate = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.userHeading = newHeading
    }
    
    private func updateAverageSpeed(with location: CLLocation) {
        guard let startLocation = self.startLocation else {
            self.startLocation = location
            self.startDate = location.timestamp
            return
        }
        
        totalDistance = location.distance(from: startLocation)
        let timeElapsed = location.timestamp.timeIntervalSince(startDate ?? Date())
        
        if timeElapsed > 0 {
            let averageSpeedMetersPerSecond = totalDistance / timeElapsed
            let averageSpeedMilesPerHour = 2.23694 * averageSpeedMetersPerSecond
            self.averageSpeed = String(format: "%.0f", averageSpeedMilesPerHour)
        }
    }
    
    func toggleAverageSpeedCalculation() {
        isCalculatingAverageSpeed.toggle()
        if isCalculatingAverageSpeed {
            startDate = nil
            startLocation = nil
            totalDistance = 0.0
            averageSpeed = "?"
        }
    }
}
