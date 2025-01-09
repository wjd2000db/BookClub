// FILE : MapView.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION : This file completes the UI view with MapKit; the map is completed with the book club location coordinates of latitude and longitude information.

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    
    var body: some View {
        Map(position: .constant(.region(region))) {
            Marker("",coordinate: coordinate)
        }
    }
    
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.07)
        )
    }
}


#Preview {
    MapView(coordinate: CLLocationCoordinate2D(latitude: 43.4660, longitude: -80.5220))
}
