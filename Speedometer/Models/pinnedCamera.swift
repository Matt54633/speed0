//
//  pinnedCamera.swift
//  Speedometer
//
//  Created by Matt Sullivan on 20/12/2023.
//

import Foundation
import SwiftData

@Model
final class PinnedCamera: Identifiable {
    var id: String = ""
    var creationDate: Date = Date()
    var long: Double = 0
    var lat: Double = 0
    var heading: Double = 0
    
    init(long: Double, lat: Double, heading: Double) {
        self.id = UUID().uuidString
        self.creationDate = Date()
        self.long = long
        self.lat = lat
        self.heading = heading
    }
}
