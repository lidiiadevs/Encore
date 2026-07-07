//
//  ShowDetailView.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 7/7/26.
//

import SwiftUI
import SwiftData

struct ShowDetailView: View {
    @Bindable var show : Show
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showingEditSheet = false
    @State private var showingDeleteAlert = false
    @State private var newSetlistEntry = ""
    
    var body: some View {
        List {
            Section("Show Info") {
                LabeledContent("Artist", value: show.artistName) // LabeledContennt is available in iOS 17
                LabeledContent("Venue", value: show.venueName)
                LabeledContent("City", value: show.city)
                LabeledContent("Date", value: show.date.formatted(date: .long, time: .omitted))
                LabeledContent("Status", value: show.status.rawValue.capitalized) //bc we use enum its rawValue - String
            }
            
            if show.status == .attended {
                Section("Rating") {
                    StarRatingView(rating: Binding(get: { show.rating ?? 0 },
                                                   set: { show.rating = $0 > 0 ? $0 : nil }))
                    //because rating is optional we use get and set
                }
            }
            
            Section("Notes") {
                if let notes = show.notes,
                   !notes.isEmpty {
                    Text(notes)
                } else {
                    Text("No notes added")
                        .foregroundStyle(.secondary)
                }
            }
            
            Section("Setlist") {
                if show.setlist.isEmpty {
                    Text("No songs added")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(show.setlist.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1)")
                                .foregroundStyle(.secondary)
                                .frame(width: 28, alignment: .leading)
                            Text(show.setlist[index])
                        }
                    }
                    .onDelete { indexSet in
                        show.setlist.remove(atOffsets: indexSet)
                    }
                    .onMove { source, destination in
                        show.setlist.move(fromOffsets: source, toOffset: destination)
                    }
                }
                HStack {
                    TextField("Add sing", text: $newSetlistEntry)
                    Button("Add") {
                        let trimmed = newSetlistEntry.trimmingCharacters(in: .whitespaces)
                        guard !trimmed.isEmpty else { return }
                        show.setlist.append(trimmed)
                        newSetlistEntry = ""
                    }
                    .disabled(newSetlistEntry.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
//        .toolbar {
//            ToolbarItem()
//        }
    }
}

#Preview {
    ShowDetailView(show: Show(artistName: "dfg", venueName: "sgffg", city: "sgf", date: Date(), status: .attended))
}
