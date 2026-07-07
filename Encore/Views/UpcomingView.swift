//
//  UpcomingView.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 6/26/26.
//

import SwiftUI
import SwiftData

struct UpcomingView: View {
    @Query(sort: \Show.date) private var allShows: [Show]
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = UpcomingViewModel()
    
    var body: some View {
        @Bindable var vm = viewModel
        
        NavigationStack {
            Group {
                if viewModel.filteresShows(allShows).isEmpty {
                    ContentUnavailableView("No Upcoming Shows", systemImage: "calendar")
                } else {
                    List {
                        ForEach(viewModel.filteresShows(allShows)) { show in
                            NavigationLink(value: show) {
                                ShowRowView(show: show)
                            }
                            .swipeActions(edge: .leading) {
                                Button("Attend") {
                                    viewModel.showToMarkAttended = show
                                }
                                    .tint(.green)
                            }
                        }
                        .onDelete { indexSet in
                           let shows =
                            viewModel.filteresShows(allShows)
                            for index in indexSet {
                                viewModel.delete(shows[index], context: modelContext)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Upcoming")
            .navigationDestination(for: Show.self) { show in
                ShowDetailView(show: show)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add show", systemImage: "plus") {
                        viewModel.showingAddSheet = true
                    }
                }
            }
            .sheet(isPresented: $vm.showingAddSheet) {
                AddEditShowView(initialStatus: .upcoming)
            }
            .sheet(item: $vm.showToMarkAttended) { //this takes optional binding
                show in
                MarkAttendedSheet(show: show, viewModel: $viewModel)
            }
        }
    }
}

#Preview {
    UpcomingView()
        .modelContainer(for: Show.self, inMemory: true)
}
