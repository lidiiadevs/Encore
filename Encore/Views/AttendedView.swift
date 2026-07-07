//
//  ContentView.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 6/26/26.
//

import SwiftUI
import SwiftData

//VM - business logic and state, no UI layout
//V - are layout and gesture only. No data fetching


struct AttendedView: View {
    @Query(sort: \Show.date, order: .reverse) private var allShows: [Show]
    @Environment(\.modelContext) private var modelContext
    
    @State private var viewModel = AttendedViewModel()
    
    var body: some View {
        @Bindable var vm = viewModel
        
        NavigationStack {
            Group {
                if viewModel.filteredShows(allShows).isEmpty {
                    ContentUnavailableView("No Results", systemImage: "magnifyingglass")
                } else {
                    List {
                        ForEach(viewModel.filteredShows(allShows)) {
                            show in
                            NavigationLink(value: show) {
                                ShowRowView(show: show)
                            }
                        }
                        .onDelete {
                            indexSet in
                            let shows = viewModel.filteredShows(allShows)
                            for index in indexSet {
                                viewModel.delete(shows[index], context: modelContext)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Attended")
            .searchable(text: $vm.searchText, prompt: "Artists, Venues, Cities")
            .navigationDestination(for: Show.self) { show in
                ShowDetailView(show: show)
            }
            .toolbar {
                Button("Add Show", systemImage: "plus") {
                    viewModel.showingAddSheet = true
                }
            }
            .sheet(isPresented: $vm.showingAddSheet) {
                AddEditShowView(initialStatus: .attended)
            }
        }
    }
}

#Preview {
    AttendedView()
}
