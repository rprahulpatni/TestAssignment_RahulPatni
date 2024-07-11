//
//  LocationModel.swift
//  IOS_Demo_SwiftUI
//

import Foundation
import SwiftUI
import CoreLocation

struct LocationData: Hashable, Codable, Identifiable {
    var id: Int
    var category: String
    var name: String
    var city: String
    var state: String
    var country: String
    var description: String
    var imageUrl: String
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}

enum Category: String, CaseIterable, Codable {
    case Lakes, Valleys, HotSprings, Canyons, Bays, Mountains, Waterfalls, Volcanoes, Wetlands
}
