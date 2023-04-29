//
//  SwiftMapApp.swift
//  SwiftMap
//
//  Created by teona nemsadze on 06.03.23.
//

import SwiftUI

@main
struct SwiftMapApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
            //ContentView()
        }
    }
}
