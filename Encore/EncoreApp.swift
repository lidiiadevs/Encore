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
    
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainTabView()
            } else {
                OnBoardingView()
            }
        }
        .modelContainer(for: Show.self)
    }
}
