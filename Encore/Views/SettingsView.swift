//
//  SettingsView.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 6/26/26.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Query private var allShows: [Show]
    @State private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Your Stats") {
                    LabeledContent("Shows Attended", value: ("\(viewModel.attendedCount(allShows))"))
                    LabeledContent("Upcoming", value: ("\(viewModel.upcomingCount(allShows))"))
                    LabeledContent("Seen This Year", value: ("\(viewModel.seenThisYear(allShows))"))
                    if let topArtist = viewModel.topArtists(allShows) {
                        LabeledContent("Most Seen Artist", value: topArtist)
                    }
                }
                Section("Notifications") {
                    Toggle("Show Reminders", isOn: Binding(get: { viewModel.notificationsEnabled }, set: { enabled in
                        if enabled {
                            viewModel.requestNotificationPermission()
                        }
                    }))
                }
                Section("Your Data") {
                    ShareLink(item: viewModel.exportText(allShows)) {
                        Label("Export History", systemImage: "square.and.arrow.up")
                    }
                    .disabled(allShows.isEmpty)
                }
                Section("App") {
                    LabeledContent("Version", value: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0") //getting app version info
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                viewModel.checkNotificationStatus()
            }
        }
    }
}

#Preview {
    SettingsView()
}
