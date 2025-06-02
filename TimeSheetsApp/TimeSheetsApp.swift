//
//  TimeSheetsApp.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI
import SwiftData

@main
struct TimeSheetsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self,
            Project.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TimersListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
