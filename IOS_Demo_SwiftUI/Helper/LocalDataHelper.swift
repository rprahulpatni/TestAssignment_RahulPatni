//
//  LocalDataHelper.swift
//  IOS_Demo_SwiftUI
//

import Foundation

struct BundleDecoderFromJson {
    static func decodeLandmarkFromBundleToJson() -> [LocationData] {
        let landmarkJson = Bundle.main.path(forResource: "LocalLocation", ofType: "json")
        let landmarks = try! Data(contentsOf: URL(fileURLWithPath: landmarkJson!), options: .alwaysMapped)
        return try! JSONDecoder().decode([LocationData].self, from: landmarks)
    }
}
