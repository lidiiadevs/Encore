//
//  EncoreApp.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 6/26/26.
//

import SwiftUI
import SwiftData

@main
struct EncoreApp: App {
    var body: some Scene {
        WindowGroup {
            AttendedView()
        }
        .modelContainer(for: Show.self)
    }
}
