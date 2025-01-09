
//
// FILE          : BookClub
// PROJECT       : PROG3230 - Assignment #2
// PROGRAMMER    : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION   : This file defines the BookClub struct, which represents a book club with various properties
//

import Foundation
import SwiftUI
import CoreLocation

struct BookClub: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var library: String
    var book: String
    var author: String
    var date: String
    var time: String
    var description: String
    var isMyClub: Bool
    var attendees: [String]
    var theme: Theme
    var note: String
    var bookmarkPage: Int
    
    // convert bookmarkPage to Double for slider usage
    var pagesAsDouble: Double {
        get {
            Double(bookmarkPage)
        }
        set {
            bookmarkPage = Int(newValue)
        }
    }
    
    // get the Image based on imageName
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    // get the CLLocationCoordinate2D from coordinates
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

