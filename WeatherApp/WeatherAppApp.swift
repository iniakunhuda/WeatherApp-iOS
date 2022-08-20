//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Miftahul Huda on 20/08/22.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
