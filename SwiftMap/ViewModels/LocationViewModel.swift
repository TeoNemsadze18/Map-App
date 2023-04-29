//
//  LocationViewModel.swift
//  SwiftMap
//
//  Created by teona nemsadze on 06.03.23.
//

import Foundation
import MapKit
import SwiftUI
 
class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    
    
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    
    @Published var mapRegion: MKCoordinateRegion =  MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // show list of location
    @Published var showLocationList: Bool = false
    
    /// show location detail via sheet
    @Published var sheetLocation: Location? = nil 
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
        mapRegion = MKCoordinateRegion(
            center: location.coordinates,
            span: mapSpan)
        }
    }
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList = !showLocationList
        }
    }
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false 
        }
    }
    
    func nextButtonPressed() {
        
        //get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current index in locations array! Should never happen.")
            return
        }
        
        //Check if the currentIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            //Next index is not valid
            //restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        //Next index IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
 







